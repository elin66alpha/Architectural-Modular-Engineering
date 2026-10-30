# Architectural and Modular Engineering

Skills for Claude Code and Codex that keep agent-coded projects easy to find
your way around. Each repository has an `ENGINEERING.md` at its root that maps the
architecture: categories, the modules in each, the features in each module.
Every new feature or module is placed in that map and recorded there.

## Components

| Component | Role |
|---|---|
| `skills/architectural-modular-engineering` | Places each feature or module in the architecture and records it in `ENGINEERING.md`. |
| `skills/engineering-audit` | One-shot audit of layout, docs, and leftover files, in plain words. Reports only; changes no code. |
| `hooks/session-start.sh` | Claude Code only: at session start, resume, clear, and compaction, tells the agent whether `ENGINEERING.md` exists. |
| `AGENTS.md` | Codex instructions for working in this repository. |
| `.codex-plugin/plugin.json` | Codex plugin metadata and shared skill directory. |
| `.agents/plugins/marketplace.json` | Codex marketplace catalog for this repository. |
| `skills/architectural-modular-engineering/references/ENGINEERING.template.md` | Structure of `ENGINEERING.md`. |

## Install

### Claude Code

From GitHub:

```
/plugin marketplace add elin66alpha/Architectural-Modular-Engineering
/plugin install architectural-modular-engineering@architectural-modular-engineering
```

Local test without publishing:

```
claude --plugin-dir .
```

### Codex

Install from this repository's marketplace:

```sh
codex plugin marketplace add elin66alpha/Architectural-Modular-Engineering --ref main
codex plugin add architectural-modular-engineering@architectural-modular-engineering
```

Check the installation:

```sh
codex plugin list --marketplace architectural-modular-engineering
```

In a new Codex session, use `/skills` to select either skill. Marketplace
skills have the plugin name as a prefix:

```text
$architectural-modular-engineering:architectural-modular-engineering Add a feature to this project.
$architectural-modular-engineering:engineering-audit Review this repository and report in Chinese.
```

To update later:

```sh
codex plugin marketplace upgrade architectural-modular-engineering
codex plugin add architectural-modular-engineering@architectural-modular-engineering
```

This is a repository marketplace, not a listing in the official public
Plugins Directory. It bundles both skills and requires no connected service.
The commands above are supported by Codex CLI 0.166.0; update Codex if your
version does not have `codex plugin`.

#### Alternative: local skills for development

Choose this instead of the marketplace installation to load changes directly
from a local checkout. Do not install both copies of the skills.

From the root of this checkout, link both skills into your personal skills
directory (macOS/Linux). Keep the checkout in place while using these links.
If a skill with either name is already installed, resolve that duplicate
before installing; these commands do not replace existing entries.

```sh
mkdir -p "$HOME/.agents/skills"
ln -s "$PWD/skills/architectural-modular-engineering" "$HOME/.agents/skills/"
ln -s "$PWD/skills/engineering-audit" "$HOME/.agents/skills/"
```

For a project-only installation, copy both skill directories into that
project's `.agents/skills/` instead. Install them together: the audit uses
the architecture skill's template. Use either personal or project scope
to avoid duplicate skill names.

Open Codex in the target project. Use `/skills` to check discovery, then:

```text
$architectural-modular-engineering Add a feature to this project.
$engineering-audit Review this repository and report in Chinese.
```

Codex can also select skills when a request matches their descriptions.
If the skills do not appear, restart Codex. For persistent guidance, add
the following to the target project's `AGENTS.md`, preserving existing
instructions:

```markdown
For feature or module changes, use the architectural-modular-engineering skill.
Read ENGINEERING.md before any change if it exists, and update it when the architecture changes.
If it is missing, follow the skill's missing-map workflow.
```

Both Codex installation methods use skills and `AGENTS.md`; they do not install
the Claude Code marketplace or session hook. The audit's `context`, `agent`,
`background`, and `argument-hint` frontmatter fields are for Claude Code;
Codex follows the host-specific instructions in the skill body.

See the official OpenAI documentation for
[skills](https://learn.chatgpt.com/docs/build-skills) and
[AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md), plus
[plugin packaging](https://developers.openai.com/plugins/build/plugins).
