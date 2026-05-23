<!--
  Strategy OS — Copyright (c) 2026 Joseph Fung (https://josephfung.ca)
  Licensed under the MIT License. See LICENSE file in the project root.
-->
# Phase 5 Reference: Steer and Govern

This file contains drift detection, cadence prompts (weekly/monthly/quarterly),
and agent guardrails for ongoing strategy governance.

---

## Drift Detection

### Weekly Drift Checklist (10 minutes)

Run at the start of each weekly exec or SLT meeting:

- [ ] **Shipped work not mapped to pillars.** Can every completed item trace to P1,
  P2, or P3? Flag anything that cannot.
- [ ] **Pillars with activity but no movement.** Lots of tickets closing but no
  progress on the bet hypothesis or key metric? Activity without movement is a
  warning sign.
- [ ] **Trade-offs violated.** Did we do anything that contradicts a stated trade-off?
  Even "just this once" is worth noting.
- [ ] **New information requiring memo updates.** Market signal, customer feedback, or
  competitive move that should change the memo? Log it as a proposed edit.
- [ ] **Decisions made outside the memo.** Strategic decisions in meetings, Slack, or
  email not reflected in the memo or decision log?

### Drift Report Format

When running drift detection (from a changelog or live project data), produce:

```
## Drift Summary (5 bullets max)
- [KEY FINDING 1]

## Off-Strategy Work
| # | Work item | Pillar mapping | Issue | Basis |
|---|----------|---------------|-------|-------|
| 1 | [ITEM] | None / Unclear | [WHY OFF-STRATEGY] | Explicit / Inferred / Unknown |

## Recommended Cuts or Reprioritization
| # | Recommendation | Affected work | Rationale |

## Memo Edits Suggested
| # | Section | Current text (summary) | Suggested change | Reason |

## Pillar Health Snapshot
| Pillar | Active bets | Movement this week | Key metric trend | Health |
|--------|------------|-------------------|-----------------|--------|
| P1: [NAME] | [COUNT] | Yes / Some / None | Up / Flat / Down / Unknown | Green / Yellow / Red |
| P2: [NAME] | [COUNT] | Yes / Some / None | Up / Flat / Down / Unknown | Green / Yellow / Red |
| P3: [NAME] | [COUNT] | Yes / Some / None | Up / Flat / Down / Unknown | Green / Yellow / Red |
```

### Rules
- Base analysis only on the memo and the changelog provided
- Label each finding: EXPLICIT / INFERRED / UNKNOWN
- Do not soften findings. If there is drift, name it.
- Do not recommend adding new work. Only recommend cutting, reprioritizing, or
  updating the memo.

---

## Cadence Prompts

Three templates. Each requires: memo + changelog/task list + metrics snapshot.

### Weekly Exec Update

**Output** (~1 page max):

```
## Week of [DATE]

### Highlights (3-5 bullets)
- [WHAT WENT WELL — tied to a pillar or bet]

### Lowlights (3-5 bullets)
- [WHAT DID NOT GO WELL — tied to a pillar or bet]

### Decisions Needed
| # | Decision | Context | Owner | Deadline |

### Risks (new or escalated)
| # | Risk | Pillar affected | Severity (H/M/L) | Mitigation |

### Next Week Focus (3-5 bullets)
- [PRIORITY — tied to a pillar or bet]
```

### Monthly Pillar Review

**Output** (per-pillar assessment):

For each pillar:
```
### Pillar [N]: [NAME]

**Status:** ON TRACK / AT RISK / OFF TRACK

**Bets in progress:**
| Bet | Progress | Key metric | Target | Actual | Assessment |

**What shipped:** [2-3 bullets]
**What is blocked or behind:** [2-3 bullets]
**Recommended action:** CONTINUE / ADJUST / ESCALATE
```

Then cross-pillar:
```
### Risks (cross-pillar)
| # | Risk | Pillars affected | New this month? | Recommended action |

### Reallocation proposals
| # | From | To | Rationale |

### Decisions Needed
| # | Decision | Context | Owner | Deadline |
```

### Quarterly Planning Packet

**Output**:

```
## Quarterly Planning Packet — [QUARTER YEAR]

### What changed this quarter
**External changes:** (market, competitive, regulatory)
**Internal changes:** (team, product, metrics, learnings)

### Pillar-by-pillar results
| Pillar | Key metric | Target | Actual | Bets completed | Bets behind | Assessment |

### Proposed strategy edits
| # | Section | Current | Proposed change | Rationale |

### Bets to reset or retire
| Bet | Status | Recommendation | Rationale |

### New bets proposed for next quarter
| Bet | Pillar | Hypothesis | Definition of done | Owner |

### Decisions Needed
| # | Decision | Context | Owner | Deadline |
```

### Rules for all cadence outputs
- Base on memo, task list, and metrics provided
- Label observations: EXPLICIT / INFERRED / UNKNOWN
- If data is missing for a pillar, say so — do not invent progress
- Include a "Decisions Needed" section in every cadence output

### Making cadence semi-automatic

**With file access**: Keep a running `cadence-inputs.md` file with changelog and
metrics. Update it weekly. Point the skill at the memo + cadence-inputs file.

**With MCP connections**: Query the project tool for completed tickets and the
metrics dashboard for numbers. Replace manual paste with live data.

**Scheduled**: If the environment supports scheduled tasks, run the weekly update
every Monday morning so the CEO starts the week reviewing a draft, not writing one.

---

## Agent Guardrails

### Permissioning Progression

Never skip levels. New tool connections start at Level 0.

| Level | Access | What the agent can do | When to use |
|-------|--------|--------------------|-------------|
| Level 0: Read-only | Read access to docs and tools | Summarize, analyze, generate reports, draft recommendations | Start here. Prove accuracy before granting write access. |
| Level 1: Draft-only | Read + create drafts (not published) | Draft tickets, memos, updates — all require human approval before going live | Use for 2-4 weeks minimum. Review every draft. |
| Level 2: Write with approval | Read + create + update, with human approval gate | Create tickets, update fields, generate comms — every write requires confirmation | Default operating mode for most teams. |
| Level 3: Autonomous (limited) | Read + write for specific low-risk actions | Auto-tag tickets, generate weekly summaries, update status fields | Only for well-tested, low-risk, reversible actions. |

### Write Actions Protocol

Every write action follows this sequence:
1. **Agent proposes**: Describes what it will do, to which object, and why
2. **Human reviews**: Approver can approve, edit, or reject
3. **Agent executes**: Only after explicit approval
4. **Agent logs**: Records in the audit log

### What counts as a write action
- Creating a ticket, epic, or project
- Updating status, owner, tags, or description
- Sending a message (email, Slack, comment)
- Modifying a document
- Changing a field in a work tool
- Any action visible to someone other than the operator

### What does NOT require approval (at Level 2+)
- Reading data
- Generating a draft in a scratch space
- Producing a report for the operator only
- Tagging in a staging area (not the live system)

### Session Setup

At the start of any agentic session, confirm operating mode:

```
Operating mode: [DRAFT-ONLY / WRITE-WITH-APPROVAL]

You may read all connected systems and documents.

[IF DRAFT-ONLY:]
Do not create, update, or delete any items in live systems. Present all
actions as proposals for review.

[IF WRITE-WITH-APPROVAL:]
Before any write action, describe:
1. What you will do
2. To which object/system
3. Why (which pillar, bet, or decision it serves)

Wait for explicit "approved" before executing.
```

### Audit Log Format

| Date | Time | Action | Tool / System | Object | Summary | Approved by | Decision ID |
|------|------|--------|--------------|--------|---------|-------------|-------------|
| YYYY-MM-DD | HH:MM | Created/Updated/Deleted | [Tool] | [ID/Name] | [1 sentence] | [NAME or AUTO] | [D-YYYY-MM-DD or N/A] |

Rules:
- Log every write, no exceptions
- Include the approver (or "AUTO" with the permitting rule)
- Link to the authorizing decision ID when applicable
- Review weekly as part of drift detection
- Retain for 90 days minimum

### Weekly Audit Log Review

At week's end, review the log and flag:
1. Actions without a decision_id
2. Actions that don't clearly connect to a pillar or bet
3. Unusually high volume of writes to any single system or pillar
4. Patterns suggesting the agent is doing more than intended
5. Destructive actions (deletes, bulk edits) deserving extra scrutiny

Produce:
```
## Audit Summary
- Total actions this week: [COUNT]
- Actions with decision_id: [COUNT]
- Actions without decision_id: [COUNT] — [LIST]
- Potential concerns: [LIST]

## Recommended actions
- [WHAT TO INVESTIGATE OR TIGHTEN]
```
