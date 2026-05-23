<!--
  Strategy OS — Copyright (c) 2026 Joseph Fung (https://josephfung.ca)
  Licensed under the MIT License. See LICENSE file in the project root.
-->
# Phase 2 Reference: Stress Tests

This file contains four structured stress tests and their follow-up integration
prompts. Run at least 2 before approving the memo.

---

## Stress Test 1: Pre-Mortem

### Setup

Requires: the Strategy Consolidation Memo.

### What to produce

**Step 1**: Generate 10 failure modes, at least one from each category:
- Market (demand, timing, competition)
- Product (execution, technical debt, wrong bet)
- Go-to-market (sales, marketing, positioning)
- People (hiring, retention, capability gaps)
- Finance (cash, unit economics, fundraising)
- Operations (process, coordination, scale)

**Step 2**: Select the top 3 most likely given this specific memo. Explain why.

**Step 3**: For each top 3, provide:
- Earliest warning signal (what you would see first)
- Concrete mitigation (what to do now)
- Suggested owner (role, not person)

### Output format

```
## All 10 Failure Modes

| # | Failure mode | Category | Basis | Likelihood (H/M/L) |
|---|-------------|----------|-------|-------------------|

## Top 3 Most Likely

### Failure mode 1: [NAME]
**Why this is likely:** [2-3 sentences specific to the memo]
**Earliest warning signal:** [What you would observe first]
**Mitigation:** [What to do now]
**Owner:** [PLACEHOLDER]

(repeat for 2 and 3)

## Summary: What This Tells You
[3-5 bullets]
```

### Rules
- Be specific. "Execution risk" is not a failure mode.
- Do not soften the analysis. The point is to find real problems.
- Label each failure mode: EXPLICIT / INFERRED / UNKNOWN.

### Follow-up: Integrate into memo

After the pre-mortem, compare top 3 against the memo's "Key Risks and Assumptions":
1. For failure modes NOT in the memo — draft new risk table rows
2. For failure modes in the memo but weakly framed — suggest revisions
3. Draft 2-3 new entries for "Open Questions" based on warning signals

---

## Stress Test 2: Bull / Bear Case

### Setup

Requires: the Strategy Consolidation Memo.

### What to produce

**Step 1 — Bull case** (250-400 words): The strongest argument this strategy will
succeed. Ground it in the memo's specific choices, positioning, and trade-offs.

**Step 2 — Bear case** (250-400 words): The strongest argument this strategy will
fail. Identify weakest links, most fragile assumptions, scenarios where the plan
breaks down.

**Step 3 — Assumptions**: For each case, list assumptions that must be true.

| # | Assumption | Status | Basis |
|---|-----------|--------|-------|
| 1 | [ASSUMPTION] | Proven / Unproven / Mixed | Explicit / Inferred / Unknown |

**Step 4 — Unproven assumptions combined**:

| # | Assumption | From | How to test | Timeline to test |
|---|-----------|------|------------|-----------------|

### Rules
- Do not balance the two artificially. If the bear case is stronger, say so.
- The bull case should be compelling, not a pep talk.
- The bear case should be concerning, not a hedge.

### Follow-up: Design experiments

For each unproven assumption, design a lightweight experiment runnable in 2-4 weeks:
1. What you are testing
2. Method (customer interviews, data analysis, A/B test, etc.)
3. Sample size or scope (realistic for a startup)
4. Success criteria (what validates or invalidates the assumption)
5. Owner suggestion (role)
6. Time cost (hours/days)

---

## Stress Test 3: Constraint Shock

### Setup

Requires: the Strategy Consolidation Memo.
Optional: current headcount, runway in months, top competitor name (defaults: 50
people, 18 months, "a well-funded direct competitor").

### What to produce

Rewrite the strategy under each of three constraints (independently — don't carry
changes between scenarios):

**Constraint 1: 50% fewer people**
**Constraint 2: Runway halved**
**Constraint 3: Competitor launches your core feature**

For each constraint, produce:

```
## Constraint [N]: [NAME]

### What to cut (5 items)
| # | Cut | Pillar affected | Why |

### What to protect (5 items)
| # | Protect | Pillar | Why this survives |

### Trade-offs that change (3-6 forced choices)
| Original trade-off | New trade-off | Why it shifts |

### 90-day plan (6-10 bullets)
- Week 1-2: [ACTION]
- Week 3-4: [ACTION]
- Month 2: [ACTION]
- Month 3: [ACTION]
```

### Cross-constraint insights (after all three)

- What was protected in all 3? (True priorities)
- What was cut in all 3? (Lower priority than you think)
- What trade-off shifted most? (Most fragile commitment)

### Rules
- Do not add new initiatives. Only keep, cut, or restructure what's in the memo.
- Be specific — name the pillar, initiative, or trade-off.
- Label recommendations: EXPLICIT / INFERRED / UNKNOWN.

### Follow-up: Update the memo

1. Items protected in all 3: adequately emphasized in memo? Strengthen if not.
2. Items cut in all 3: currently high-priority in memo? Flag disconnect.
3. Most fragile trade-off: suggest revised language.
4. Draft a "Contingency posture" paragraph (3-5 sentences) for the Operating System
   section: what we protect first, what we cut first, what triggers a strategy reset.

---

## Stress Test 4: Synthetic Stakeholder Panel

### Setup

Requires: the Strategy Consolidation Memo.

### Reviewers

1. **CFO** — unit economics, cash efficiency, sequencing of spend, financial viability
2. **Head of Sales** — pipeline realities, positioning, competitive objections, quotas
3. **Key Customer Champion** — buying friction, switching costs, implementation pain,
   roadmap relevance
4. **Skeptical Board Member** — focus, defensibility, speed, CEO honesty about risks
5. **Competitor PM** — where to attack, what to copy, perceived weakness

### What to produce

For each reviewer:

```
## [REVIEWER TITLE]

### Top 3 Objections
| # | Objection | Basis |

### Top 3 Questions
1. [QUESTION]
2. [QUESTION]
3. [QUESTION]

### What evidence would change their mind
- [EVIDENCE 1-3]

### Suggested memo revision
[One specific change with section reference]
```

### Aggregation

After all 5 reviewers:

**Repeated objections (top 5)**: Concerns raised by 2+ reviewers.

| # | Objection | Raised by | Times raised |

**"If you only fix 2 things..."**: The 2 highest-leverage changes.

### Rules
- Each reviewer should be tough but fair.
- Reviewers should disagree with each other where perspectives naturally conflict.
- Label each objection: EXPLICIT / INFERRED / UNKNOWN.

### Follow-up: Draft memo revisions

1. For each "fix 2 things" recommendation — draft specific before/after revisions
2. For top 5 repeated objections — check if memo already addresses them; if not,
   suggest where to add a response
3. For evidence items appearing across multiple reviewers — draft new Open Questions
   entries specifying what evidence to gather
