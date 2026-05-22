<!--
  Strategy OS — Copyright (c) 2026 Joseph Fung (https://josephfung.ca)
  Licensed under the MIT License. See LICENSE file in the project root.
-->

# Strategy Analyst: Claude Code Hook

**Hook type:** UserPromptSubmit
**Runs:** Before processing every user message in a Claude Code session.
**Cost target:** Negligible per message. Full analyst skill loads only when a signal
fires — not on every turn.

---

## Prerequisites

If `data/strategy-header.md` does not exist or contains only the template placeholder,
skip all detection. There is no strategy to compare against.

---

## Stage 1: Lightweight Detection

1. **Check cool-down.** Read the last entry in `data/watcher-memory.md`. If the
   analyst fired in the last 3 messages on the same topic cluster as the current
   message, skip. Return without triggering.

2. **Scan the user's message** against these keyword clusters:

   | Cluster | Keywords / phrases |
   |---------|-------------------|
   | commitments | roadmap, ship date, launch, deadline, commit, promise, sprint, release |
   | resources | hire, headcount, budget, allocate, spend, invest, team size, burn |
   | positioning | market, segment, customer, ICP, compete, price, enterprise, SMB, enterprise |
   | bets | build, bet, product direction, platform, feature, deprecate, sunset, pivot to |
   | pivots | change direction, pivot, de-prioritize, kill, cut, abandon, pause, stop doing |
   | contracts | customer, deal, contract, renewal, expansion, churn, land and expand |

3. **If no cluster matches:** Return. Do nothing.

4. **If a cluster matches:** Record which cluster matched. Proceed to Stage 2.

---

## Stage 2: Invoke the Analyst

Load `strategy-analyst/SKILL.md`.

Pass to the skill:
- The user's full message text
- The cluster that matched
- The full contents of `data/strategy-header.md`
- The full contents of `data/watcher-memory-summary.md`

The analyst SKILL.md makes all decisions about whether to surface a flag, what
confidence level to use, and whether to write to memory.

---

## Cool-down State

Cool-down is tracked by reading the last entry in `data/watcher-memory.md`. The entry
format is pipe-delimited and includes the topic cluster and a message-sequence counter
(the analyst writes `msg-N` where N is an approximation of conversation turn). If the
same cluster fired within 3 turns, suppress.

The analyst SKILL.md is responsible for writing the cool-down state. This hook only
reads it.

---

## Claude.ai / Desktop Fallback

This hook is Claude Code-only. In Claude.ai or Desktop environments:
- The root `SKILL.md` ambient context section handles session-start loading
- The `strategy-analyst/SKILL.md` skill description triggers the analyst when
  strategy-adjacent language appears in the conversation
- Detection is less precise than the hook (no per-message cool-down), but covers
  the same signal clusters
