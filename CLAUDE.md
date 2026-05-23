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
SKILL.md                    ← Slim router. Entry point — routes between the 3 modes.
shared/principles.md        ← 6 non-negotiables. All components read this first.
data/                       ← Shared state. All components read/write here.
lifecycle/SKILL.md          ← Mode 1: episodic 5-phase strategy work
lifecycle/references/       ← Templates, prompts, and checklists for phases 1-5
strategy-analyst/SKILL.md   ← Mode 2: ambient misalignment detection
strategy-analyst/hook.md    ← Claude Code UserPromptSubmit hook (Stage 1 detection)
strategy-coach/SKILL.md     ← Mode 3: KPI tracking and check-in cadence
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
approval). After any write to `strategy.md`, it also regenerates `~/.claude/strategy-os/data/strategy-header.md`.

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

These must be preserved when editing any skill file:

- **No silent writes.** No component writes to any file without a user-visible interaction
  that triggered it.
- **Audit log on every write.** Every write action by any component appends to
  `data/audit-log.jsonl`.
- **Analyst is advisory only.** Flags are prefixed notes, not blockers. Never directive.
- **Principles are canonical.** The 6 principles in `shared/principles.md` must not be
  contradicted by any component's workflow instructions.
- **lifecycle/references/ paths.** `lifecycle/SKILL.md` references files as
  `lifecycle/references/X.md` — not as `references/X.md`. Don't break these.

## Detection Paths (Two Environments)

**Claude Code (hooks-based):**
- SessionStart: root SKILL.md runs First-Run Check, then loads `~/.claude/strategy-os/data/strategy-header.md` + `~/.claude/strategy-os/data/watcher-memory-summary.md`
- UserPromptSubmit: `strategy-analyst/hook.md` runs Stage 1 keyword detection
- Scheduled: coach fires when check-in cadence elapsed

**Claude.ai / Desktop (skill-description-based):**
- Strategy-adjacent language triggers the root SKILL.md skill description
- Analyst and coach activate via their own skill descriptions
- No true hooks — detection happens within Claude's skill-triggering loop

## MCP Integration

Phases 4 and 5 support optional connections to Jira/Monday/ClickUp (ticket tagging)
and Slack (drift summaries). Default is always draft-only mode — agents propose,
humans approve. The 4-level permission model in `lifecycle/references/governance.md`
defines what can be automated at each level.
