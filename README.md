<p align="center">
  <img src="./assets/corduroy-logo.png" alt="Corduroy Intelligence" width="120" />
</p>

# Corduroy Plugins for Financial Services

Workflow agents, vertical skill bundles, and data connectors for FINRA/SEC-regulated firms — credit funds, private equity, family offices, real estate operators, wealth advisors. Install them as plugins for Claude Code or Cowork, then tune them to your firm's processes.

This bundle is the field kit for Corduroy's AI CTO engagements: governance-first AI adoption, deployed against your own data and your own model routing, with every output staged for human sign-off.

> [!IMPORTANT]
> Nothing in this repository constitutes investment, legal, tax, or accounting advice. These agents draft analyst work product — models, memos, research notes, reconciliations — for review by a qualified professional. They do not make investment recommendations, execute transactions, bind risk, post to a ledger, or approve onboarding; every output is staged for human sign-off. You are responsible for verifying outputs and for compliance with the laws and regulations that apply to your firm.

What's in the bundle:

- **[Agents](#agents)** — named, end-to-end workflow agents (Pitch Agent, Market Researcher, GL Reconciler, …). Each ships as a Cowork/Claude Code plugin **and** as a [Claude Managed Agent template](./plugins/financial-services/cookbooks) you can deploy through your own workflow engine.
- **[Vertical plugins](#vertical-plugins)** — the underlying skills, slash commands, and data connectors, bundled by FSI vertical. Install these on their own if you just want `/comps`, `/dcf`, `/earnings` and the connectors without a full agent.

## Install

See **[INSTALL.md](./INSTALL.md)** for the full customer install instructions. The short version, same source for both hosts:

**Claude Code:**

```
/plugin marketplace add Corduroy-Dev/corduroy-tools
/plugin install financial-analysis@corduroy
/plugin install pitch-agent@corduroy
# ...
```

**Cowork (Claude.ai desktop):** Customize → Browse plugins → Personal → + → Add marketplace from GitHub → paste `https://github.com/Corduroy-Dev/corduroy-tools`. Then install plugins from the browser.

Offline install bundles (zip + per-plugin Cowork uploads) are available on request — see [INSTALL.md](./INSTALL.md).

## Agents

Each agent is named for the workflow it runs. They're starting points: install the ones that match your work, then tune the prompts, skills, and connectors to how your firm does it.

Each agent plugin is **self-contained** — it bundles the skills it uses, so installing the agent is all you need.

| Function | Agent | What it does |
|---|---|---|
| **Coverage & advisory** | **[Pitch Agent](./plugins/financial-services/investment-banking/agents/pitch-agent)** | Comps, precedents, LBO → branded pitch deck, end to end |
| | **[Meeting Prep Agent](./plugins/financial-services/wealth-management/agents/meeting-prep-agent)** | Briefing pack before every client meeting |
| **Research & modeling** | **[Market Researcher](./plugins/financial-services/equity-research/agents/market-researcher)** | Sector or theme → industry overview, competitive landscape, peer comps, ideas shortlist |
| | **[Earnings Reviewer](./plugins/financial-services/equity-research/agents/earnings-reviewer)** | Earnings call + filings → model update → note draft |
| | **[Model Builder](./plugins/financial-services/financial-analysis/agents/model-builder)** | DCF, LBO, 3-statement, comps — live in Excel |
| **Fund admin & finance ops** | **[Valuation Reviewer](./plugins/financial-services/fund-admin/agents/valuation-reviewer)** | Ingests GP packages, runs valuation template, stages LP reporting |
| | **[GL Reconciler](./plugins/financial-services/fund-admin/agents/gl-reconciler)** | Finds breaks, traces root cause, routes for sign-off |
| | **[Month-End Closer](./plugins/financial-services/fund-admin/agents/month-end-closer)** | Accruals, roll-forwards, variance commentary |
| | **[Statement Auditor](./plugins/financial-services/fund-admin/agents/statement-auditor)** | Audits LP statements before distribution |
| **Operations & onboarding** | **[KYC Screener](./plugins/financial-services/operations/agents/kyc-screener)** | Parses onboarding docs, runs the rules engine, flags gaps |

For Managed Agent deployment — `agent.yaml`, leaf-worker subagents, steering-event examples, and per-agent security notes — see the `cookbooks/` directory inside each vertical (e.g. [investment-banking/cookbooks/](./plugins/financial-services/investment-banking/cookbooks), [acquisition/cookbooks/](./plugins/real-estate/acquisition/cookbooks)).

## Real Estate

The real-estate domain ships with two starter verticals in v0.5.0:

**Acquisition** — the "new deal hits my desk" workflow. Read inbound OMs, diligence rent rolls, build market snapshots, audit financial models, draft IC memos.

| Plugin | What it does |
|---|---|
| **[acquisition](./plugins/real-estate/acquisition/plugin)** *(vertical)* | 5 skills: OM analysis, rent-roll intelligence, market snapshot, model reviewer, IC memo drafter |
| **[deal-analyzer](./plugins/real-estate/acquisition/agents/deal-analyzer)** *(agent)* | End-to-end deal intake — OM + rent roll + market + model → IC memo package |

**Asset Management** — the "what's happening across my portfolio" workflow. Review variance / NOI, scan property walkthroughs for issues, abstract leases, forecast capex.

| Plugin | What it does |
|---|---|
| **[asset-management](./plugins/real-estate/asset-management/plugin)** *(vertical)* | 4 skills: variance/NOI explanation, property issue detection, lease abstraction, 5-year capex forecasting |
| **[asset-pulse](./plugins/real-estate/asset-management/agents/asset-pulse)** *(agent)* | End-to-end periodic portfolio review — variance + walkthroughs + capex + leasing → narrative + watchlist + action items |

## Repository Layout

The repo is **two-level scoped** — by domain (financial-services, real-estate; future: legal, …) and within each domain by **vertical** (the workflow team: investment-banking, equity-research, fund-admin, acquisition, asset-management, …). Each vertical groups its own plugin, agents, and cookbooks together.

```
plugins/
  financial-services/
    <vertical>/                # e.g. investment-banking, fund-admin
      plugin/                  # the vertical's own plugin (skills + commands + MCPs)
      agents/                  # workflow agents owned by this vertical
      cookbooks/               # Managed Agent cookbooks for this vertical's agents
  real-estate/
    <vertical>/                # e.g. acquisition, asset-management
      plugin/
      agents/
      cookbooks/
scripts/                       # bump-versions.sh, build-bundle.sh, verify-bundle.sh
```

Adding a new vertical or domain is just `mkdir`. Marketplace entries carry a `category` field (`financial-services` or `real-estate`) plus `tags` (`agent`, `vertical`, `modeling`, etc.), so the Cowork/Claude Code browse UI groups them naturally regardless of file path.

## Vertical Plugins

Start with **financial-analysis** — it carries the shared modeling skills and all data connectors. Add verticals for the workflows you need.

| Plugin | What it adds |
|---|---|
| **[financial-analysis](./plugins/financial-services/financial-analysis/plugin)** *(core)* | Comps, DCF, LBO, 3-statement, deck QC, Excel audit. All 11 data connectors. |
| **[investment-banking](./plugins/financial-services/investment-banking/plugin)** | CIMs, teasers, process letters, buyer lists, merger models, deal tracking. |
| **[equity-research](./plugins/financial-services/equity-research/plugin)** | Earnings notes, initiations, model updates, thesis and catalyst tracking. |
| **[private-equity](./plugins/financial-services/private-equity/plugin)** | Sourcing, screening, diligence checklists, IC memos, portfolio monitoring. |
| **[wealth-management](./plugins/financial-services/wealth-management/plugin)** | Client reviews, financial plans, rebalancing, reporting, TLH. |
| **[fund-admin](./plugins/financial-services/fund-admin/plugin)** | GL recon, break tracing, accruals, roll-forwards, variance commentary, NAV tie-out. |
| **[operations](./plugins/financial-services/operations/plugin)** | KYC document parsing and rules-grid evaluation. |

## How It Fits Together

| | What it is | Where it lives |
|---|---|---|
| **Agents** | Self-contained plugins that own a workflow end to end — system prompt plus the skills it uses. Cowork and the Managed Agent wrapper both reference the same directory. | `plugins/financial-services/<vertical>/agents/<slug>/` |
| **Skills** | Domain expertise, conventions, and step-by-step methods Claude draws on automatically when relevant. Authored once in the vertical plugin; each agent bundles a synced copy of the ones it needs. | `plugins/financial-services/<vertical>/plugin/skills/` (source) · `plugins/financial-services/<vertical>/agents/<slug>/skills/` (bundled) |
| **Commands** | Slash actions you trigger explicitly (`/comps`, `/earnings`, `/ic-memo`). | `plugins/financial-services/<vertical>/plugin/commands/` |
| **Connectors** | [MCP servers](https://modelcontextprotocol.io/) that wire Claude to your data — terminals, research platforms, document stores. | `plugins/financial-services/financial-analysis/plugin/.mcp.json` |
| **Managed-agent wrappers** | `agent.yaml` + depth-1 subagents + steering examples for headless deployment. | `plugins/financial-services/<vertical>/cookbooks/<slug>/` |

Everything is file-based — markdown and JSON, no build step on the customer side.

## MCP Integrations

All connectors are centralized in the **financial-analysis** core plugin and shared across the rest.

| Provider | URL |
|---|---|
| [Daloopa](https://www.daloopa.com/) | `https://mcp.daloopa.com/server/mcp` |
| [Morningstar](https://www.morningstar.com/) | `https://mcp.morningstar.com/mcp` |
| [S&P Global](https://www.spglobal.com/) | `https://kfinance.kensho.com/integrations/mcp` |
| [FactSet](https://www.factset.com/) | `https://mcp.factset.com/mcp` |
| [Moody's](https://www.moodys.com/) | `https://api.moodys.com/genai-ready-data/m1/mcp` |
| [MT Newswires](https://www.mtnewswires.com/) | `https://vast-mcp.blueskyapi.com/mtnewswires` |
| [Aiera](https://www.aiera.com/) | `https://mcp-pub.aiera.com` |
| [LSEG](https://www.lseg.com/) | `https://api.analytics.lseg.com/lfa/mcp` |
| [PitchBook](https://pitchbook.com/) | `https://premium.mcp.pitchbook.com/mcp` |
| [Chronograph](https://www.chronograph.pe/) | `https://ai.chronograph.pe/mcp` |
| [Egnyte](https://www.egnyte.com/) | `https://mcp-server.egnyte.com/mcp` |

> MCP access may require a subscription or API key from the provider. Talk to your Corduroy contact about provisioning these against your existing vendor relationships.

## Making It Yours

These are reference templates — they get better when you tune them to how your firm works.

- **Swap connectors** — point `.mcp.json` at your data providers and internal systems.
- **Add firm context** — drop your terminology, processes, and formatting standards into skill files.
- **Bring your templates** — `/ppt-template` teaches Claude your branded PowerPoint layouts.
- **Adjust agent scope** — edit `agents/<slug>.md` to match how your team actually runs the workflow.
- **Add your own** — copy the structure for workflows we haven't covered.

Corduroy's AI CTO engagements handle this tuning for you. If you'd rather drive it in-house, the file-based structure here is the documentation.

## Skill & Command Reference

<details>
<summary><b>financial-analysis</b> — core modeling, Excel, deck QC</summary>

| Skill | Command | Description |
|---|---|---|
| comps-analysis | `/comps` | Comparable company analysis with trading multiples |
| dcf-model | `/dcf` | DCF valuation with WACC and sensitivity analysis |
| lbo-model | `/lbo` | Leveraged buyout model |
| 3-statement-model | `/3-statement-model` | Populate 3-statement financial model templates |
| audit-xls | `/debug-model` | Excel model audit — formula tracing, hardcode detection, balance checks |
| clean-data-xls | — | Normalize and clean tabular data in Excel |
| deck-refresh | — | Re-link and refresh embedded charts/tables across a deck |
| competitive-analysis | `/competitive-analysis` | Competitive landscape and market positioning |
| ib-check-deck | — | QC presentations for errors and consistency |
| pptx-author | — | Produce a `.pptx` file headlessly (Managed Agent mode) |
| xlsx-author | — | Produce a `.xlsx` file headlessly (Managed Agent mode) |
| ppt-template-creator | `/ppt-template` | Create reusable PPT template skills |
| skill-creator | — | Guide for creating new skills |

</details>

<details>
<summary><b>investment-banking</b> — deal materials and execution</summary>

| Skill | Command | Description |
|---|---|---|
| strip-profile | `/one-pager` | One-page company profiles for pitch books |
| pitch-deck | — | Populate pitch deck templates with data |
| datapack-builder | — | Build data packs from CIMs and filings |
| cim-builder | `/cim` | Draft Confidential Information Memorandums |
| teaser | `/teaser` | Anonymous one-page company teasers |
| buyer-list | `/buyer-list` | Strategic and financial buyer universe |
| merger-model | `/merger-model` | Accretion/dilution M&A analysis |
| process-letter | `/process-letter` | Bid instructions and process correspondence |
| deal-tracker | `/deal-tracker` | Track live deals, milestones, and action items |

</details>

<details>
<summary><b>equity-research</b> — coverage and publishing</summary>

| Skill | Command | Description |
|---|---|---|
| earnings-analysis | `/earnings` | Post-earnings quarterly update reports |
| earnings-preview | `/earnings-preview` | Pre-earnings scenario analysis and key metrics |
| initiating-coverage | `/initiate` | Institutional-quality initiation reports |
| model-update | `/model-update` | Update financial models with new data |
| morning-note | `/morning-note` | Morning meeting notes and trade ideas |
| sector-overview | `/sector` | Industry landscape and thematic reports |
| thesis-tracker | `/thesis` | Maintain and update investment theses |
| catalyst-calendar | `/catalysts` | Track upcoming catalysts across coverage |
| idea-generation | `/screen` | Stock screening and idea sourcing |

</details>

<details>
<summary><b>private-equity</b> — sourcing through portfolio ops</summary>

| Skill | Command | Description |
|---|---|---|
| deal-sourcing | `/source` | Discover companies, check CRM, draft founder outreach |
| deal-screening | `/screen-deal` | Quick pass/fail on inbound CIMs and teasers |
| dd-checklist | `/dd-checklist` | Diligence checklists by workstream |
| dd-meeting-prep | `/dd-prep` | Prep for management presentations and expert calls |
| unit-economics | `/unit-economics` | ARR cohorts, LTV/CAC, net retention, revenue quality |
| returns-analysis | `/returns` | IRR/MOIC sensitivity tables |
| ic-memo | `/ic-memo` | Investment committee memo drafting |
| portfolio-monitoring | `/portfolio` | Track portfolio company KPIs and variances |
| value-creation-plan | `/value-creation` | Post-close 100-day plans and EBITDA bridges |
| ai-readiness | `/ai-readiness` | Assess a portfolio company's AI readiness |

</details>

<details>
<summary><b>wealth-management</b> — advisor workflows</summary>

| Skill | Command | Description |
|---|---|---|
| client-review | `/client-review` | Prep for client meetings with performance and talking points |
| financial-plan | `/financial-plan` | Retirement, education, estate, and cash-flow projections |
| portfolio-rebalance | `/rebalance` | Allocation drift analysis and tax-aware rebalancing |
| client-report | `/client-report` | Client-facing performance reports |
| investment-proposal | `/proposal` | Proposals for prospective clients |
| tax-loss-harvesting | `/tlh` | Identify TLH opportunities and manage wash sales |

</details>

## Support

This is a private distribution to Corduroy customers. For installation help, plugin tuning, or new-workflow scoping, contact your Corduroy engagement lead or `mmoore@corduroyintelligence.com`.

## Attribution

This bundle is a derivative of `anthropics/financial-services`, Apache License 2.0. See [`NOTICE`](./NOTICE) for required attribution and [`MODIFICATIONS.md`](./MODIFICATIONS.md) for the scope of changes from upstream.

## License

[Apache License 2.0](./LICENSE)
