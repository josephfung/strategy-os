# Shared Data Store Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Move all Strategy OS data file references from project-relative `data/` paths to a fixed, environment-agnostic `~/.claude/strategy-os/data/` directory so that Claude Code and Claude Desktop share a single data store.

**Architecture:** Five skill files contain `data/` path references — replace every occurrence with `~/.claude/strategy-os/data/`. Add a path-expansion note to each skill and a First-Run Check section to `SKILL.md` that bootstraps the data directory on first use. Reset the project's `data/` folder to template state (it stays in the repo as shipped starters, not live data).

**Tech Stack:** Markdown only. No build steps. No compiled code. Verification is grep-based.

---

## Task 1: Baseline verification

**Files:**
- Read: `SKILL.md`, `lifecycle/SKILL.md`, `strategy-analyst/SKILL.md`, `strategy-analyst/hook.md`, `strategy-coach/SKILL.md`

- [ ] **Step 1: Grep all bare `data/` references across skill files**

Run:
```bash
grep -rn "data/" SKILL.md lifecycle/SKILL.md strategy-analyst/SKILL.md strategy-analyst/hook.md strategy-coach/SKILL.md
```

Expected: output matches the audit below (all references are bare `data/X` paths, none yet prefixed with `~/.claude/strategy-os/`). This establishes the baseline. Save the count — you'll verify it drops to zero in Task 6.

Known references per file:
- `SKILL.md`: 7 references (lines 13, 33, 35, 37, 72, 90, 102)
- `lifecycle/SKILL.md`: 14 references
- `strategy-analyst/SKILL.md`: 12 references
- `strategy-analyst/hook.md`: 6 references
- `strategy-coach/SKILL.md`: 21 references

- [ ] **Step 2: Confirm worktree is on the right branch**

Run:
```bash
git branch --show-current
```

Expected: `feat/shared-data-store`

---

## Task 2: Update `SKILL.md`

**Files:**
- Modify: `SKILL.md`

- [ ] **Step 1: Update the skill description frontmatter**

Find and replace:
```
  Maintains ambient awareness when data/strategy.md exists.
```
With:
```
  Maintains ambient awareness when ~/.claude/strategy-os/data/strategy.md exists.
```

- [ ] **Step 2: Add path expansion note and First-Run Check section**

Find:
```
Read `shared/principles.md` before doing any work. The six principles there apply to
all three modes without exception.

---

## Ambient Context (load at session start)
```

Replace with:
```
Read `shared/principles.md` before doing any work. The six principles there apply to
all three modes without exception.

When reading or writing files in this skill, expand `~` to the user's home directory
(e.g. `/Users/username` on macOS, `/home/username` on Linux).

---

## First-Run Check (silent)

Before loading ambient context, check whether the Strategy OS data directory exists:

1. Check if `~/.claude/strategy-os/data/` exists.
2. If not:
   a. Create it: run `mkdir -p ~/.claude/strategy-os/data`
   b. Check if the plugin's template files are available under
      `~/.claude/plugins/cache/josephfung/strategy-os/` (any version subfolder).
      If found, copy any files from its `data/` subdirectory to
      `~/.claude/strategy-os/data/` — but only if the destination file does not
      already exist (never overwrite live data).
   c. If the plugin path is not resolvable, skip the copy — the normal first-run
      flows (Phase 1, coach setup interview) will create the files organically.
3. If the directory cannot be created due to a permissions error, emit once:
   > "Strategy OS: could not create ~/.claude/strategy-os/data/. Check directory
   > permissions. Data will not be saved this session."
   Then continue without writing any files this session.

---

## Ambient Context (load at session start)
```

- [ ] **Step 3: Update ambient context — strategy-header path**

Find:
```
If `data/strategy-header.md` exists, load it silently (~150 tokens). This gives all
three modes a lightweight awareness of the strategy without loading the full
`data/strategy.md`. Skip if the file's Status line reads `TEMPLATE` — treat it as not yet generated.
```

Replace with:
```
If `~/.claude/strategy-os/data/strategy-header.md` exists, load it silently (~150 tokens). This gives all
three modes a lightweight awareness of the strategy without loading the full
`~/.claude/strategy-os/data/strategy.md`. Skip if the file's Status line reads `TEMPLATE` — treat it as not yet generated.
```

- [ ] **Step 4: Update ambient context — watcher-memory-summary path**

