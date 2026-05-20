<p align="center">
  <img src="./assets/corduroy-logo.png" alt="Corduroy Intelligence" width="120" />
</p>

# Installing Corduroy in Claude Cowork

This guide walks you through adding Corduroy's financial-services and real-estate toolkit to your Claude Cowork workspace. Takes about 5 minutes. You don't need a GitHub account or any developer tools — just the Claude desktop app and an active Cowork plan.

*Last updated: 2026-05-20 (v0.5.1)*

---

## What you'll get

After install, you'll have access to:

- **Workflow agents** for pitch decks, earnings updates, sector research, client-meeting prep, GL reconciliation, NAV tie-out, KYC reviews, real-estate deal intake, and portfolio asset-management reviews
- **Vertical skill bundles** covering investment banking, equity research, private equity, wealth management, fund admin, operations, **real-estate acquisition**, and **real-estate asset management**
- **11 data connectors** to Daloopa, Morningstar, FactSet, S&P Capital IQ, Moody's, MT Newswires, Aiera, LSEG, PitchBook, Chronograph, and Egnyte (you wire these to your firm's existing subscriptions when you're ready)

All 21 plugins are listed at the end of this doc if you want to scan the full menu first.

---

## Before you start

You need:

1. **Claude desktop app** installed on your machine (Mac or Windows)
2. **An active Cowork plan.** When you open Claude desktop, you should see a "Cowork" tab in the left sidebar. If you don't, your Claude account doesn't have Cowork enabled — contact your IT/admin or `msloan@corduroyintelligence.com` and we'll help you sort it
3. **5 minutes**

You do *not* need:

- A GitHub account
- Developer tools or terminal access
- Admin permissions in your org (you install via your *personal* marketplace, which only you see)

---

## Step 1 — Open the plugin browser

1. Open Claude desktop
2. Click the **Cowork** tab in the left sidebar
3. Click **Customize** in the left sidebar (inside Cowork)
4. Click **Browse plugins**

A window will open showing available plugin marketplaces.

## Step 2 — Add the Corduroy marketplace

1. At the top of the window, click the **Personal** tab
2. Click the **+** button
3. Select **Add marketplace **
4. Paste this URL:

   ```
   https://github.com/Corduroy-Dev/corduroy-tools
   ```

5. Confirm.

The `corduroy` marketplace will appear in your Personal tab with all 21 plugins listed underneath.

## Step 3 — Install the plugins you need

We recommend installing in this order:

### Always start with the core

**`financial-analysis`** — the foundation. It carries all 11 data connectors plus shared modeling skills (DCF, comps, LBO, 3-statement, deck QC, Excel audit). Most other plugins build on it.

Click on `financial-analysis` in the marketplace list and install it.

### Then add what matches your role

| Your role | Install these |
|---|---|
| **Investment banking** | `investment-banking` (skills + commands), `pitch-agent` (end-to-end pitch workflow) |
| **Equity research** | `equity-research`, `earnings-reviewer` (post-earnings), `market-researcher` (sector primers) |
| **Private equity** | `private-equity` (deal sourcing, IC memos, portfolio monitoring) |
| **Wealth management / advisory** | `wealth-management`, `meeting-prep-agent` (client-meeting briefings) |
| **Fund administration / accounting** | `fund-admin`, `gl-reconciler` (daily GL recon), `month-end-closer` (close package), `statement-auditor` (LP statement audits), `valuation-reviewer` (quarterly portfolio valuations) |
| **Operations / compliance** | `operations`, `kyc-screener` (KYC document review) |
| **Real estate — acquisition / underwriting** | `acquisition` (skills + commands), `deal-analyzer` (end-to-end deal intake: OM → rent roll → market → model → IC memo) |
| **Real estate — asset management / portfolio ops** | `asset-management` (skills + commands), `asset-pulse` (monthly/quarterly portfolio review) |

You can always install more later — Corduroy stays visible in your Personal tab.

