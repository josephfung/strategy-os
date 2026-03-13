<!--
  Strategy OS — Copyright (c) 2026 Joseph Fung (https://josephfung.ca)
  Licensed under the MIT License. See LICENSE file in the project root.
-->
# Phase 4 Reference: Compile to Work

This file contains the strategy-to-work compilation mapping, ticket schema,
traceability tags, and drift definition.

---

## The Compilation Mapping

```
Strategic Objective
  +-- Pillar (3 max)
        +-- Bet (1-3 per pillar)
              +-- Epic / Initiative
                    +-- Project
                          +-- Ticket / Task
```

### Level definitions

| Level | What it is | Owned by | Typical count |
|-------|-----------|----------|---------------|
| Objective | The single strategic goal from the memo | CEO | 1 |
| Pillar | A major strategic commitment that shapes resource allocation | Exec sponsor | 2-4 |
| Bet | Measurable chunk of work tied to a pillar. Has hypothesis + definition of done. | Senior leader | 1-3 per pillar |
| Epic / Initiative | Body of work delivering on a bet. Maps to "epic" in most tools. | Team lead | 2-5 per bet |
| Project | Scoped effort within an epic with clear deliverable and timeline. | IC or team lead | As needed |
| Ticket / Task | Atomic unit of work. Assignable, completable, trackable. | IC | As needed |

### What is a "Bet"?

A bet bridges strategy and execution. It has:
- **Hypothesis**: what we believe will happen if we execute this bet
- **Definition of done**: how we know the bet paid off (outcome, not output)
- **Time horizon**: usually 1-2 quarters
- **Single owner**: one person accountable for the outcome

Example: If Pillar 1 is "Win the mid-market segment," a bet might be "Launch
self-serve onboarding for teams of 10-50 by Q3. Hypothesis: this reduces
sales-assisted onboarding by 40%."

---

## Ticket Schema

Every work item from the compilation should include:

| Field | Required | Description |
|-------|----------|-------------|
| Title | Yes | Clear, specific description of the work |
| Pillar | Yes | Which strategic pillar (P1, P2, P3) |
| Bet | Yes | Which bet (P1-B1, P1-B2, etc.) |
| Hypothesis | Yes for bets/epics | What we believe will happen |
| Definition of done | Yes | Observable outcome, not just "shipped" |
| Owner | Yes | Single accountable person |
| Dependencies | If any | Other tickets, teams, or external factors |
| Risks | If any | What could block or delay this |
| Memo backlink | Yes | Section reference in memo (e.g., "Pillar 2, Initiative 3") |
| Tags | Yes | pillar:P1, bet:P1-B1, status:active |

---

## Traceability Tags

### Full tag set

| Tag / Field | Type | Description | Example |
|------------|------|-------------|---------|
| `pillar` | Single-select | Strategic pillar | P1, P2, P3 |
| `bet` | Single-select | Bet within pillar | P1-B1, P2-B2 |
| `initiative` | Text | Epic or initiative name | self-serve-onboarding |
| `tradeoff` | Text | Related trade-off | T1: Growth over profitability |
| `risk` | Text | Risk being mitigated | R2: Key hire dependency |
| `memo_section` | Text | Memo section reference | Pillar 2, Initiative 3 |
| `decision_id` | Text | Links to decision log | D-2026-03-01 |
| `drift` | Boolean/label | Work not mapped to a pillar | DRIFT |

### Minimal viable tag set (start here)

| Tag | Why it matters |
|-----|---------------|
| `pillar` | Enables "what % of work maps to each pillar" queries |
| `bet` | Connects work to measurable hypotheses |
| `memo_section` | Makes every item traceable to the strategy document |
| `drift` | Forces conversation about off-strategy work |
| `decision_id` | Links work to authorizing decision |

### Naming conventions

- Pillars: P1, P2, P3
- Bets: P1-B1, P1-B2, P2-B1 (pillar prefix + bet number)
- Initiatives: P1-B1-onboarding, P2-B1-pricing-test (lowercase, hyphenated, short)
- Trade-offs: T1, T2, T3
- Risks: R1, R2, R3
- Decisions: D-YYYY-MM-DD

---

## Compilation Rules

1. Every ticket maps to a pillar or gets flagged as DRIFT
2. Each pillar has 1-3 bets. More than 3 = over-scoped, force a cut.
3. Prefer fewer, larger bets over many small initiatives
4. Bets need hypotheses, not just task lists
5. Definitions of done must be outcomes, not outputs
6. Backlinks to memo sections are mandatory

---

## Compilation Output Formats

### Format 1: Structured Outline

```
OBJECTIVE: [FROM MEMO]

PILLAR 1: [NAME]
  Sponsor: [NAME]

  BET P1-B1: [NAME]
    Hypothesis: [STATEMENT]
    Definition of done: [OUTCOME]
    Owner: [NAME]
    Timeline: [QUARTER]

    EPIC: [NAME]
      - Ticket: [TITLE] | Owner: [NAME] | DoD: [OUTCOME]
      - Ticket: [TITLE] | Owner: [NAME] | DoD: [OUTCOME]

  BET P1-B2: [NAME]
    ...

PILLAR 2: [NAME]
  ...
```

### Format 2: CSV-Style Table

| Title | Type | Pillar | Bet | Hypothesis | Definition of done | Owner | Dependencies | Risks | Memo section | Tags |
|-------|------|--------|-----|------------|-------------------|-------|-------------|-------|-------------|------|
| [TITLE] | Bet | P1 | P1-B1 | [HYPOTHESIS] | [OUTCOME] | [NAME] | [DEPS] | [RISKS] | [SECTION] | pillar:P1, bet:P1-B1 |
| [TITLE] | Epic | P1 | P1-B1 | — | [OUTCOME] | [NAME] | [DEPS] | [RISKS] | [SECTION] | pillar:P1, bet:P1-B1 |
| [TITLE] | Ticket | P1 | P1-B1 | — | [OUTCOME] | [NAME] | [DEPS] | [RISKS] | [SECTION] | pillar:P1, bet:P1-B1 |

### After compilation

1. Flag any pillar with 0 bets or >3 bets
2. List "UNKNOWN" work items the memo implies but doesn't name
3. Review with the CEO, fill in owners, then import into project management tool

---

## Drift Definition

Work is flagged as DRIFT when:

1. **No pillar mapping**: Cannot be tagged P1, P2, or P3
2. **Contradicts a trade-off**: E.g., building enterprise SSO when trade-off says
   "we choose SMB over enterprise"
3. **No authorizing decision**: Someone created it but no one decided it was priority
4. **Deprioritized pillar**: Zombie work from a previous strategy cycle

### What to do with drift

Drift isn't automatically bad — sometimes it's urgent operational work or a valid
opportunity. The point is to make it visible.

1. Tag it DRIFT
2. In the next weekly/monthly review: absorb into a pillar, approve as exception, or cut
3. If drift exceeds 20% of active work, the strategy or work system needs a reset

---

## Change Log Convention

When the strategy changes, record it:

| Date | Change type | Description | Affected items | Decision by | Decision ID |
|------|------------|-------------|---------------|-------------|-------------|
| [YYYY-MM-DD] | Pillar added/removed/renamed | [WHAT] | [ITEMS] | [WHO] | [D-YYYY-MM-DD] |
| [YYYY-MM-DD] | Bet added/cut/restructured | [WHAT] | [ITEMS] | [WHO] | [D-YYYY-MM-DD] |
| [YYYY-MM-DD] | Trade-off revised | [OLD to NEW] | [ITEMS] | [WHO] | [D-YYYY-MM-DD] |

Rules:
- Every strategy change gets a decision_id
- Affected work items get updated tags or flagged for review
- Change log is reviewed in monthly pillar reviews
- Memo is updated; old versions marked _ARCHIVE

---

## MCP Integration Notes

When connected to Jira, Monday, or ClickUp:

### Read operations (always available)
- Query all tickets and check for pillar tag coverage
- Count tickets per pillar to assess resource allocation balance
- Find tickets without pillar tags (potential drift)
- Pull completed tickets for drift detection and cadence reports

### Write operations (require explicit approval)
- Create epics and tickets with proper tags and schema fields
- Update existing tickets with pillar/bet tags
- Add memo_section backlinks to existing work items

### Operating mode
Default to draft-only: present all proposed changes as a table for CEO review
before executing any writes. Only move to write-with-approval mode after the CEO
explicitly requests it.