Find:
```
If `data/watcher-memory-summary.md` exists, load it silently (~100 tokens). This
```

Replace with:
```
If `~/.claude/strategy-os/data/watcher-memory-summary.md` exists, load it silently (~100 tokens). This
```

- [ ] **Step 5: Update Mode 2 routing — strategy-header path**

Find:
```
strategy-adjacent language appears in the conversation
- Detection is less precise than the hook (no per-message cool-down), but covers
  the same signal clusters
```

Wait — that's in `hook.md`. In `SKILL.md` line 72:

Find:
```
customer contracts, or pivots — AND `data/strategy-header.md` exists. Check for
```

Replace with:
```
customer contracts, or pivots — AND `~/.claude/strategy-os/data/strategy-header.md` exists. Check for
```

- [ ] **Step 6: Update Mode 3 routing — kpi-registry path**

Find:
```
`data/kpi-registry.md` doesn't exist yet (first-run setup), or when the coach's
```

Replace with:
```
`~/.claude/strategy-os/data/kpi-registry.md` doesn't exist yet (first-run setup), or when the coach's
```

- [ ] **Step 7: Update output formatting section**

Find:
```
- When producing files, save to `data/` unless the user specifies otherwise
```

Replace with:
```
- When producing files, save to `~/.claude/strategy-os/data/` unless the user specifies otherwise
```

- [ ] **Step 8: Commit**

```bash
git add SKILL.md
git commit -m "feat: update SKILL.md to use shared ~/.claude/strategy-os/data path"
```

---

## Task 3: Update `lifecycle/SKILL.md`

**Files:**
- Modify: `lifecycle/SKILL.md`

- [ ] **Step 1: Add path expansion note**

Find:
```
Read `shared/principles.md` before doing any work in this skill. The six principles
there are non-negotiable and apply to every phase.
```

Replace with:
```
Read `shared/principles.md` before doing any work in this skill. The six principles
there are non-negotiable and apply to every phase.

When reading or writing files in this skill, expand `~` to the user's home directory
(e.g. `/Users/username` on macOS, `/home/username` on Linux).
```

- [ ] **Step 2: Update Phase 1 goal line**

Find:
```
to `data/strategy.md`.
```

Replace with:
```
to `~/.claude/strategy-os/data/strategy.md`.
```

- [ ] **Step 3: Update Phase 1 save step**

Find:
```
7. **Save**: Write the approved memo to `data/strategy.md`. After saving, generate
   a 1-2 sentence summary of the strategy and write it to `data/strategy-header.md`.
   See `data/strategy-header.md` for the format.

   Append to `data/audit-log.jsonl` for each write:
   ```json
   {"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-lifecycle","action":"write","target_file":"data/strategy.md","summary":"Phase 1 consolidation: saved approved strategy memo","approved_by":"ceo-approval","decision_id":null}
   ```
   And a second entry for `data/strategy-header.md` with `"action":"generate"` and an appropriate summary.
```

Replace with:
```
7. **Save**: Write the approved memo to `~/.claude/strategy-os/data/strategy.md`. After saving, generate
   a 1-2 sentence summary of the strategy and write it to `~/.claude/strategy-os/data/strategy-header.md`.
   See `~/.claude/strategy-os/data/strategy-header.md` for the format.

   Append to `~/.claude/strategy-os/data/audit-log.jsonl` for each write:
   ```json
   {"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-lifecycle","action":"write","target_file":"~/.claude/strategy-os/data/strategy.md","summary":"Phase 1 consolidation: saved approved strategy memo","approved_by":"ceo-approval","decision_id":null}
   ```
   And a second entry for `~/.claude/strategy-os/data/strategy-header.md` with `"action":"generate"` and an appropriate summary.
```

- [ ] **Step 4: Update Phase 2 references (3 occurrences)**

Find and replace each:

| Find | Replace |
|------|---------|
| `` **Goal**: Pressure-test `data/strategy.md` before committing to it. `` | `` **Goal**: Pressure-test `~/.claude/strategy-os/data/strategy.md` before committing to it. `` |
| `` Then integrate findings back into `data/strategy.md`'s risk section. `` | `` Then integrate findings back into `~/.claude/strategy-os/data/strategy.md`'s risk section. `` |
| `` Stress tests that produce interesting insights but don't update `data/strategy.md` `` | `` Stress tests that produce interesting insights but don't update `~/.claude/strategy-os/data/strategy.md` `` |

