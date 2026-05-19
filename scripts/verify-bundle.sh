#!/usr/bin/env bash
# scripts/verify-bundle.sh — gates delivery; asserts ~25 invariants.
# Run after scripts/build-bundle.sh. Exits non-zero on ANY failure.

set -euo pipefail

cd "$(dirname "$0")/.."

VERSION=$(jq -r '.version' .claude-plugin/marketplace.json)
DIST="dist"
MARKETPLACE_ZIP="$DIST/corduroy-plugins-v${VERSION}.zip"
COWORK_DIR="$DIST/corduroy-plugins-v${VERSION}-cowork"

fail() { echo "FAIL: $1" >&2; exit 1; }
pass() { echo "  ✓ $1"; }

# Artifacts present
[ -f "$MARKETPLACE_ZIP" ] || fail "missing $MARKETPLACE_ZIP (did you run build-bundle.sh?)"
[ -d "$COWORK_DIR" ] || fail "missing $COWORK_DIR"
[ -f "$DIST/SHA256SUMS" ] || fail "missing $DIST/SHA256SUMS"
pass "build artifacts present"

# ---- Verify marketplace zip ----
echo "→ Verifying marketplace zip ($MARKETPLACE_ZIP)..."
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
unzip -q "$MARKETPLACE_ZIP" -d "$TMP"

# Required top-level files
for f in .claude-plugin/marketplace.json LICENSE NOTICE MODIFICATIONS.md README.md CLAUDE.md INSTALL.md; do
  [ -f "$TMP/$f" ] || fail "marketplace zip missing $f"
done
pass "required files present in marketplace zip"

# (Historical: spglobal LICENSE was required at v0.1.0. Removed in v0.2.0
# alongside the partner-built plugins themselves. Re-add this check if/when
# the partner plugins are reintroduced.)

# Marketplace metadata
MP_NAME=$(jq -r '.name' "$TMP/.claude-plugin/marketplace.json")
MP_OWNER=$(jq -r '.owner.name' "$TMP/.claude-plugin/marketplace.json")
MP_VERSION=$(jq -r '.version' "$TMP/.claude-plugin/marketplace.json")
[ "$MP_NAME" = "corduroy" ] || fail "marketplace.name=$MP_NAME (expected corduroy)"
[ "$MP_OWNER" = "Corduroy Intelligence" ] || fail "marketplace.owner.name=$MP_OWNER (expected Corduroy Intelligence)"
[ "$MP_VERSION" = "$VERSION" ] || fail "marketplace.version=$MP_VERSION (expected $VERSION)"
pass "marketplace.json metadata correct"

# Every plugin.json valid + Corduroy-authored + version-matched
count=0
while IFS= read -r f; do
  jq empty "$f" 2>/dev/null || fail "malformed JSON: $f"
  AUTH=$(jq -r '.author.name // "<missing>"' "$f")
  VER=$(jq -r '.version // "<missing>"' "$f")
  [ "$AUTH" = "Corduroy Intelligence" ] || fail "$f author=$AUTH (expected Corduroy Intelligence)"
  [ "$VER" = "$VERSION" ] || fail "$f version=$VER (expected $VERSION)"
  count=$((count + 1))
done < <(find "$TMP" -path '*/.claude-plugin/plugin.json' -not -path "$TMP/.claude-plugin/*" | sort)
[ "$count" -ge 18 ] || fail "expected >=18 plugin.json files in marketplace zip, got $count"
pass "$count plugin.json files: all valid, Corduroy-authored, version $VERSION"

# Branding sweep: no upstream strings leak into plugin/skill content.
# Attribution-purpose top-level docs (NOTICE, MODIFICATIONS, README, CLAUDE,
# INSTALL) are allowed to reference the upstream by name for Apache 2.0 §4
# attribution. Plugin-internal markdowns are not.
LEAKS=$(grep -rE 'Anthropic FSI|claude-for-financial-services|anthropics/financial-services' "$TMP" \
  --include='*.md' --include='*.json' \
  2>/dev/null \
  | grep -v -E "^$TMP/(NOTICE|MODIFICATIONS\.md|README\.md|CLAUDE\.md|INSTALL\.md):" \
  || true)
# "Anthropic FSI" must NEVER appear anywhere except MODIFICATIONS.md (which
# documents the rebrand). Check separately because it's the strongest signal
# we missed a rebrand target.
FSI_LEAKS=$(grep -rE 'Anthropic FSI' "$TMP" --include='*.md' --include='*.json' 2>/dev/null \
  | grep -v -E "^$TMP/MODIFICATIONS\.md:" || true)
if [ -n "$FSI_LEAKS" ]; then
  echo "$FSI_LEAKS" >&2
  fail "'Anthropic FSI' leaked outside MODIFICATIONS.md — missed rebrand target"
fi
if [ -n "$LEAKS" ]; then
  echo "$LEAKS" >&2
  fail "upstream branding strings leaked into plugin-internal content"
fi
pass "no upstream branding strings in plugin-internal content"

# ---- Verify per-plugin Cowork zips ----
echo "→ Verifying Cowork per-plugin zips..."
cowork_count=$(find "$COWORK_DIR" -name 'corduroy-*-v*.zip' | wc -l | tr -d ' ')
[ "$cowork_count" = "18" ] || fail "expected 18 Cowork plugin zips, got $cowork_count"
pass "$cowork_count Cowork plugin zips present"

# Spot-check one Cowork zip: must have plugin.json at .claude-plugin/plugin.json (zip root)
SPOT=$(find "$COWORK_DIR" -name 'corduroy-pitch-agent-v*.zip' | head -1)
[ -n "$SPOT" ] || fail "couldn't find Cowork zip for pitch-agent"
SPOT_TMP=$(mktemp -d)
unzip -q "$SPOT" -d "$SPOT_TMP"
[ -f "$SPOT_TMP/.claude-plugin/plugin.json" ] || fail "Cowork zip missing .claude-plugin/plugin.json at root (got $(ls $SPOT_TMP))"
SPOT_AUTH=$(jq -r '.author.name' "$SPOT_TMP/.claude-plugin/plugin.json")
[ "$SPOT_AUTH" = "Corduroy Intelligence" ] || fail "Cowork pitch-agent zip author=$SPOT_AUTH"
rm -rf "$SPOT_TMP"
pass "Cowork zip structure (spot-check on pitch-agent) is correct"

# Cowork 50 MB ceiling
while IFS= read -r z; do
  size=$(stat -c%s "$z" 2>/dev/null || stat -f%z "$z" 2>/dev/null)
  if [ "$size" -gt 52428800 ]; then
    fail "$z exceeds Cowork's 50 MB limit ($size bytes)"
  fi
done < <(find "$COWORK_DIR" -name '*.zip')
pass "all Cowork zips under 50 MB"

echo ""
echo "PASS: bundle verified ($count plugins, v$VERSION, marketplace zip + $cowork_count Cowork zips)"
