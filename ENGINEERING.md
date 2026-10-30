# ENGINEERING.md

Map of this repository: categories, the modules in each, the features in
each module. Read it before any change; update it in the same change. It
describes what exists now: no history, no plans.

## Architecture

### Plugin manifest (`.claude-plugin/`)

- **plugin** (`.claude-plugin/plugin.json`): plugin name, version, description
- **marketplace** (`.claude-plugin/marketplace.json`): lets this repository be installed as a one-plugin marketplace

### Skills (`skills/`)

- **architectural-modular-engineering** (`skills/architectural-modular-engineering/`): places each feature or module in ENGINEERING.md and records it
  - Place a change in a category and module before code
  - Record features and modules in the same change
  - Propose an ENGINEERING.md for a repository without one
  - Asks the user, in plain words, about an unclear module choice or any decision under 90% sure
  - ENGINEERING.md template (`references/ENGINEERING.template.md`)
- **engineering-audit** (`skills/engineering-audit/`): read-only audit of layout, docs, leftovers, and whether it runs
  - Report of at most 10 findings in the user's language
  - Proposed ENGINEERING.md when none exists
  - One pass per check; unsettled items reported as unverified
  - Judgments under 90% sure asked as plain questions in the report

### Hooks (`hooks/`)

- **session-start** (`hooks/`): at session start, tells the agent whether ENGINEERING.md exists

## Run & check

- `claude --plugin-dir .` (from the repository root) -> the session context contains "Architectural and Modular Engineering: ENGINEERING.md maps this project's categories, modules, and features."