Also update the audit log line in Phase 2:

Find:
```
to `data/audit-log.jsonl`.
```
Replace with:
```
to `~/.claude/strategy-os/data/audit-log.jsonl`.
```

- [ ] **Step 5: Update Phase 3 references**

Find:
```
Before generating any comms, extract and lock these objects from `data/strategy.md`:
```

Replace with:
```
Before generating any comms, extract and lock these objects from `~/.claude/strategy-os/data/strategy.md`:
```

- [ ] **Step 6: Update Phase 4 references (3 occurrences)**

Find and replace each:

| Find | Replace |
|------|---------|
| `` **Goal**: Translate `data/strategy.md` into a structured, importable work graph. `` | `` **Goal**: Translate `~/.claude/strategy-os/data/strategy.md` into a structured, importable work graph. `` |
| `` 5. Only use content from `data/strategy.md` — do not invent initiatives `` | `` 5. Only use content from `~/.claude/strategy-os/data/strategy.md` — do not invent initiatives `` |

- [ ] **Step 7: Update Phase 5 references**

Find and replace each:

| Find | Replace |
|------|---------|
| `` Run weekly. Compare completed work against `data/strategy.md`. Work is flagged as `` | `` Run weekly. Compare completed work against `~/.claude/strategy-os/data/strategy.md`. Work is flagged as `` |
| `` Three templates, each requiring `data/strategy.md` + a changelog/task list + metrics: `` | `` Three templates, each requiring `~/.claude/strategy-os/data/strategy.md` + a changelog/task list + metrics: `` |
| `` - Log every write action to `data/audit-log.jsonl`: Date, Time, Action, Tool, `` | `` - Log every write action to `~/.claude/strategy-os/data/audit-log.jsonl`: Date, Time, Action, Tool, `` |

- [ ] **Step 8: Update output formatting section**

Find:
```
- When producing files, save to `data/` unless the user specifies otherwise
```

Replace with:
```
- When producing files, save to `~/.claude/strategy-os/data/` unless the user specifies otherwise
```

- [ ] **Step 9: Verify no bare `data/` references remain in this file**

Run:
```bash
grep -n "data/" lifecycle/SKILL.md
```

Expected: zero output. If any lines appear, fix them before proceeding.

- [ ] **Step 10: Commit**

```bash
git add lifecycle/SKILL.md
git commit -m "feat: update lifecycle/SKILL.md to use shared ~/.claude/strategy-os/data path"
```

---

## Task 4: Update `strategy-analyst/SKILL.md` and `strategy-analyst/hook.md`

**Files:**
- Modify: `strategy-analyst/SKILL.md`
- Modify: `strategy-analyst/hook.md`

### strategy-analyst/SKILL.md

- [ ] **Step 1: Update skill description frontmatter**

Find:
```
  market positioning, customer contracts, or pivots — and data/strategy.md exists.
```

Replace with:
```
  market positioning, customer contracts, or pivots — and ~/.claude/strategy-os/data/strategy.md exists.
```

- [ ] **Step 2: Add path expansion note**

Find:
```
Read `shared/principles.md` before doing anything.
```
(This is the first occurrence, at the top of the file body.)

Replace with:
```
Read `shared/principles.md` before doing anything.

When reading or writing files in this skill, expand `~` to the user's home directory
(e.g. `/Users/username` on macOS, `/home/username` on Linux).
```

- [ ] **Step 3: Update "You Have Been Invoked With" section**

Find:
```
- `data/strategy-header.md` contents
- `data/watcher-memory-summary.md` contents
```

Replace with:
```
- `~/.claude/strategy-os/data/strategy-header.md` contents
- `~/.claude/strategy-os/data/watcher-memory-summary.md` contents
```

- [ ] **Step 4: Update Step 1 — Load the Full Strategy**

Find:
```
Read `data/strategy.md` in full. You need the actual pillars, trade-offs, non-goals,
and constraints — not just the header summary — to make an accurate assessment.

If `data/strategy.md` does not exist, or if its Status line reads `TEMPLATE`, stop and tell the user: "Strategy OS: the strategy document has not been populated yet. Run Phase 1 (Consolidate) to enable misalignment detection." Do not proceed to Step 2.
```

