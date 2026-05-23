#!/usr/bin/env bash
#
# detect-keywords.sh — Strategy OS UserPromptSubmit hook
#
# Receives the Claude Code hook payload as JSON on stdin.
# Scans the user's prompt for strategy-relevant keyword clusters.
# Outputs an injection message if a match is found; exits silently otherwise.
# Never blocks — exits 0 on any error or missing file.

STRATEGY_HEADER="$HOME/.claude/strategy-os/data/strategy-header.md"
WATCHER_MEMORY="$HOME/.claude/strategy-os/data/watcher-memory.md"

# Guard: strategy header must exist and not be TEMPLATE
[ -f "$STRATEGY_HEADER" ] || exit 0
grep -q "Status: TEMPLATE" "$STRATEGY_HEADER" 2>/dev/null && exit 0

# Read user prompt from hook JSON on stdin
HOOK_JSON=$(cat)
PROMPT=$(echo "$HOOK_JSON" | jq -r '.prompt // ""' 2>/dev/null) || exit 0
[ -n "$PROMPT" ] || exit 0
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')

# Keyword cluster detection (first match wins)
MATCHED_CLUSTER=""
if echo "$PROMPT_LOWER" | grep -qE "roadmap|ship date|launch|deadline|commit|promise|sprint|release"; then
  MATCHED_CLUSTER="commitments"
elif echo "$PROMPT_LOWER" | grep -qE "hire|headcount|budget|allocate|spend|invest|team size|burn"; then
  MATCHED_CLUSTER="resources"
elif echo "$PROMPT_LOWER" | grep -qE "market|segment|customer|icp|compete|price|enterprise|smb|mid-market"; then
  MATCHED_CLUSTER="positioning"
elif echo "$PROMPT_LOWER" | grep -qE "build|bet|product direction|platform|feature|deprecate|sunset|pivot to"; then
  MATCHED_CLUSTER="bets"
elif echo "$PROMPT_LOWER" | grep -qE "change direction|pivot|de-prioritize|kill|cut|abandon|pause|stop doing"; then
  MATCHED_CLUSTER="pivots"
elif echo "$PROMPT_LOWER" | grep -qE "deal|contract|renewal|expansion|churn|land and expand"; then
  MATCHED_CLUSTER="contracts"
fi
[ -n "$MATCHED_CLUSTER" ] || exit 0

# Cool-down: skip if this cluster was flagged within the last 30 minutes
if [ -f "$WATCHER_MEMORY" ]; then
  LAST_LINE=$(grep -i "| analyst |" "$WATCHER_MEMORY" 2>/dev/null | grep -i "| $MATCHED_CLUSTER |" | tail -1)
  if [ -n "$LAST_LINE" ]; then
    TIMESTAMP=$(echo "$LAST_LINE" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}' | head -1)
    if [ -n "$TIMESTAMP" ]; then
      IN_COOLDOWN=$(python3 -c "
import datetime
try:
    ts = datetime.datetime.strptime('$TIMESTAMP', '%Y-%m-%d %H:%M')
    diff = (datetime.datetime.now() - ts).total_seconds()
    print('yes' if diff < 1800 else 'no')
except Exception:
    print('no')
" 2>/dev/null || echo "no")
      [ "$IN_COOLDOWN" = "yes" ] && exit 0
    fi
  fi
fi

# Output injection message to trigger analyst
echo "[Strategy OS] Potential strategic signal detected (cluster: $MATCHED_CLUSTER). Please invoke @strategy-analyst to check for misalignment before responding."

exit 0
