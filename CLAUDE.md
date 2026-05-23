# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this project is

Strategy OS is a Claude skill — a prompt-driven workflow system for startup/scaleup
CEOs. No compiled code, no build system, no test suite. All content is markdown.

## Distribution

End users install via:
```bash
npx skills add josephfung/strategy-os
claude plugin install --from github:josephfung/strategy-os
```

The `.claude-plugin/plugin.json` registers the plugin with Claude's plugin system
(metadata only — no logic lives there).

## Architecture

Strategy OS v2 has three operating modes, unified by a shared data layer.

```
SKILL.md                    ← /strategy dispatcher — $ARGUMENTS routing to lifecycle phases and coach
shared/principles.md        ← 6 non-negotiables. All components read this first.
data/                       ← Starter templates (copied to ~/.claude/strategy-os/data/ on first run)
lifecycle/workflow.md       ← Mode 1: episodic 5-phase strategy work (reference doc, not a skill)
lifecycle/references/       ← Templates, prompts, and checklists for phases 1-5
agents/strategy-analyst.md  ← Mode 2: isolated subagent for ambient misalignment detection
agents/strategy-coach.md    ← Mode 3: isolated subagent for KPI tracking and check-in cadence
hooks/hooks.json            ← Wires UserPromptSubmit (analyst) and SessionStart (coach) events
scripts/detect-keywords.sh  ← Shell script: keyword scan, triggers analyst on match
scripts/check-coach-cadence.sh ← Shell script: cadence check, triggers coach if overdue
```

## Data Layer

**Live data location:** `~/.claude/strategy-os/data/` — this is where all runtime data is
read and written by the skills. Shared across Claude Code and Claude Desktop.

**Template files:** `data/` (in this repo) — shipped with the plugin as starter files.
On first run, the skill copies these to `~/.claude/strategy-os/data/` if that directory
does not yet exist.

| File | Owner | Purpose |
|------|-------|---------|
| `~/.claude/strategy-os/data/strategy.md` | Lifecycle (Phase 1) | Canonical strategy doc — source of truth |
| `~/.claude/strategy-os/data/strategy-header.md` | Auto-generated | 1-2 sentence summary for ambient loading (~150 tokens) |
| `~/.claude/strategy-os/data/kpi-registry.md` | Coach | KPI definitions, targets, check-in history |
| `~/.claude/strategy-os/data/watcher-memory.md` | Analyst | Full log of flags and user responses |
| `~/.claude/strategy-os/data/watcher-memory-summary.md` | Auto-generated | Recent patterns for cool-down and salience scoring |
| `~/.claude/strategy-os/data/audit-log.jsonl` | All components | Write-action log — one JSON object per line |

The lifecycle skill is the only component that writes to `~/.claude/strategy-os/data/strategy.md` (with CEO
approval). After any write to `~/.claude/strategy-os/data/strategy.md`, it also regenerates `~/.claude/strategy-os/data/strategy-header.md`.


## Key Invariants

These must be preserved when editing any skill file:

- **No silent writes.** No component writes to any file without a user-visible interaction
  that triggered it.
- **Audit log on every write.** Every write action by any component appends to
  `~/.claude/strategy-os/data/audit-log.jsonl`.
- **Analyst is advisory only.** Flags are prefixed notes, not blockers. Never directive.
- **Principles are canonical.** The 6 principles in `shared/principles.md` must not be
  contradicted by any component's workflow instructions.
- **lifecycle/references/ paths.** `lifecycle/workflow.md` references files as
  `lifecycle/references/X.md` — not as `references/X.md`. Don't break these.

## Detection Paths (Two Environments)

**Claude Code (hooks-based, mechanical):**
- SessionStart: root SKILL.md runs First-Run Check + ambient load; `scripts/check-coach-cadence.sh` checks if coach check-in is overdue and injects a trigger if so
- UserPromptSubmit: `scripts/detect-keywords.sh` scans every message against six keyword clusters; injects a trigger if a match is found and the cluster is not in cool-down
- Explicit: `/strategy [subcommand]` invokes root SKILL.md directly via $ARGUMENTS routing

**Claude.ai / Desktop (description-based):**
- Strategy-adjacent language triggers root SKILL.md via its `description` field
- `strategy-analyst` and `strategy-coach` agents activate via their own `description` fields
- No true hooks — detection happens within Claude's skill-triggering loop
- `/strategy check-in` still works as explicit invocation

## MCP Integration

Phases 4 and 5 support optional connections to Jira/Monday/ClickUp (ticket tagging)
and Slack (drift summaries). Default is always draft-only mode — agents propose,
humans approve. The 4-level permission model in `lifecycle/references/governance.md`
defines what can be automated at each level.