Replace with:
```
Read `~/.claude/strategy-os/data/strategy.md` in full. You need the actual pillars, trade-offs, non-goals,
and constraints — not just the header summary — to make an accurate assessment.

If `~/.claude/strategy-os/data/strategy.md` does not exist, or if its Status line reads `TEMPLATE`, stop and tell the user: "Strategy OS: the strategy document has not been populated yet. Run Phase 1 (Consolidate) to enable misalignment detection." Do not proceed to Step 2.
```

- [ ] **Step 5: Update Step 2 — strategy.md reference**

Find:
```
2. What specific element of `data/strategy.md` does it potentially conflict with?
```

Replace with:
```
2. What specific element of `~/.claude/strategy-os/data/strategy.md` does it potentially conflict with?
```

- [ ] **Step 6: Update Step 3 — watcher-memory-summary path**

Find:
```
Read `data/watcher-memory-summary.md`. If the CEO dismissed a flag on this same
```

Replace with:
```
Read `~/.claude/strategy-os/data/watcher-memory-summary.md`. If the CEO dismissed a flag on this same
```

- [ ] **Step 7: Update Step 5 — memory write paths and audit log**

Find:
```
Append to `data/watcher-memory.md`:
```

Replace with:
```
Append to `~/.claude/strategy-os/data/watcher-memory.md`:
```

Find:
```
Then regenerate `data/watcher-memory-summary.md`:
```

Replace with:
```
Then regenerate `~/.claude/strategy-os/data/watcher-memory-summary.md`:
```

Find:
```
After any write to `data/watcher-memory.md` or `data/watcher-memory-summary.md`,
append to `data/audit-log.jsonl`:

```json
{"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-analyst","action":"write","target_file":"data/watcher-memory.md","summary":"Logged analyst interaction: [CLUSTER] - [USER ACTION]","approved_by":"user-interaction","decision_id":null}
```
```

Replace with:
```
After any write to `~/.claude/strategy-os/data/watcher-memory.md` or `~/.claude/strategy-os/data/watcher-memory-summary.md`,
append to `~/.claude/strategy-os/data/audit-log.jsonl`:

```json
{"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-analyst","action":"write","target_file":"~/.claude/strategy-os/data/watcher-memory.md","summary":"Logged analyst interaction: [CLUSTER] - [USER ACTION]","approved_by":"user-interaction","decision_id":null}
```
```

Find:
```
{"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-analyst","action":"generate","target_file":"data/watcher-memory-summary.md","summary":"Regenerated analyst memory summary after interaction","approved_by":"user-interaction","decision_id":null}
```

Replace with:
```
{"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-analyst","action":"generate","target_file":"~/.claude/strategy-os/data/watcher-memory-summary.md","summary":"Regenerated analyst memory summary after interaction","approved_by":"user-interaction","decision_id":null}
```

### strategy-analyst/hook.md

- [ ] **Step 8: Update hook prerequisites**

Find:
```
If `data/strategy-header.md` does not exist or contains only the template placeholder,
skip all detection. There is no strategy to compare against.
```

Replace with:
```
If `~/.claude/strategy-os/data/strategy-header.md` does not exist or contains only the template placeholder,
skip all detection. There is no strategy to compare against.
```

- [ ] **Step 9: Update Stage 1 cool-down check**

Find:
```
1. **Check cool-down.** Read the last entry in `data/watcher-memory.md` for the
```

Replace with:
```
1. **Check cool-down.** Read the last entry in `~/.claude/strategy-os/data/watcher-memory.md` for the
```

- [ ] **Step 10: Update Stage 2 pass-through references**

Find:
```
- The full contents of `data/strategy-header.md`
- The full contents of `data/watcher-memory-summary.md`
```

Replace with:
```
- The full contents of `~/.claude/strategy-os/data/strategy-header.md`
- The full contents of `~/.claude/strategy-os/data/watcher-memory-summary.md`
```

- [ ] **Step 11: Update cool-down state section**

Find:
```
Cool-down is tracked by reading `data/watcher-memory.md` — specifically the most
```

Replace with:
```
Cool-down is tracked by reading `~/.claude/strategy-os/data/watcher-memory.md` — specifically the most
```

- [ ] **Step 12: Verify no bare `data/` references remain in either file**

Run:
```bash
grep -n "data/" strategy-analyst/SKILL.md strategy-analyst/hook.md
```

Expected: zero output. If any lines appear, fix them before proceeding.

- [ ] **Step 13: Commit**

