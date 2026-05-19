# Modifications from upstream

This repository is a derivative of [`anthropics/financial-services`](https://github.com/anthropics/financial-services), licensed under Apache License 2.0. This file satisfies the §4(b) requirement that "modified files carry prominent notices stating that You changed the files" via a single-file bulk-modifications notice rather than per-file headers.

## Changes applied for the v0.1.0 release

- **All `.claude-plugin/plugin.json` files (20 total at v0.1.0):** `author` field rewritten from `"Anthropic FSI"` (16 plugins), `"Anthropic"` (2), `"LSEG"` (1), and `"Kensho Technologies"` (1) to `"Corduroy Intelligence" <mmoore@corduroyintelligence.com>`. A `version: "0.1.0"` field added to each.
- **`.claude-plugin/marketplace.json`:** `name` rewritten from `claude-for-financial-services` → `corduroy`; `owner` rewritten from `{"name": "Matt Piccolella"}` → `{"name": "Corduroy Intelligence", "email": "mmoore@corduroyintelligence.com"}`; `description` and top-level `version: "0.1.0"` added.
- **Markdown files** (README.md, CLAUDE.md, every plugin README, every SKILL.md, every cookbook README): brand strings `Claude for Financial Services` → `Corduroy for Financial Services`; `Anthropic FSI` → `Corduroy Intelligence`; `anthropics/financial-services` GitHub URLs removed (private redistribution); Anthropic-voiced narration rewritten to Corduroy voice. References to "Claude" the model and "Claude Code" / "Claude Cowork" the host platforms are preserved as factual product names.
- **Added files:** `NOTICE`, `MODIFICATIONS.md`, `INSTALL.md`, `scripts/bump-versions.sh`, `scripts/build-bundle.sh`, `scripts/verify-bundle.sh`.
- **Preserved verbatim:** `LICENSE` (top-level Apache 2.0), `plugins/partner-built/spglobal/LICENSE` (S&P Global's own Apache 2.0 copy — preserved at v0.1.0; removed in v0.2.0 along with that plugin).
- **Removed:** `.githooks/`, `.github/` (CI/hooks specific to upstream Anthropic flow and not applicable to Corduroy's private distribution).

## Changes applied for the v0.2.0 release

- **Removed partner-built plugins:** `plugins/partner-built/lseg/` (LSEG) and `plugins/partner-built/spglobal/` (Kensho/S&P Global) dropped from the marketplace. The plugins remain available in the upstream `anthropics/financial-services` repo under their original Apache 2.0 license for anyone who wants to install them directly from upstream.
- **Domain-scoped restructure:** `plugins/` reorganized to scale for multi-domain expansion (future: real-estate, legal, etc.).
  - `plugins/agent-plugins/` → `plugins/financial-services/agents/`
  - `plugins/vertical-plugins/` → `plugins/financial-services/verticals/`
  - `managed-agent-cookbooks/` → `plugins/financial-services/cookbooks/` (relative paths inside `agent.yaml` files updated accordingly)
  - `claude-for-msft-365-install/` → `plugins/shared/claude-for-msft-365-install/`
- **Marketplace catalog enriched:** every plugin entry now carries `category` (`financial-services` or `admin-tools`) plus descriptive `tags` (`agent`, `vertical`, `modeling`, …) so the Cowork/Claude Code browse UI can group and filter.
- **Plugin count:** 20 (v0.1.0) → 18 (v0.2.0) after partner-plugin removal.

See `git log` for the full file-level diff. The upstream baseline is `anthropics/financial-services@main` as of 2026-05-19.

## Trademarks

"Claude" and "Claude Cowork" are trademarks of Anthropic PBC. References to them in this repository identify the host platform the plugins target; this distribution does not claim affiliation with or endorsement by Anthropic. "Corduroy Intelligence" is the trademark of Corduroy Intelligence LLC.

"LSEG", "S&P Global", and "Kensho" are trademarks of their respective owners. The partner plugins reference these data sources by name as a factual matter; this distribution does not claim affiliation with or endorsement by LSEG, S&P Global, or Kensho Technologies.
