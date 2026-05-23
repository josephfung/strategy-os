#!/usr/bin/env bash
#
# check-coach-cadence.sh — Strategy OS SessionStart hook
#
# Fires once at session start. Checks whether a KPI check-in is overdue
# based on the cadence configured in kpi-registry.md.
# Outputs an injection message if overdue; exits silently otherwise.
# Never blocks — exits 0 on any error or missing file.

KPI_REGISTRY="$HOME/.claude/strategy-os/data/kpi-registry.md"

# Guard: registry must exist and not be TEMPLATE
[ -f "$KPI_REGISTRY" ] || exit 0
grep -q "Status: TEMPLATE" "$KPI_REGISTRY" 2>/dev/null && exit 0

# Parse Last check-in date
LAST_CHECKIN=$(grep -E "^Last check-in:" "$KPI_REGISTRY" 2>/dev/null | head -1 | sed 's/Last check-in:[[:space:]]*//' | tr -d '[:space:]')
[ -z "$LAST_CHECKIN" ] && exit 0

# Skip placeholder values like [YYYY-MM-DD]
echo "$LAST_CHECKIN" | grep -q '\[' && exit 0

# Parse Check-in cadence
CADENCE=$(grep -E "^Check-in cadence:" "$KPI_REGISTRY" 2>/dev/null | head -1 | sed 's/Check-in cadence:[[:space:]]*//' | tr -d '[:space:]')

# Determine threshold in days
# mix uses 7 days (most conservative); the coach handles per-KPI granularity once invoked
THRESHOLD_DAYS=7
if echo "$CADENCE" | grep -qi "monthly"; then
  THRESHOLD_DAYS=30
fi

# Check if overdue
RESULT=$(python3 -c "
import datetime, sys
try:
    last = datetime.datetime.strptime('$LAST_CHECKIN', '%Y-%m-%d')
    days = (datetime.datetime.now() - last).days
    print(str(days) if days >= $THRESHOLD_DAYS else 'not_due')
except Exception:
    print('error')
" 2>/dev/null || echo "error")

[ "$RESULT" = "not_due" ] && exit 0
[ "$RESULT" = "error" ] && exit 0

DAYS_AGO="$RESULT"

# Output injection message to trigger coach
echo "[Strategy OS] KPI check-in is overdue (last check-in was ${DAYS_AGO} days ago). Please invoke @strategy-coach for a check-in before proceeding with the session."

exit 0