```bash
git add strategy-analyst/SKILL.md strategy-analyst/hook.md
git commit -m "feat: update strategy-analyst files to use shared ~/.claude/strategy-os/data path"
```

---

## Task 5: Update `strategy-coach/SKILL.md`

**Files:**
- Modify: `strategy-coach/SKILL.md`

- [ ] **Step 1: Update skill description frontmatter (2 occurrences)**

Find:
```
  quarterly or monthly review, or when data/kpi-registry.md doesn't exist yet
  (first-run setup). Also activates when the coach's scheduled cadence has elapsed
  since the last check-in date in data/kpi-registry.md.
```

Replace with:
```
  quarterly or monthly review, or when ~/.claude/strategy-os/data/kpi-registry.md doesn't exist yet
  (first-run setup). Also activates when the coach's scheduled cadence has elapsed
  since the last check-in date in ~/.claude/strategy-os/data/kpi-registry.md.
```

- [ ] **Step 2: Add path expansion note**

Find:
```
Read `shared/principles.md` before doing anything.
```

Replace with:
```
Read `shared/principles.md` before doing anything.

When reading or writing files in this skill, expand `~` to the user's home directory
(e.g. `/Users/username` on macOS, `/home/username` on Linux).
```

- [ ] **Step 3: Update First Run section — kpi-registry and audit-log references**

Find:
```
CEO track execution against `data/strategy.md` over time: maintain a living record of
```

Replace with:
```
CEO track execution against `~/.claude/strategy-os/data/strategy.md` over time: maintain a living record of
```

Find:
```
Check if `data/kpi-registry.md` exists and has at least one KPI defined (look for
```

Replace with:
```
Check if `~/.claude/strategy-os/data/kpi-registry.md` exists and has at least one KPI defined (look for
```

Find:
```
[TIME HORIZON from data/strategy.md]?
```

Replace with:
```
[TIME HORIZON from ~/.claude/strategy-os/data/strategy.md]?
```

Find:
```
After the interview, show the user a draft of `data/kpi-registry.md` before writing.
Get confirmation, then write the file. Log the write to `data/audit-log.jsonl`.
```

Replace with:
```
After the interview, show the user a draft of `~/.claude/strategy-os/data/kpi-registry.md` before writing.
Get confirmation, then write the file. Log the write to `~/.claude/strategy-os/data/audit-log.jsonl`.
```

- [ ] **Step 4: Update Periodic Check-ins section**

Find:
```
**Claude Code (hook-scheduled):** The coach fires if `Last check-in` in
`data/kpi-registry.md` is older than the user's chosen cadence.

**Claude.ai / Desktop:** At session start, read `data/kpi-registry.md` and check
```

Replace with:
```
**Claude Code (hook-scheduled):** The coach fires if `Last check-in` in
`~/.claude/strategy-os/data/kpi-registry.md` is older than the user's chosen cadence.

**Claude.ai / Desktop:** At session start, read `~/.claude/strategy-os/data/kpi-registry.md` and check
```

- [ ] **Step 5: Update Which KPIs section — watcher-memory-summary reference**

Find:
```
| **Salience** | Medium | KPI's pillar has been flagged by the analyst recently (read `data/watcher-memory-summary.md`) |
```

Replace with:
```
| **Salience** | Medium | KPI's pillar has been flagged by the analyst recently (read `~/.claude/strategy-os/data/watcher-memory-summary.md`) |
```

- [ ] **Step 6: Update After each check-in section**

Find:
```
1. **Update the KPI history** in `data/kpi-registry.md`: append a new row to each
```

Replace with:
```
1. **Update the KPI history** in `~/.claude/strategy-os/data/kpi-registry.md`: append a new row to each
```

Find:
```
5. **Log to `data/audit-log.jsonl`:**

```json
{"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-coach","action":"write","target_file":"data/kpi-registry.md","summary":"Check-in: updated [KPI1] to [VALUE1], [KPI2] to [VALUE2]","approved_by":"user-interaction","decision_id":null}
```
```

Replace with:
```
5. **Log to `~/.claude/strategy-os/data/audit-log.jsonl`:**

```json
{"timestamp":"YYYY-MM-DDTHH:MM:SSZ","component":"strategy-coach","action":"write","target_file":"~/.claude/strategy-os/data/kpi-registry.md","summary":"Check-in: updated [KPI1] to [VALUE1], [KPI2] to [VALUE2]","approved_by":"user-interaction","decision_id":null}
```
```

