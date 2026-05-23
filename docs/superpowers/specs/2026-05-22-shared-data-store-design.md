# Shared Data Store — Design Spec

**Date:** 2026-05-22
**Status:** Approved
**Branch:** feat/shared-data-store

---

## Problem

All Strategy OS skill files reference data files (e.g. `data/strategy.md`) as
relative paths. In Claude Code, these paths resolve relative to the currently-open
project — so the data lands in whichever project folder is open. In Claude Desktop,
there is no consistent "current directory," so the data either lands somewhere
unpredictable or doesn't work at all.

Result: a user who works in both environments ends up with two (or more) divergent
data stores — different strategy docs, different KPI histories, different watcher
memories.

---

## Goal

A single, stable data directory that both Claude Code and Claude Desktop read from
and write to, regardless of which project is open. Data persists across plugin
version upgrades.

---

## Canonical Data Location

```
~/.claude/strategy-os/data/
```

This path:
- Lives in the user's home directory, outside any project folder
- Survives plugin upgrades (not inside the versioned plugin cache)
- Is identical in both Claude Code and Claude Desktop environments
- Is readable and writable by Claude via the Read/Write/Bash tools

---

## Path Reference Changes

### Approach

Replace every `data/X.md` reference in skill files with
`~/.claude/strategy-os/data/X.md`. Add one sentence to each skill file near the
top, after the `shared/principles.md` instruction, to make expansion explicit:

> "When reading or writing files, expand `~` to the user's home directory (e.g.
> `/Users/username` on macOS, `/home/username` on Linux)."

### Files to Update

Five skill files contain `data/` path references:

| File | References |
|------|-----------|
| `SKILL.md` | Reads: `data/strategy-header.md`, `data/watcher-memory-summary.md`. Output section: "save to `data/`" |
| `lifecycle/SKILL.md` | Reads: `data/strategy.md`. Writes: `data/strategy.md`, `data/strategy-header.md`, `data/audit-log.jsonl`. Output section: "save to `data/`" |
| `strategy-analyst/SKILL.md` | Reads: `data/strategy.md`, `data/watcher-memory-summary.md`, `data/watcher-memory.md`. Writes: `data/watcher-memory.md`, `data/watcher-memory-summary.md`, `data/audit-log.jsonl` |
| `strategy-analyst/hook.md` | Reads: `data/strategy-header.md`, `data/watcher-memory.md`, `data/watcher-memory-summary.md` |
| `strategy-coach/SKILL.md` | Reads: `data/kpi-registry.md`, `data/strategy.md`, `data/watcher-memory-summary.md`. Writes: `data/kpi-registry.md`, `data/audit-log.jsonl` |

All `data/` prefixes in the above files become `~/.claude/strategy-os/data/`.

---

## Template Files (the `data/` folder stays in the repo)

The project's `data/` folder is repurposed from live data to **shipped templates**.
These files document the expected structure of each data file and seed first-run
bootstrapping. All files are reset to their empty/placeholder state before commit.

| File | Template state |
|------|---------------|
| `data/strategy.md` | Full memo structure with `Status: TEMPLATE` and `[PLACEHOLDER]` fields throughout |
| `data/strategy-header.md` | `Status: TEMPLATE` and format comment explaining the 1-2 sentence structure |
| `data/kpi-registry.md` | Registry header + one placeholder KPI section |
| `data/watcher-memory.md` | Empty file with a format comment header |
| `data/watcher-memory-summary.md` | `[Generated after first analyst interaction]` placeholder only |
| `data/audit-log.jsonl` | Empty file (valid empty JSONL) |

---

## First-Run Bootstrap

A new **"First-Run Check"** section is added to `SKILL.md`, executed silently at
session start before any mode routing:

```
First-Run Check (silent):
1. Check if ~/.claude/strategy-os/data/ exists.
2. If not:
   a. Create the directory.
   b. For each file in the plugin's own data/ directory, copy it to
      ~/.claude/strategy-os/data/ if that destination file does not already exist.
3. Proceed with ambient context loading and mode routing as normal.
```

**Why copy only if destination doesn't exist:** Protects against accidentally
overwriting live data if the user re-runs bootstrap or upgrades the plugin.

**Template source path:** The skill instructs Claude to look for template files at
`~/.claude/plugins/cache/josephfung/strategy-os/` (the installed plugin root) and
copy any files found in its `data/` subdirectory. If that path is not resolvable
(e.g. installed via a different mechanism), the bootstrap step is skipped and the
skill proceeds with empty data — the normal first-run flows (Phase 1 setup, coach
setup interview) will create the files organically.

**Failure mode:** If the directory cannot be created (permissions issue), the skill
emits a one-time warning:
> "Strategy OS: could not create ~/.claude/strategy-os/data/. Check directory
> permissions. Data files will not be saved this session."
Then continues normally (read-only degraded mode).

---

## CLAUDE.md Update

The project's `CLAUDE.md` is updated to note:

- `data/` in the repo contains shipped templates, not live data
- Live data lives at `~/.claude/strategy-os/data/`
- The data table in the Data Layer section is updated to show the new paths

---

## Developer Migration (One-Time)

For the developer (current user), existing live data files in the project's `data/`
folder need to be manually moved to `~/.claude/strategy-os/data/`:

```bash
mkdir -p ~/.claude/strategy-os/data
mv /path/to/strategy-os-v2/data/*.md ~/.claude/strategy-os/data/
mv /path/to/strategy-os-v2/data/*.jsonl ~/.claude/strategy-os/data/
```

This is a one-time manual step, not automated. The project's `data/` files are then
reset to template state (see above) and committed.

---

## What Does Not Change

- All skill logic, phase workflows, output formats, and audit log entries are unchanged
- The `data/` filenames themselves are unchanged — only the directory prefix changes
- The `shared/principles.md` path is unchanged (it lives in the repo, not in the data store)
- The `lifecycle/references/` paths are unchanged
- No new dependencies, build steps, or tooling

---

## Out of Scope

- User-configurable data path (config file approach) — unnecessary for a personal tool
- Automatic syncing or backup of the data directory
- Multi-user or multi-machine support
