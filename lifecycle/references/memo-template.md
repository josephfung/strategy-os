<!--
  Strategy OS — Copyright (c) 2026 Joseph Fung (https://josephfung.ca)
  Licensed under the MIT License. See LICENSE file in the project root.
-->
# Phase 1 Reference: Consolidation

This file contains everything needed for the Consolidate phase: the strategy inventory
checklist, intake interview questions, extraction table format, the full memo template,
and the quality checklist.

---

## Strategy Inventory — Where to Look

Help the user locate artifacts across these 6 categories:

### Board / Investor
- Board deck (most recent + prior quarter)
- Investor update (most recent)
- Fundraising deck or data room narrative
- Board meeting minutes or follow-up notes

### Product
- Product roadmap (current quarter + next)
- Product strategy or vision doc
- PRDs for major initiatives in flight
- Pricing and packaging doc
- User research synthesis or persona docs

### Sales / Marketing
- Sales battle cards
- Positioning doc or messaging framework
- Pitch deck (sales version)
- Win/loss analysis or deal retrospectives
- ICP definition

### Finance
- Annual budget or financial plan
- Financial model (revenue, costs, headcount)
- Unit economics summary
- Runway plan or cash forecast

### Ops / People
- Org design notes or org chart rationale
- Hiring plan (current and next quarter)
- Quarterly priorities, OKRs, or goal-setting docs
- Operating cadence doc

### Decision Trails
- Meeting notes from strategy discussions
- Slack or Teams threads where strategic decisions were debated
- Decision logs
- Offsite outputs or workshop artifacts

### Minimum viable corpus (if short on time)

1. Most recent board deck
2. Most recent investor update
3. Current product roadmap
4. Positioning doc or sales pitch deck
5. Financial model or budget
6. Current quarter OKRs or priorities
7. Hiring plan
8. One set of meeting notes from a recent strategy discussion
9. Sales battle cards or win/loss notes
10. Any doc the CEO would call "the strategy doc"

### What NOT to include
- Raw data exports (unless they contain a specific strategic insight)
- Giant slide decks with no clear strategic content (extract relevant slides)
- Outdated duplicates (keep current version, mark others _ARCHIVE)
- Operational playbooks (unless they contain strategic context)

---

## File Naming Convention

```
YYYY-MM_CATEGORY_Subject_OWNER_STATUS.ext
```

Categories: BOARD, INVESTOR, PROD, SALES, MKTG, FIN, OPS, PEOPLE, NOTES
Status: _CANON (source of truth), _LATEST, _DRAFT, _ARCHIVE

If helping rename files, propose a table first — do not rename without user review.

---

## Intake Interview Questions

Ask all questions before the user answers. Skip questions the artifacts already answer
(cite the source). Group by category:

### Objective and Horizon
1. What is the single strategic objective for the next [TIME HORIZON]?
2. What time horizon are you planning against?
3. What does "winning" look like at the end of that horizon?

### Where We Play / How We Win
4. Who is your primary customer? Has this changed recently?
5. What market or problem space are you focused on? What is out of scope?
6. What is your primary advantage or differentiator?
7. Are there segments or geographies you are choosing not to pursue?

### Pillars and Sequencing
8. What are the 3 strategic pillars for this period?
9. Why these pillars and not others? What did you reject?
10. Is there a sequencing dependency between pillars?
11. Which pillar gets the most resources? Does that match stated priority?

### Trade-offs and Constraints
12. What are you explicitly choosing NOT to do?
13. What trade-off would be most uncomfortable to say publicly?
14. What constraint most limits your options right now?

### Risks and Assumptions
15. What must be true about your market for this strategy to work?
16. What must be true about your product or technology?
17. What is the biggest assumption you have not yet validated?

### Canonical Source
18. When artifacts contradict each other, which document or person is the tiebreaker?

### After the interview

Present a strategy skeleton for approval before drafting:

```
STRATEGY SKELETON
- Objective: [1 sentence]
- Time horizon: [X months/years]
- Where we play: [1 sentence]
- How we win: [1 sentence]
- Pillar 1: [name + 1 sentence]
- Pillar 2: [name + 1 sentence]
- Pillar 3: [name + 1 sentence]
- Top trade-off: [We choose X over Y]
- Top risk: [1 sentence]
- Biggest open question: [1 sentence]
```

Do not proceed to the full memo draft until the CEO confirms the skeleton.

---

## Extraction Table Format

One claim per row. When artifacts contradict, record both versions — do not reconcile.

| # | Claim / Snippet | Type | Category | Source file | Date | Notes / Contradictions |
|---|----------------|------|----------|-------------|------|----------------------|
| 1 | [Direct quote or paraphrase] | Explicit / Inferred / Unknown | [Category] | [Filename] | [YYYY-MM] | [Conflicts, caveats] |

### Category tags
- Objective: The strategic objective or north-star goal
- Pillar: A major strategic priority or commitment
- Initiative: A specific project, bet, or effort under a pillar
- Trade-off: Something the company is choosing not to do
- Risk: A threat, vulnerability, or fragile assumption
- Market: Claims about the market, customers, or competitive landscape
- Differentiator: Claims about what makes the company unique
- Constraint: Limits on resources, time, technology, or capability

### After extraction — Clustering

1. Filter for Pillar and Initiative rows
2. Group into 3-5 clusters by theme, segment, or capability
3. Name each cluster (these become pillar candidates)
4. Check: each cluster should have 2-5 initiatives
5. Flag orphans (initiatives that don't fit any cluster)
6. Flag clusters with <2 or >5 initiatives

---

## Strategy Consolidation Memo Template

### [COMPANY] Strategy Consolidation Memo

**Date:** [YYYY-MM-DD]
**Owner:** [CEO NAME]
**Scope:** [Company-wide / Business unit / Product line]
**Time horizon:** [e.g., 12 months with 3-year directional view]
**Status:** [DRAFT / REVIEW / CANON]

---

### Executive Summary

Write a tight summary in 10 lines or fewer. A reader should understand the strategic
direction, key bets, and primary trade-offs from this section alone.

[WRITE EXECUTIVE SUMMARY HERE]

---

### Strategic Objective

One to two sentences. What are we trying to accomplish, and by when?

[WRITE STRATEGIC OBJECTIVE HERE]

**Time horizon:** [e.g., "Become the default platform for [SEGMENT] within 18 months"]

---

### Where We Play

- **Target customer:** [WHO]
- **Market / segment:** [WHAT]
- **Geography:** [WHERE, if relevant]
- **Use case or problem:** [WHY THEY BUY]

---

### How We Win

What is our advantage? Why will we win against alternatives?

[WRITE HOW WE WIN HERE]

---

### Strategic Pillars and Initiatives

Three is the discipline. Each pillar should shape resource allocation.

#### Pillar [N]: [PILLAR NAME]

**Why this pillar matters:** [1-2 sentences]

**Key initiatives:**

| Initiative | Owner | Horizon | Hypothesis | Definition of done |
|-----------|-------|---------|------------|-------------------|
| [INITIATIVE] | [NAME] | [Q/YEAR] | [What we believe] | [How we know it worked] |

**Key metric:** [The outcome metric for this pillar]

**Dependencies:** [What must be true for this pillar to succeed]

_(Repeat for each pillar. Aim for 3.)_

---

### Implied Trade-offs and Non-goals

| We choose | Over | Because | We accept the risk of |
|-----------|------|---------|----------------------|
| [X] | [Y] | [REASON] | [RISK] |

**Non-goals:**
- [NON-GOAL 1]
- [NON-GOAL 2]
- [NON-GOAL 3]

---

### Key Risks and Assumptions

| Assumption | Status | Evidence | What breaks if wrong |
|-----------|--------|----------|---------------------|
| [ASSUMPTION] | Proven / Unproven / Mixed | [EVIDENCE] | [CONSEQUENCE] |

**Top 3 risks:**
1. [RISK]: Likelihood [H/M/L], Impact [H/M/L]. Mitigation: [ACTION].
2. [RISK]: Likelihood [H/M/L], Impact [H/M/L]. Mitigation: [ACTION].
3. [RISK]: Likelihood [H/M/L], Impact [H/M/L]. Mitigation: [ACTION].

---

### Operating System

- **Decision cadence:** [e.g., Weekly SLT, monthly pillar review, quarterly planning]
- **Decision rights:** [Who can change pillar priorities?]
- **Review rhythm:** [How often do we check the memo against reality?]
- **Key metrics reviewed:** [Which 3-5 metrics do we track?]
- **Drift detection:** [How do we catch off-strategy work?]

---

### Open Questions / Required Decisions

| Question | Decision owner | Deadline | Missing information |
|----------|---------------|----------|-------------------|
| [QUESTION] | [WHO] | [WHEN] | [WHAT IS NEEDED] |

---

### Appendix: Source Inventory and Conflicts

| Source file | Category | Date | Status | Notes |
|------------|----------|------|--------|-------|
| [FILENAME] | [CATEGORY] | [DATE] | CANON / ARCHIVE | [Conflicts or caveats] |

**Conflicts found:**
- [ARTIFACT A] says [X]. [ARTIFACT B] says [Y]. Resolution: [DECISION or OPEN QUESTION].

---

## Quality Checklist

The memo is ready for sign-off when all 8 criteria pass:

1. Executive summary is understandable without reading the rest
2. Strategic objective is a single clear sentence with a time horizon
3. Pillars are choices (not functional labels like "Product" or "Sales")
4. At least 3 explicit trade-offs in forced-choice format
5. Risk section includes at least one genuinely uncomfortable risk
6. Contradictions between source artifacts are listed, not silently resolved
7. Open questions are small and specific
8. Every major claim traces to a source artifact or CEO decision

Run this check before presenting the memo draft. Report results as a pass/fail table
with notes on what to fix.