- [ ] **Step 7: Update Answering Open Questions section**

Find:
```
use the trend narratives in `data/kpi-registry.md` to give a
```

Replace with:
```
use the trend narratives in `~/.claude/strategy-os/data/kpi-registry.md` to give a
```

- [ ] **Step 8: Update KPI Registry File Format section**

Find:
```
Write `data/kpi-registry.md` using this structure:
```

Replace with:
```
Write `~/.claude/strategy-os/data/kpi-registry.md` using this structure:
```

- [ ] **Step 9: Update Environment-Specific Scheduling section**

Find:
```
> set a hook on session start that reads `data/kpi-registry.md` and invokes the
```

Replace with:
```
> set a hook on session start that reads `~/.claude/strategy-os/data/kpi-registry.md` and invokes the
```

- [ ] **Step 10: Verify no bare `data/` references remain**

Run:
```bash
grep -n "data/" strategy-coach/SKILL.md
```

Expected: zero output. If any lines appear, fix them before proceeding.

- [ ] **Step 11: Commit**

```bash
git add strategy-coach/SKILL.md
git commit -m "feat: update strategy-coach/SKILL.md to use shared ~/.claude/strategy-os/data path"
```

---

## Task 6: Cross-file verification

**Files:**
- Read: all five skill files

- [ ] **Step 1: Verify zero bare `data/` references remain in all skill files**

Run:
```bash
grep -rn "data/" SKILL.md lifecycle/SKILL.md strategy-analyst/SKILL.md strategy-analyst/hook.md strategy-coach/SKILL.md
```

Expected: **zero output**. If any lines appear, fix the missed reference in the relevant task before continuing.

- [ ] **Step 2: Spot-check the new paths look correct**

Run:
```bash
grep -c "strategy-os/data/" SKILL.md lifecycle/SKILL.md strategy-analyst/SKILL.md strategy-analyst/hook.md strategy-coach/SKILL.md
```

Expected: each file shows a non-zero count, confirming the replacement landed.

---

## Task 7: Reset `data/` to template state

**Files:**
- Overwrite: `data/strategy.md`, `data/strategy-header.md`, `data/kpi-registry.md`, `data/watcher-memory.md`, `data/watcher-memory-summary.md`, `data/audit-log.jsonl`

These files ship with the plugin as starter templates. Strip all real data. Write the following content to each file.

- [ ] **Step 1: Reset `data/strategy.md`**

Write this content to `data/strategy.md`:

```markdown
---
Status: TEMPLATE
Last updated: [YYYY-MM-DD]
Approved by: [CEO NAME]
Version: 0.1-draft
---

# Strategy Consolidation Memo

<!-- This file is a template. Run Phase 1 (Consolidate) via lifecycle/SKILL.md to populate it. -->

## Strategic Objective

[PLACEHOLDER: One clear sentence stating what you're trying to achieve and by when.]

**Time horizon:** [PLACEHOLDER: e.g., 18 months, FY2026]

## Where We Play

[PLACEHOLDER: Markets, segments, and customer types you're focused on.]

## How We Win

[PLACEHOLDER: The 2-3 specific advantages or approaches that give you an edge in those markets.]

## Strategic Pillars

### Pillar 1: [PLACEHOLDER: Name]

[PLACEHOLDER: 2-3 sentence description of this pillar and what it means for execution.]

### Pillar 2: [PLACEHOLDER: Name]

[PLACEHOLDER: 2-3 sentence description.]

### Pillar 3: [PLACEHOLDER: Name]

[PLACEHOLDER: 2-3 sentence description.]

## Key Trade-offs

| We choose to... | ...instead of... | Because... |
|-----------------|------------------|------------|
| [PLACEHOLDER] | [PLACEHOLDER] | [PLACEHOLDER] |

## Non-Goals

- [PLACEHOLDER: What you are explicitly not doing in this period]

## Key Risks and Assumptions

| Risk / Assumption | Type | Probability | Impact | Mitigation |
|-------------------|------|-------------|--------|------------|
| [PLACEHOLDER] | Risk/Assumption | H/M/L | H/M/L | [PLACEHOLDER] |

## Resource Constraints

[PLACEHOLDER: Headcount, budget, runway, or other binding constraints.]

## Open Questions

- [PLACEHOLDER: Unresolved decisions that need to be made]

## Decision Log

| Date | Decision | Made by | Rationale |
|------|----------|---------|-----------|
| [YYYY-MM-DD] | [PLACEHOLDER] | [OWNER] | [PLACEHOLDER] |
```