## Step 4 — Start using them

Close the Browse plugins window and start a new conversation in Cowork.

**Slash commands.** Type `/` in the message box to see what's available. Depending on what you installed, you'll see commands like:

- `/comps` — comparable companies analysis
- `/dcf` — DCF valuation
- `/lbo` — leveraged buyout model
- `/earnings` — post-earnings analysis
- `/ic-memo` — investment committee memo (RE flavor lives under `/acquisition:ic-memo`; PE flavor under `/private-equity:ic-memo`)
- `/client-review` — client-meeting prep
- `/cim` — confidential information memorandum
- `/om-analyzer` — real-estate offering memorandum analysis
- `/rent-roll` — rent-roll diligence
- `/market-snapshot` — one-page real-estate market primer
- `/asset-mgmt-copilot` — portfolio variance / NOI explanation
- `/property-issues` — property-walkthrough anomaly scan
- `/lease-abstract` — lease-document field extraction
- `/capex-forecast` — 5-year capex forecast
- ... and many more

**Skills fire automatically.** You can also just describe what you're trying to do — Claude pulls in the relevant skill on its own. Examples:

- "Help me build a DCF on Acme Corp" → loads the DCF model skill
- "I have an Excel model and the balance sheet doesn't balance" → loads the audit-xls skill
- "Draft an IC memo for the Acme acquisition" → loads the IC-memo skill

**Agents for bigger workflows.** Some plugins are named end-to-end agents you can invoke by name:

- `@pitch-agent build a sell-side pitch for Acme Corp`
- `@earnings-reviewer process Microsoft's Q3 earnings`
- `@meeting-prep-agent build a briefing for tomorrow's review with the Jones family`
- `@deal-analyzer run intake on the multifamily target — OM and rent roll attached`
- `@asset-pulse run a September review on the property — operating statement and walkthroughs attached`

---

## Real estate workflows in depth

The `real-estate` domain ships two complementary workflows. They sit at different points in the asset lifecycle and answer different questions.

### `acquisition` — for "a new deal hit my desk"

Install: `acquisition` (vertical) + `deal-analyzer` (agent).

This is the workflow you run when a broker sends an OM, when a sponsor pitches you a deal, or when you need to evaluate an off-market opportunity before committing diligence dollars. It produces a partner-ready intake packet so an IC can form a calibrated view in 30 minutes.

**Skills in the `acquisition` vertical:**

| Skill | When to use | What to give it | What you get back |
|---|---|---|---|
| `om-analyzer` (`/om-analyzer`) | First-pass intake on any OM | OM PDF or text (optionally rent roll, T-12, debt schedule, environmental reports) | Investment-memo draft, risks list, "too good to be true" flags, broker questions, cap-rate / yield summary |
| `rent-roll-intelligence` (`/rent-roll`) | Diligencing the seller's rent roll | Rent roll as CSV / XLSX / pasted table | Occupancy reality check (effective vs reported), concession density, expiration cliffs, "fake occupancy" pattern flags |
| `market-snapshot` (`/market-snapshot`) | Underwriting in a market you don't yet know cold | MSA / submarket name + asset class + optional pasted source data | One-page primer: demand drivers, supply pipeline, recent transaction caps, watchlist risks |
| `model-reviewer` (`/acquisition:model-reviewer`) | Auditing the broker's or your analyst's financial model | Excel-as-CSV or pasted formulas | Structural-integrity findings, RE-specific assumption flags, IRR-manipulation patterns |
| `ic-memo` (`/acquisition:ic-memo`) | Drafting the IC memo from the above | Outputs of the four skills above + debt terms + thesis | Structured IC memo with exec summary, thesis, business plan, returns analysis, risks & mitigants, decision ask |

**End-to-end via the agent:** `@deal-analyzer` orchestrates all five skills against a single deal. You give it the inputs; it produces five artifacts (OM analysis, rent-roll analysis, market snapshot, model review, IC memo) plus a one-paragraph executive summary tying them together. Use this when you have time for the full first-pass workup — typically 10–30 minutes of model thinking.

