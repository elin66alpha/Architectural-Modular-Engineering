#!/bin/sh
# SessionStart hook: reports whether ENGINEERING.md exists.
# Claude Code adds this script's stdout to the session context.

if [ -f "${CLAUDE_PROJECT_DIR:-$PWD}/ENGINEERING.md" ]; then
  echo "Architectural and Modular Engineering: ENGINEERING.md maps this project's categories, modules, and features. Read it before any change and update it in the same change."
else
  echo "Architectural and Modular Engineering: this project has no ENGINEERING.md. The architectural-modular-engineering skill governs feature work here."
fi