- [ ] **Step 2: Reset `data/strategy-header.md`**

Write this content to `data/strategy-header.md`:

```markdown
---
Status: TEMPLATE
Generated: [YYYY-MM-DD]
---

<!--
  Auto-generated 1-2 sentence strategy summary for ambient loading (~150 tokens).
  Regenerated by lifecycle/SKILL.md after any approved write to strategy.md.
  Do not edit manually.
-->

[Generated after Phase 1 (Consolidate) is complete.]
```

- [ ] **Step 3: Reset `data/kpi-registry.md`**

Write this content to `data/kpi-registry.md`:

```markdown
# KPI Registry

<!-- Populated by strategy-coach/SKILL.md during the setup interview. -->

Last updated: [YYYY-MM-DD]
Last check-in: [YYYY-MM-DD]
Check-in cadence: [weekly / monthly / mix]
Check-in style: [focused / comprehensive / flag-bad]

## [KPI Name]

**Pillar:** [P1 / P2 / P3 / cross-pillar]
**Target:** [value] by [date]
**Current:** [value] as of [date]
**Trend:** [up / down / flat] since [date]
**Last asked:** [date]

### History

| Date | Value | Note |
|------|-------|------|
| [YYYY-MM-DD] | [value] | [context if relevant] |

### Trend narrative

[Written by coach after 3+ consecutive data points in the same direction.]
```

- [ ] **Step 4: Reset `data/watcher-memory.md`**

Write this content to `data/watcher-memory.md`:

```markdown
<!--
  Strategy Analyst interaction log.
  Format: [YYYY-MM-DD HH:MM] | analyst | surfaced | [cluster] | [user action] | [outcome/reason]
  Written by strategy-analyst/SKILL.md after user responds to a flag.
  Newest entries at bottom.
-->
```

- [ ] **Step 5: Reset `data/watcher-memory-summary.md`**

Write this content to `data/watcher-memory-summary.md`:

```
[Generated after first analyst interaction]
```

- [ ] **Step 6: Reset `data/audit-log.jsonl`**

Write an empty file to `data/audit-log.jsonl` (zero bytes — valid empty JSONL).

- [ ] **Step 7: Commit**

```bash
git add data/strategy.md data/strategy-header.md data/kpi-registry.md data/watcher-memory.md data/watcher-memory-summary.md data/audit-log.jsonl
git commit -m "chore: reset data/ files to template state — live data moved to ~/.claude/strategy-os/data"
```

---

## Task 8: Update `CLAUDE.md`

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Update the Data Layer table**

Find:
```
## Data Layer (`data/`)
```

Replace with:
```
## Data Layer

**Live data location:** `~/.claude/strategy-os/data/` — this is where all runtime data is
read and written by the skills. Shared across Claude Code and Claude Desktop.

**Template files:** `data/` (in this repo) — shipped with the plugin as starter files.
On first run, the skill copies these to `~/.claude/strategy-os/data/` if that directory
does not yet exist.
```

- [ ] **Step 2: Update the data file table paths**

Find the table:
```
| File | Owner | Purpose |
|------|-------|---------|
| `strategy.md` | Lifecycle (Phase 1) | Canonical strategy doc — source of truth |
| `strategy-header.md` | Auto-generated | 1-2 sentence summary for ambient loading (~150 tokens) |
| `kpi-registry.md` | Coach | KPI definitions, targets, check-in history |
| `watcher-memory.md` | Analyst | Full log of flags and user responses |
| `watcher-memory-summary.md` | Auto-generated | Recent patterns for cool-down and salience scoring |
| `audit-log.jsonl` | All components | Write-action log — one JSON object per line |
```

Replace with:
```
| File | Owner | Purpose |
|------|-------|---------|
| `~/.claude/strategy-os/data/strategy.md` | Lifecycle (Phase 1) | Canonical strategy doc — source of truth |
| `~/.claude/strategy-os/data/strategy-header.md` | Auto-generated | 1-2 sentence summary for ambient loading (~150 tokens) |
| `~/.claude/strategy-os/data/kpi-registry.md` | Coach | KPI definitions, targets, check-in history |
| `~/.claude/strategy-os/data/watcher-memory.md` | Analyst | Full log of flags and user responses |
| `~/.claude/strategy-os/data/watcher-memory-summary.md` | Auto-generated | Recent patterns for cool-down and salience scoring |
| `~/.claude/strategy-os/data/audit-log.jsonl` | All components | Write-action log — one JSON object per line |
```

