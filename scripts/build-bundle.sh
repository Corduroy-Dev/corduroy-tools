#!/usr/bin/env bash
# scripts/build-bundle.sh — produces customer-facing delivery artifacts
#
# Outputs (in dist/):
#   1. corduroy-tools-v<VERSION>.zip       — full marketplace bundle (Claude Code CLI install)
#   2. corduroy-tools-v<VERSION>-cowork/   — directory of 20 per-plugin zips (Cowork upload)
#   3. SHA256SUMS                            — checksums for all artifacts
#
# Run scripts/verify-bundle.sh after this to gate delivery.

set -euo pipefail

cd "$(dirname "$0")/.."

VERSION=$(jq -r '.version' .claude-plugin/marketplace.json)
[ -n "$VERSION" ] && [ "$VERSION" != "null" ] || { echo "FAIL: marketplace.json has no version" >&2; exit 1; }

DIST="dist"
MARKETPLACE_ZIP="$DIST/corduroy-tools-v${VERSION}.zip"
COWORK_DIR="$DIST/corduroy-tools-v${VERSION}-cowork"

rm -rf "$DIST"
mkdir -p "$DIST" "$COWORK_DIR"

# ---- 1. Marketplace zip (Claude Code CLI install) ----
echo "→ Building marketplace zip..."
# Run from repo root so paths inside the zip are relative to the marketplace root.
zip -rq "$MARKETPLACE_ZIP" . \
  -x '.git/*' \
  -x 'dist/*' \
  -x 'scripts/build-bundle.sh' \
  -x 'scripts/verify-bundle.sh' \
  -x 'scripts/bump-versions.sh' \
  -x '*.zip' '*.sha256' 'SHA256SUMS' \
  -x '.DS_Store'
echo "   wrote $MARKETPLACE_ZIP"

# ---- 2. Per-plugin zips (Cowork upload) ----
# Cowork expects the .claude-plugin/plugin.json at the zip root.
# We zip each plugin directory's contents (no parent path inside the zip).
echo "→ Building per-plugin zips for Cowork upload..."
count=0
while IFS= read -r plugin_json; do
  # plugin_json looks like:
  #   ./plugins/agent-plugins/pitch-agent/.claude-plugin/plugin.json
  #   ./claude-for-msft-365-install/.claude-plugin/plugin.json
  plugin_dir=$(dirname "$(dirname "$plugin_json")")
  plugin_name=$(jq -r '.name' "$plugin_json")
  [ -n "$plugin_name" ] && [ "$plugin_name" != "null" ] || { echo "FAIL: no name in $plugin_json" >&2; exit 1; }

  out="$COWORK_DIR/corduroy-${plugin_name}-v${VERSION}.zip"
  # Use -j? No — we need directory structure preserved (skills/, commands/, etc.).
  # The trick: cd into the plugin dir and zip "." so paths in the zip are
  # relative to the plugin root.
  ( cd "$plugin_dir" && zip -rq "$OLDPWD/$out" . \
      -x '*.DS_Store' -x '.git/*' )
  size=$(du -h "$out" | cut -f1)
  echo "   wrote $out ($size)"
  count=$((count + 1))

  # Cowork's 50 MB limit per zip
  size_bytes=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out" 2>/dev/null)
  if [ "$size_bytes" -gt 52428800 ]; then
    echo "FAIL: $out exceeds Cowork's 50 MB upload limit ($size_bytes bytes)" >&2
    exit 1
  fi
done < <(find . -path '*/.claude-plugin/plugin.json' -not -path './.claude-plugin/*' -not -path './dist/*' | sort)

echo "   $count per-plugin zips built"

# ---- 3. Checksums ----
echo "→ Computing checksums..."
( cd "$DIST" && {
    sha256sum "corduroy-tools-v${VERSION}.zip"
    find "corduroy-tools-v${VERSION}-cowork" -name '*.zip' -print0 | sort -z | xargs -0 sha256sum
  } > SHA256SUMS )
echo "   wrote $DIST/SHA256SUMS"

echo ""
echo "Build complete. Run scripts/verify-bundle.sh next."
echo "Marketplace zip: $MARKETPLACE_ZIP"
echo "Cowork zips:     $COWORK_DIR/ ($count files)"
