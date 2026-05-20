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

## Changes applied for the v0.3.0 release

- **Two-level scoping inside each domain.** Previously each domain dir contained sibling `agents/`, `verticals/`, and `cookbooks/` directories. v0.3.0 nests them inside each vertical so a single workflow's plugin + its owned agents + their cookbooks live together:
  - `plugins/financial-services/verticals/<v>/` → `plugins/financial-services/<v>/plugin/`
  - `plugins/financial-services/agents/<a>/` → `plugins/financial-services/<owning-vertical>/agents/<a>/`
  - `plugins/financial-services/cookbooks/<a>/` → `plugins/financial-services/<owning-vertical>/cookbooks/<a>/`
- **Agent → vertical assignments** (made by reading each agent's bundled skills + system prompt + workflow persona):
  - financial-analysis: model-builder
  - investment-banking: pitch-agent
  - equity-research: earnings-reviewer, market-researcher
  - wealth-management: meeting-prep-agent
  - fund-admin: gl-reconciler, month-end-closer, statement-auditor, valuation-reviewer
  - operations: kyc-screener
  - private-equity: (no agents — vertical plugin available standalone)
- **Cookbook relative paths unchanged.** Cookbook `agent.yaml` files still reference `../../agents/<slug>/` because both cookbook and agent moved in lockstep into the same vertical (same relative depth).
- **Removed:** the top-level `plugins/financial-services/cookbooks/README.md` index — it documented stale path conventions and stale vertical assignments inherited from the upstream Anthropic layout. Each individual cookbook's own README is preserved.
- **`marketplace.json` updated:** all 18 plugin `source` paths point to the new locations. `category` and `tags` unchanged.
- **Repo name change** (v0.2.x → v0.3.x window): `Corduroy-Dev/corduroy-plugins` → `Corduroy-Dev/corduroy-tools`. GitHub maintains a permanent redirect from the old URL.

## Changes applied for the v0.4.0 release

- **Removed `claude-for-msft-365-install` plugin.** It was upstream Anthropic-authored admin tooling for the Microsoft 365 add-in, not Corduroy-created or tuned. Corduroy customers who need M365 deployment tooling can install it directly from upstream (`anthropics/financial-services`) under the original Apache 2.0 license; Corduroy doesn't redistribute it.
- **Removed the `plugins/shared/` directory.** With the M365 installer gone, it was empty. Cross-domain tooling can be reintroduced as `plugins/shared/` later if/when Corduroy authors something that genuinely spans domains.
- **Plugin count:** 18 (v0.3.0) → 17 (v0.4.0). All plugins are now under `plugins/financial-services/`.
- **Marketplace description** updated to drop "and shared admin tooling" reference.
- **`scripts/verify-bundle.sh`** floor/exact assertions updated to match (18→17).

## Changes applied for the v0.5.0 release

- **New domain: `real-estate`.** Sibling to `financial-services/` under `plugins/`. The repo's two-level scoping accepts the addition with zero script changes; `bump-versions.sh`, `build-bundle.sh`, and `verify-bundle.sh` all use `find` and pick up the new tree automatically.
- **Two starter verticals in real-estate:**
  - `acquisition` — 5 skills (om-analyzer, rent-roll-intelligence, ic-memo, market-snapshot, model-reviewer) + 1 agent (deal-analyzer) + 1 managed-agent cookbook
  - `asset-management` — 4 skills (asset-mgmt-copilot, property-issue-detection, lease-abstraction, capex-forecasting) + 1 agent (asset-pulse) + 1 managed-agent cookbook
- **Plugin count:** 17 (v0.4.0) → 21 (v0.5.0). 4 new marketplace entries: `acquisition`, `deal-analyzer`, `asset-management`, `asset-pulse`. All `category: "real-estate"`.
- **Marketplace description** updated to enumerate both domains.
- **`scripts/verify-bundle.sh`** floor/exact assertions updated to match (17 → 21).
- **Skill content:** all 9 new SKILL.md files are authored at production quality (1100-1700 words each) with RE-specific pattern checklists (e.g., a "fake occupancy" pattern list in `rent-roll-intelligence`, an IRR-manipulation checklist in `model-reviewer`, a preventive-maintenance focus-list pattern in `property-issue-detection`). Skill bodies are domain-generic; customer-specific tuning happens in private engagement folders, not in this public marketplace.
- **No live data connectors yet.** Both verticals' `.mcp.json` files are empty `{}` in v0.5.0. v0.6 candidates include property-management-system connectors, market-data feeds, and rent-comp providers.
- **v0.6 candidate skills** include `rent-pricing-assistant`, `walkthrough-intake`, `lp-letter`, `portfolio-narrator`, debt-vertical skills (loan-underwriting, refi-risk), and development-vertical skills (construction-draw-analyzer, permit-zoning).

See `git log` for the full file-level diff. The upstream baseline is `anthropics/financial-services@main` as of 2026-05-19.

## Trademarks

"Claude" and "Claude Cowork" are trademarks of Anthropic PBC. References to them in this repository identify the host platform the plugins target; this distribution does not claim affiliation with or endorsement by Anthropic. "Corduroy Intelligence" is the trademark of Corduroy Intelligence LLC.

"LSEG", "S&P Global", and "Kensho" are trademarks of their respective owners. The partner plugins reference these data sources by name as a factual matter; this distribution does not claim affiliation with or endorsement by LSEG, S&P Global, or Kensho Technologies.