**Example natural prompt to start a workup:**

> "Run the deal-analyzer on this acquisition target: 220-unit garden-style multifamily, secondary Sunbelt market, asking $32M (5.4% cap). Broker is pitching value-add with $3.2M renovation budget. OM and rent roll attached below."

The agent will scope the ask, walk through each skill, flag what it can't verify, and produce a partner-ready packet ending with a recommendation.

### `asset-management` — for "what's happening in my portfolio"

Install: `asset-management` (vertical) + `asset-pulse` (agent).

This is the workflow you run monthly or quarterly when you need to translate the raw operating data into a portfolio narrative — what NOI did, why it did that, what's trending wrong, what to action this month, and what to escalate. It produces a partner-ready report you can hand off for IC and (with light polish) for LP reporting.

**Skills in the `asset-management` vertical:**

| Skill | When to use | What to give it | What you get back |
|---|---|---|---|
| `asset-mgmt-copilot` (`/asset-mgmt-copilot`) | Monthly variance review | Operating statement + variance report + occupancy/leasing report | NOI bridge (line-by-line drivers), variance attribution, watchlist by property, action items by owner |
| `property-issue-detection` (`/property-issues`) | Scanning ground-level data for anomalies | Walkthrough notes (free text OK), maintenance work-orders, vendor invoices, utility bills | Critical issues, repeat-hit patterns across weeks, vendor / utility / leasing-velocity anomalies — each tied to specific evidence |
| `lease-abstraction` (`/lease-abstract`) | Capturing the economics of a new lease | Lease document (PDF or text) + asset class | Structured abstract: base rent, escalations, renewals, CAM, TI obligations, guarantors, special clauses, citations to lease sections |
| `capex-forecasting` (`/capex-forecast`) | Budget season, refinance prep, annual planning | Property age, asset inventory, reserve schedule, recent capex history | 5-year forecast by year and by category, reserve-adequacy verdict, urgency-prioritized line items |

**End-to-end via the agent:** `@asset-pulse` orchestrates all four skills against a property or portfolio for a given period. The deliverable is a one-page partner-ready narrative plus the four underlying detailed artifacts. Built-in distinction between LP-disclosable content and internal-only operational detail.

**Example natural prompt to start a periodic review:**

> "Run an asset-pulse on this property for September: NOI was 5.6% below budget, leasing velocity tracking behind pace for the past 60 days, three HVAC tickets in the last two weeks. Here's the operating statement, the variance report, four weeks of walkthrough notes, and the maintenance work-order log."

The agent will build the NOI bridge, scan the walkthroughs for repeat patterns, refresh the capex schedule with the period's actuals, and produce a partner-ready report.

### Tuning these to your firm

The skills are written for generic real-estate workflows; they pattern-match on what a careful underwriter or asset manager would look for in any deal. The specific items your firm pays attention to — preferred IC structure, your standard sensitivity tables, your typical hold-period assumptions, your preventive-maintenance focus checklist — get tuned in your engagement work with us, not in the public marketplace. Tell us what's missing and we'll prioritize it for the next release.

---

## Connecting your firm's data

Several skills pull from live financial data feeds (Daloopa, FactSet, S&P Capital IQ, PitchBook, etc.). These require your firm's existing subscription credentials.

**You don't need to set these up during install.** Claude will tell you what credentials it needs the first time a skill reaches for a connector you haven't configured.

When you're ready to wire up specific feeds, contact your Corduroy lead — we'll help you provision against your firm's existing vendor relationships.

---

## Updates

