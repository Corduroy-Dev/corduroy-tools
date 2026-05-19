#!/usr/bin/env bash
# scripts/bump-versions.sh — single source of truth for plugin versions
# Usage: ./scripts/bump-versions.sh <version>
# Example: ./scripts/bump-versions.sh 0.1.0
#
# Rewrites .author and .version in every plugin.json under plugins/ and at
# claude-for-msft-365-install/, then bumps .version in the top-level
# marketplace.json. Refuses to touch malformed JSON.

set -euo pipefail

NEW_VERSION="${1:?usage: $0 <version>}"
AUTHOR='{"name":"Corduroy Intelligence","email":"mmoore@corduroyintelligence.com"}'

cd "$(dirname "$0")/.."

count=0
while IFS= read -r f; do
  if ! jq empty "$f" 2>/dev/null; then
    echo "SKIP (malformed JSON): $f" >&2
    continue
  fi
  tmp=$(mktemp)
  jq --arg v "$NEW_VERSION" --argjson a "$AUTHOR" \
    '.author = $a | .version = $v' "$f" > "$tmp"
  mv "$tmp" "$f"
  echo "bumped: $f -> $NEW_VERSION"
  count=$((count + 1))
done < <(find . -path '*/.claude-plugin/plugin.json' -not -path './.claude-plugin/*' | sort)

# Bump top-level marketplace.json version too
tmp=$(mktemp)
jq --arg v "$NEW_VERSION" '.version = $v' .claude-plugin/marketplace.json > "$tmp"
mv "$tmp" .claude-plugin/marketplace.json
echo "marketplace.json bumped -> $NEW_VERSION"

echo ""
echo "Total plugin.json files bumped: $count"
