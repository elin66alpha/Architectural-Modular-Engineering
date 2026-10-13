#!/bin/sh
# SessionStart hook: reports the state of ENGINEERING.md as plain facts.
# Claude Code adds this script's stdout to the session context.

dir="${CLAUDE_PROJECT_DIR:-$PWD}"
f="$dir/ENGINEERING.md"

if [ ! -f "$f" ]; then
  echo "Engineering discipline: this project has no ENGINEERING.md. The engineering-discipline skill governs feature work here."
  exit 0
fi

last=$(sed -n 's/^Last review: *//p' "$f" | head -n 1)
count=$(sed -n 's/^Features since last review: *\([0-9][0-9]*\).*/\1/p' "$f" | head -n 1)
open=$(awk '/^## /{s=($0=="## Deviations")} s && /^- \[open\]/{n++} END{print n+0}' "$f")

echo "Engineering discipline: ENGINEERING.md is the contract for this project; read it before any change. Last review: ${last:-none}. Features since last review: ${count:-0}. Open deviations: ${open}."

if [ "${count:-0}" -ge 3 ]; then
  echo "A review is due: 3 or more features were registered since the last review."
fi