- [ ] **Step 3: Update the lifecycle skill save note**

Find:
```
The lifecycle skill is the only component that writes to `strategy.md` (with CEO
approval). After any write to `strategy.md`, it also regenerates `strategy-header.md`.
```

Replace with:
```
The lifecycle skill is the only component that writes to `~/.claude/strategy-os/data/strategy.md` (with CEO
approval). After any write to `strategy.md`, it also regenerates `~/.claude/strategy-os/data/strategy-header.md`.
```

- [ ] **Step 4: Update the Detection Paths section**

Find:
```
- SessionStart: root SKILL.md loads `data/strategy-header.md` + `data/watcher-memory-summary.md`
- UserPromptSubmit: `strategy-analyst/hook.md` runs Stage 1 keyword detection
```

Replace with:
```
- SessionStart: root SKILL.md runs First-Run Check, then loads `~/.claude/strategy-os/data/strategy-header.md` + `~/.claude/strategy-os/data/watcher-memory-summary.md`
- UserPromptSubmit: `strategy-analyst/hook.md` runs Stage 1 keyword detection
```

- [ ] **Step 5: Add developer migration note**

Find the `## Key Invariants` section header and add a new section just before it:

Find:
```
## Key Invariants
```

Replace with:
```
## Developer Migration

If you have existing live data in the project's `data/` folder from before this
architecture change, move it once to the shared location:

```bash
mkdir -p ~/.claude/strategy-os/data
mv /path/to/strategy-os-v2/data/*.md ~/.claude/strategy-os/data/
mv /path/to/strategy-os-v2/data/*.jsonl ~/.claude/strategy-os/data/
```

The project `data/` files are now templates only — do not put real data there.

## Key Invariants
```

- [ ] **Step 6: Commit**

```bash
git add CLAUDE.md
git commit -m "docs: update CLAUDE.md to reflect shared data store at ~/.claude/strategy-os/data"
```

---

## Task 9: Final verification

- [ ] **Step 1: Full grep across all skill files and CLAUDE.md**

Run:
```bash
grep -rn "\bdata/" SKILL.md lifecycle/SKILL.md strategy-analyst/SKILL.md strategy-analyst/hook.md strategy-coach/SKILL.md CLAUDE.md
```

Expected: zero output for skill files. CLAUDE.md should only show the migration note referring to `data/*.md` and `data/*.jsonl` in the bash snippet — those are intentional references to the project-relative template folder, not the live data path.

- [ ] **Step 2: Confirm template files are in place**

Run:
```bash
grep "Status: TEMPLATE" data/strategy.md data/strategy-header.md
```

Expected: both files return a match.

Run:
```bash
grep "Generated after first analyst interaction" data/watcher-memory-summary.md
```

Expected: match found.

- [ ] **Step 3: Confirm audit-log.jsonl is empty**

Run:
```bash
wc -c data/audit-log.jsonl
```

Expected: `0 data/audit-log.jsonl`

- [ ] **Step 4: Final commit and push**

```bash
git status
```

Expected: working tree clean (all changes committed across Tasks 2–8).

If clean, push:
```bash
git push -u origin feat/shared-data-store
```

- [ ] **Step 5: Open PR**

```bash
gh pr create --title "feat: shared data store at ~/.claude/strategy-os/data" --body "$(cat <<'EOF'
## Summary

- Moves all `data/` path references in skill files to `~/.claude/strategy-os/data/` — a stable, fixed location shared by Claude Code and Claude Desktop
- Adds a First-Run Check section to `SKILL.md` that bootstraps the data directory automatically on first use
- Resets `data/` in the repo to template state (shipped starters, not live data)
- Updates `CLAUDE.md` to document the new architecture and include a developer migration note

## Test plan

- [ ] Grep confirms zero bare `data/` references in all five skill files
- [ ] `data/strategy.md` and `data/strategy-header.md` contain `Status: TEMPLATE`
- [ ] `data/watcher-memory-summary.md` contains only the placeholder line
- [ ] `data/audit-log.jsonl` is empty
- [ ] `CLAUDE.md` data table shows full `~/.claude/strategy-os/data/` paths
EOF
)"
```
