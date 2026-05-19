<p align="center">
  <img src="./assets/corduroy-logo.png" alt="Corduroy Intelligence" width="120" />
</p>

# Installing Corduroy in Claude Cowork

This guide walks you through adding Corduroy's financial-services toolkit to your Claude Cowork workspace. Takes about 5 minutes. You don't need a GitHub account or any developer tools — just the Claude desktop app and an active Cowork plan.

*Last updated: 2026-05-19*

---

## What you'll get

After install, you'll have access to:

- **Workflow agents** for pitch decks, earnings updates, sector research, client-meeting prep, GL reconciliation, NAV tie-out, KYC reviews, and more
- **Vertical skill bundles** covering investment banking, equity research, private equity, wealth management, fund admin, and operations
- **11 data connectors** to Daloopa, Morningstar, FactSet, S&P Capital IQ, Moody's, MT Newswires, Aiera, LSEG, PitchBook, Chronograph, and Egnyte (you wire these to your firm's existing subscriptions when you're ready)

All 18 plugins are listed at the end of this doc if you want to scan the full menu first.

---

## Before you start

You need:

1. **Claude desktop app** installed on your machine (Mac or Windows)
2. **An active Cowork plan.** When you open Claude desktop, you should see a "Cowork" tab in the left sidebar. If you don't, your Claude account doesn't have Cowork enabled — contact your IT/admin or `mmoore@corduroyintelligence.com` and we'll help you sort it
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
3. Select **Add marketplace from GitHub**
4. Paste this URL:

   ```
   https://github.com/Corduroy-Dev/corduroy-tools
   ```

5. Confirm.

The `corduroy` marketplace will appear in your Personal tab with all 18 plugins listed underneath.

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
| **IT admin deploying Claude in Microsoft 365** | `claude-for-msft-365-install` |

You can always install more later — Corduroy stays visible in your Personal tab.

## Step 4 — Start using them

Close the Browse plugins window and start a new conversation in Cowork.

**Slash commands.** Type `/` in the message box to see what's available. Depending on what you installed, you'll see commands like:

- `/comps` — comparable companies analysis
- `/dcf` — DCF valuation
- `/lbo` — leveraged buyout model
- `/earnings` — post-earnings analysis
- `/ic-memo` — investment committee memo
- `/client-review` — client-meeting prep
- `/cim` — confidential information memorandum
- ... and many more

**Skills fire automatically.** You can also just describe what you're trying to do — Claude pulls in the relevant skill on its own. Examples:

- "Help me build a DCF on Acme Corp" → loads the DCF model skill
- "I have an Excel model and the balance sheet doesn't balance" → loads the audit-xls skill
- "Draft an IC memo for the Acme acquisition" → loads the IC-memo skill

**Agents for bigger workflows.** Some plugins are named end-to-end agents you can invoke by name:

- `@pitch-agent build a sell-side pitch for Acme Corp`
- `@earnings-reviewer process Microsoft's Q3 earnings`
- `@meeting-prep-agent build a briefing for tomorrow's review with the Jones family`

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
| No "Cowork" tab in Claude desktop | Your account doesn't have Cowork enabled. Contact your admin or `mmoore@corduroyintelligence.com`. |
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

### Admin tooling

| Plugin | Who it's for |
|---|---|
| `claude-for-msft-365-install` | IT admins provisioning Claude inside Excel/PowerPoint/Word/Outlook via the Microsoft 365 add-in, against your own cloud (Vertex AI, Bedrock, or LLM gateway) |

---

## Important disclaimer

Nothing in this toolkit constitutes investment, legal, tax, or accounting advice. These agents draft analyst work product — models, memos, research notes, reconciliations — for review by a qualified professional. They do not make investment recommendations, execute transactions, bind risk, post to a ledger, or approve onboarding. Every output is staged for human sign-off. You are responsible for verifying outputs and for compliance with the laws and regulations that apply to your firm.

---

## Questions or help

- Your Corduroy engagement lead
- `mmoore@corduroyintelligence.com`

We iterate on what's in the toolkit based on what you actually use — tell us what's missing.
