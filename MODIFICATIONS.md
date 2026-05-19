# Modifications from upstream

This repository is a derivative of [`anthropics/financial-services`](https://github.com/anthropics/financial-services), licensed under Apache License 2.0. This file satisfies the §4(b) requirement that "modified files carry prominent notices stating that You changed the files" via a single-file bulk-modifications notice rather than per-file headers.

## Changes applied for the v0.1.0 release

- **All `.claude-plugin/plugin.json` files (20 total):** `author` field rewritten from `"Anthropic FSI"` (16 plugins), `"Anthropic"` (2), `"LSEG"` (1), and `"Kensho Technologies"` (1) to `"Corduroy Intelligence" <mmoore@corduroyintelligence.com>`. A `version: "0.1.0"` field has been added to each.
- **`.claude-plugin/marketplace.json`:** `name` rewritten from `claude-for-financial-services` → `corduroy`; `owner` rewritten from `{"name": "Matt Piccolella"}` → `{"name": "Corduroy Intelligence", "email": "mmoore@corduroyintelligence.com"}`; `description` and top-level `version: "0.1.0"` added.
- **Markdown files** (README.md, CLAUDE.md, every plugin README, every SKILL.md, every cookbook README): brand strings `Claude for Financial Services` → `Corduroy for Financial Services`; `Anthropic FSI` → `Corduroy Intelligence`; `anthropics/financial-services` GitHub URLs removed (private redistribution); Anthropic-voiced narration rewritten to Corduroy voice. References to "Claude" the model and "Claude Code" / "Claude Cowork" the host platforms are preserved as factual product names.
- **Added files:** `NOTICE`, `MODIFICATIONS.md`, `INSTALL.md`, `scripts/bump-versions.sh`, `scripts/build-bundle.sh`, `scripts/verify-bundle.sh`.
- **Preserved verbatim:** `LICENSE` (top-level Apache 2.0), `plugins/partner-built/spglobal/LICENSE` (S&P Global's own Apache 2.0 copy).
- **Removed:** `.githooks/`, `.github/` (CI/hooks specific to upstream Anthropic flow and not applicable to Corduroy's private distribution).

See `git log` for the full file-level diff against upstream commit `anthropics/financial-services@main` as of 2026-05-19.

## Trademarks

"Claude" and "Claude Cowork" are trademarks of Anthropic PBC. References to them in this repository identify the host platform the plugins target; this distribution does not claim affiliation with or endorsement by Anthropic. "Corduroy Intelligence" is the trademark of Corduroy Intelligence LLC.

"LSEG", "S&P Global", and "Kensho" are trademarks of their respective owners. The partner plugins reference these data sources by name as a factual matter; this distribution does not claim affiliation with or endorsement by LSEG, S&P Global, or Kensho Technologies.
