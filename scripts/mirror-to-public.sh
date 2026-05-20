#!/usr/bin/env bash
# scripts/mirror-to-public.sh
# Mirror the current state of `origin` (Corduroy-Dev/corduroy-tools-private)
# to `public` (Corduroy-Dev/corduroy-tools).
#
# Run after pushing a release to origin. Customers on the public repo see the
# update on their next /plugin marketplace update.
#
# To hold a release back from public (private-only), simply don't run this.
set -euo pipefail

cd "$(dirname "$0")/.."

if ! git remote get-url public >/dev/null 2>&1; then
  echo "ERROR: no 'public' remote configured. Add it:" >&2
  echo "  git remote add public git@github.com:Corduroy-Dev/corduroy-tools.git" >&2
  exit 1
fi

echo "→ Mirroring main + tags to public (Corduroy-Dev/corduroy-tools)..."
git push public main --tags
echo "✓ Mirrored to Corduroy-Dev/corduroy-tools"
