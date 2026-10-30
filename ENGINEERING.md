# ENGINEERING.md

Map of this repository: categories, the modules in each, the features in
each module. Read it before any change; update it in the same change. It
describes what exists now: no history, no plans.

## Architecture

### Plugin manifests and marketplaces (`.claude-plugin/`, `.codex-plugin/`, `.agents/plugins/`)

- **plugin** (`.claude-plugin/plugin.json`): plugin name, version, description
- **marketplace** (`.claude-plugin/marketplace.json`): lets this repository be installed as a one-plugin marketplace
- **codex-plugin** (`.codex-plugin/plugin.json`): Codex plugin version, presentation, and shared skills directory
- **codex-marketplace** (`.agents/plugins/marketplace.json`): exposes the repository root as an installable Codex plugin

### Skills (`skills/`)

- **architectural-modular-engineering** (`skills/architectural-modular-engineering/`): places each feature or module in ENGINEERING.md and records it
  - Place a change in a category and module before code
  - Record features and modules in the same change
  - Propose an ENGINEERING.md for a repository without one
  - Asks the user, in plain words, about an unclear module choice or any decision under 90% sure
  - ENGINEERING.md template (`references/ENGINEERING.template.md`)
  - Shared Claude Code and Codex instructions; host-specific agent instruction files
- **engineering-audit** (`skills/engineering-audit/`): read-only audit of layout, docs, leftovers, and whether it runs
  - Report of at most 10 findings in the user's language
  - Proposed ENGINEERING.md when none exists
  - One pass per check; unsettled items reported as unverified
  - Judgments under 90% sure asked as plain questions in the report
  - Codex execution and report-language fallback; shared template resolved relative to the skill

### Hooks (`hooks/`)

- **session-start** (`hooks/`): in Claude Code, at session start, tells the agent whether ENGINEERING.md exists

### Agent instructions and installation (`./`)

- **instructions** (`AGENTS.md`, `CLAUDE.md`): point each host to the architecture map; Codex also gets the local skill path
- **installation** (`README.md`): Claude Code plugin setup and Codex skill installation, invocation, and persistent guidance

## Run & check

- `claude --plugin-dir .` (from the repository root) -> the session context contains "Architectural and Modular Engineering: ENGINEERING.md maps this project's categories, modules, and features."
- `codex` (after the README's Codex installation), then `/skills` -> both skills are listed, prefixed with `architectural-modular-engineering:` when installed as a plugin
- `codex plugin list --marketplace architectural-modular-engineering` (after marketplace installation) -> the plugin is installed and enabled
