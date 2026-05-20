---
description: Review a real-estate financial model for broken formulas, circular references, RE-specific assumption errors (exit cap < entry cap unjustified, expense growth out of sync with rent growth, IRR manipulation patterns), and balance-sheet integrity. Recognizes cap rates, NOI builds, GPI/EGI/NOI lines, debt service waterfalls, equity multiples. Use for junior-analyst QA or pre-IC sanity check.
---

Invoke the `model-reviewer` skill with $ARGUMENTS as the model context (deal name, model type — DCF/LBO/3-statement). Ask for the model (Excel exported to CSV, pasted formulas, or a Python representation) and produce a structured findings report.
