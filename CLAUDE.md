# Corduroy Plugins — Maintainer Guide

This file orients Corduroy engineers and Claude Code sessions working in this repository. It supersedes the upstream `anthropics/financial-services` developer guide.

This repository is a private derivative of [`anthropics/financial-services`](https://github.com/anthropics/financial-services) (Apache 2.0). See [`NOTICE`](./NOTICE) and [`MODIFICATIONS.md`](./MODIFICATIONS.md) for attribution and the scope of changes.

## What this is

A Claude plugin marketplace hosted at `github.com/Corduroy-Dev/corduroy-tools` (public). The repo is **domain-scoped** so adding new industry verticals later is just a new subdirectory.

- `.claude-plugin/marketplace.json` — the catalog (name `corduroy`), with `category` + `tags` per plugin
- 17 plugins as of v0.4.0: all under `plugins/financial-services/` — 10 agents, 7 verticals, plus 10 managed-agent cookbooks (cookbooks aren't standalone plugins but ride along as reference for headless deployment)

Customers install by pasting the GitHub URL into Claude Code (`/plugin marketplace add Corduroy-Dev/corduroy-tools`) or Cowork (Customize → Browse plugins → Personal → + → Add marketplace from GitHub). Offline zip bundles produced by `scripts/build-bundle.sh` are still available for air-gapped customers.

## Repository layout

The repo is **two-level scoped** — by domain (financial-services; future: real-estate, legal, …) and within each domain by **vertical** (the workflow team: investment-banking, equity-research, fund-admin, …). Each vertical groups its own plugin, agents, and cookbooks so all the code for one workflow lives in one folder.

```
.claude-plugin/marketplace.json              # the catalog (name: corduroy)
plugins/
  financial-services/                        # domain (first one we ship)
    <vertical>/                              # e.g. investment-banking, fund-admin
      plugin/                                # the vertical's own plugin
        .claude-plugin/plugin.json
        commands/
        skills/
        .mcp.json
      agents/<slug>/                         # workflow agents owned by this vertical
        .claude-plugin/plugin.json
        agents/<slug>.md
        skills/                              # bundled copies of the skills used
      cookbooks/<slug>/                      # Managed Agent cookbooks for this vertical's agents
        agent.yaml                           # references ../../agents/<slug>/ (same depth)
        subagents/*.yaml
scripts/
  bump-versions.sh                           # version bumper — single source of truth
  build-bundle.sh                            # produces customer zips
  verify-bundle.sh                           # gates delivery (run before shipping)
NOTICE                                       # Apache 2.0 §4(c) attribution — DO NOT REMOVE
MODIFICATIONS.md                             # Apache 2.0 §4(b) modifications notice
LICENSE                                      # Apache 2.0 (upstream) — DO NOT REMOVE
```

## Vertical → agent mapping (as of v0.3.0)

| Vertical | Agents owned |
|---|---|
| `financial-analysis` | `model-builder` |
| `investment-banking` | `pitch-agent` |
| `equity-research` | `earnings-reviewer`, `market-researcher` |
| `wealth-management` | `meeting-prep-agent` |
| `private-equity` | *(no agents yet — vertical plugin available standalone)* |
| `fund-admin` | `gl-reconciler`, `month-end-closer`, `statement-auditor`, `valuation-reviewer` |
| `operations` | `kyc-screener` |

## Adding a new domain or vertical

```bash
# New domain:
mkdir -p plugins/<domain>/<vertical>/{plugin,agents,cookbooks}

# New vertical inside an existing domain:
mkdir -p plugins/financial-services/<new-vertical>/{plugin,agents,cookbooks}

# Either way:
#   author plugin/.claude-plugin/plugin.json (the vertical plugin)
#   author agents/<slug>/.claude-plugin/plugin.json (each agent)
#   author cookbooks/<slug>/agent.yaml (each cookbook, references ../agents/<slug>/)
#   add marketplace.json entries with category + tags
# bump-versions.sh, build-bundle.sh, verify-bundle.sh are path-agnostic
# (find walks the whole tree), so no script changes needed.
```

## Editing plugins

1. Edit the file in place. Markdown changes take effect immediately for any installed plugin once the customer runs `/plugin update <name>@corduroy`.
2. If you edit a skill in `plugins/<domain>/<vertical>/plugin/skills/<skill>/`, propagate to any agent in the same vertical that bundles it: `find plugins/<domain>/<vertical>/agents -name SKILL.md | xargs grep -l <skill-name>` to find the bundled copies.
3. Run `claude plugin validate .` to schema-check the marketplace and every plugin.json.

## Cutting a release

```bash
./scripts/bump-versions.sh 0.1.1     # bumps every plugin.json + marketplace.json
./scripts/build-bundle.sh             # produces offline zips (marketplace + per-plugin Cowork)
./scripts/verify-bundle.sh            # gates the zips — exits non-zero on any failure
git add -A && git commit -m "Release v0.1.1"
git tag v0.1.1
git push origin main --tags
```

The GitHub push is what makes the release live for customers — Claude Code/Cowork pull from `Corduroy-Dev/corduroy-tools`. The zip artifacts are kept for air-gapped delivery; upload them as GitHub release assets if customers want a stable download URL.

**Versioning rule:** `version` lives **only** in each `.claude-plugin/plugin.json`. Don't add a per-plugin `version` to `marketplace.json` entries — when both are set, plugin.json silently wins, which masks the marketplace value. `bump-versions.sh` is the single canonical bumper.

**License preservation:** Never delete `LICENSE`, `NOTICE`, or `MODIFICATIONS.md`. `verify-bundle.sh` enforces their presence in the bundle.

## What's deliberately NOT in here

- No `.github/` workflows. No `.githooks/`. The upstream's pre-commit version-bump enforcement is replaced by `bump-versions.sh` being the only sanctioned bump path.
- No `scripts/check.py` / `validate.py` / `orchestrate.py` / `sync-agent-skills.py` from upstream are wired into CI. They're kept in `scripts/` for local use; before re-bundling any of them, audit with `rg 'anthropic|piccolella' scripts/`.

## Pointers

- Customer-facing install instructions: [`INSTALL.md`](./INSTALL.md)
- Marketing/agent overview: [`README.md`](./README.md)
- The Corduroy product working directory (this isn't it): `~/Work/usul-vault/corduroy/` — see its `AGENTS.md` for the broader operating context.
