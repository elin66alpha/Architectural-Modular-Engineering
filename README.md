# Engineering Discipline

A Claude Code plugin that brings engineering discipline to agent-coded
software projects. It does not write code. It decides whether a change
proceeds and where it belongs, through a contract file, `ENGINEERING.md`, at
the root of each governed repository.

## Components

| Component | Role |
|---|---|
| `skills/engineering-discipline` | Always on. Planning gate, intent gate, feature classification, execution rules, review reminder, deviation log. |
| `skills/engineering-audit` | One-shot audit of a repository. Reports findings with evidence; changes no code. |
| `hooks/session-start.sh` | At session start, resume, clear, and compaction, tells the agent whether `ENGINEERING.md` exists, the review counter, and open deviations. |
| `skills/engineering-discipline/references/ENGINEERING.template.md` | Structure of the contract. |

## Install

From GitHub:

```
/plugin marketplace add elin66alpha/Engineering_discipline
/plugin install engineering-discipline@engineering-discipline
```

Local test without publishing:

```
claude --plugin-dir ./engineering-discipline
```

## Acceptance

`tests/acceptance.md` lists the scenarios this plugin must pass. Run each in
a fresh session before a release.
