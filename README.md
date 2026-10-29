# Engineering Discipline

A Claude Code plugin that keeps agent-coded projects easy to find your way
around. Each repository has an `ENGINEERING.md` at its root that maps the
architecture: categories, the modules in each, the features in each module.
Every new feature or module is placed in that map and recorded there.

## Components

| Component | Role |
|---|---|
| `skills/engineering-discipline` | Always on. Places each feature or module in the architecture and records it in `ENGINEERING.md`. |
| `skills/engineering-audit` | One-shot audit of layout, docs, and leftover files, in plain words. Reports only; changes no code. |
| `hooks/session-start.sh` | At session start, resume, clear, and compaction, tells the agent whether `ENGINEERING.md` exists. |
| `skills/engineering-discipline/references/ENGINEERING.template.md` | Structure of `ENGINEERING.md`. |

## Install

From GitHub:

```
/plugin marketplace add elin66alpha/Engineering_discipline
/plugin install engineering-discipline@engineering-discipline
```

Local test without publishing:

```
claude --plugin-dir .
```
