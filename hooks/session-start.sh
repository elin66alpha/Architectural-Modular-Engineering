#!/bin/sh
# SessionStart hook: reports whether ENGINEERING.md exists.
# Claude Code adds this script's stdout to the session context.

if [ -f "${CLAUDE_PROJECT_DIR:-$PWD}/ENGINEERING.md" ]; then
  echo "Engineering discipline: ENGINEERING.md maps this project's categories, modules, and features. Read it before any change and update it in the same change."
else
  echo "Engineering discipline: this project has no ENGINEERING.md. The engineering-discipline skill governs feature work here."
fi