When we ship a new release, you'll see an "Update available" indicator on the relevant plugin in your Browse plugins list. Click Update to pull the new version. You can also restart Claude desktop occasionally to pick up background marketplace refreshes.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| No "Cowork" tab in Claude desktop | Your account doesn't have Cowork enabled. Contact your admin or `msloan@corduroyintelligence.com`. |
| "Add marketplace from GitHub" option missing | Cowork or Skills is disabled for your account. Same fix as above. |
| Marketplace adds but shows 0 plugins | Close the window and reopen Browse plugins. If still empty, restart Claude desktop. |
| Install spins forever | Network issue reaching github.com. Try a different network or VPN off. |
| Typed `/` and don't see Corduroy commands | Restart the conversation, or restart Claude desktop. Slash commands sometimes need a reload to register. |
| A skill says "I need credentials for [provider]" | That data feed needs your firm's API key. Contact your Corduroy lead — we'll help provision it. |
| A plugin description in Cowork doesn't match this doc | We may have shipped an update. Latest plugin descriptions are authoritative; this doc is a starting point. |

---

## Full plugin catalog

If you want to see the complete menu before installing, here's everything in the `corduroy` marketplace:

### Vertical plugins (skill + command bundles)

| Plugin | What it adds |
|---|---|
| `financial-analysis` | Comps, DCF, LBO, 3-statement, deck QC, Excel audit. All 11 data connectors. *(core dependency)* |
| `investment-banking` | CIMs, teasers, process letters, buyer lists, merger models, deal tracking |
| `equity-research` | Earnings notes, initiations, model updates, thesis and catalyst tracking, morning notes |
| `private-equity` | Sourcing, screening, diligence checklists, IC memos, portfolio monitoring, returns analysis |
| `wealth-management` | Client reviews, financial plans, rebalancing, reporting, tax-loss harvesting |
| `fund-admin` | GL recon, break tracing, accruals, roll-forwards, variance commentary, NAV tie-out |
| `operations` | KYC document parsing and rules-grid evaluation |
| `acquisition` *(real estate)* | OM analysis, rent-roll intelligence, market snapshots, model review, IC memo drafting |
| `asset-management` *(real estate)* | Variance/NOI explanation, property issue detection, lease abstraction, 5-year capex forecasting |

### Workflow agents (end-to-end)

| Agent | What it does |
|---|---|
| `pitch-agent` | Target + situation → comps + precedents + LBO → branded pitch deck |
| `market-researcher` | Sector or theme → industry overview, competitive landscape, peer comps, ideas shortlist |
| `earnings-reviewer` | Earnings call + filings → model update → note draft |
| `meeting-prep-agent` | Client + calendar event → briefing pack (relationship, holdings, recent activity, agenda) |
| `model-builder` | Ticker + assumptions → DCF, LBO, 3-statement, or comps model in Excel |
| `gl-reconciler` | Trade date → GL ↔ subledger recon → break report routed for sign-off |
| `month-end-closer` | Entity + period → accruals + roll-forwards + variance commentary → close package |
| `statement-auditor` | Pre-generated LP statement batch + NAV pack → tie-out + discrepancy report |
| `valuation-reviewer` | GP valuation packages → valuation template review → LP-reporting package |
| `kyc-screener` | Onboarding doc packet → rules-engine + sanctions/PEP screening → gap report |
| `deal-analyzer` *(real estate)* | OM + rent roll + market + model → IC memo (acquisition workup, end to end) |
| `asset-pulse` *(real estate)* | Variance + walkthroughs + capex + leasing → narrative + watchlist + action items (periodic portfolio review) |

---

## Important disclaimer

Nothing in this toolkit constitutes investment, legal, tax, or accounting advice. These agents draft analyst work product — models, memos, research notes, reconciliations — for review by a qualified professional. They do not make investment recommendations, execute transactions, bind risk, post to a ledger, or approve onboarding. Every output is staged for human sign-off. You are responsible for verifying outputs and for compliance with the laws and regulations that apply to your firm.

---

## Questions or help

- Your Corduroy engagement lead
- `msloan@corduroyintelligence.com`

We iterate on what's in the toolkit based on what you actually use — tell us what's missing.
