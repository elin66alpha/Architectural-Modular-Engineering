---
name: architectural-modular-engineering
description: >
  Keeps ENGINEERING.md, the map of a repository's architecture: categories,
  the modules in each, the features in each module. Places every new feature
  or module in that map and records it there. Use on any request to start a
  project, add, change, or remove a feature or module, or restructure code;
  whenever the repository has an ENGINEERING.md; and whenever session context
  reports that ENGINEERING.md is missing. Skip for non-coding requests and
  for a single-file script with no external callers.
---

# Architectural and Modular Engineering

`ENGINEERING.md` at the repository root maps the architecture: categories,
the modules in each category, the features in each module. Its structure is
in `references/ENGINEERING.template.md`. Write it in English.

This skill puts each new feature or module where it belongs and records it.
It does not judge whether a feature is worth building, and it sets no style
for the code.

Works in Claude Code and Codex. Resolve reference paths relative to this
skill's directory. In Codex, check for `ENGINEERING.md` directly; the Claude
Code session hook is not required.

A single-file script with no external callers is exempt. Say so in one
sentence and proceed normally.

## No ENGINEERING.md

- Empty repository: propose the first categories and modules for what the
  user asked, in a few lines. Write `ENGINEERING.md` and code after the user
  confirms.
- Existing code: load the companion `engineering-audit` skill and request
  the report in the user's language. It returns a proposed `ENGINEERING.md` mapped
  from the code. Write it after the user confirms. If the user declines,
  proceed without it.
- Bug fixes and documentation fixes proceed without it.

## Placing a change

Before writing code, say in one sentence where each feature goes:
category, then module. If one request holds several features, place each.

- Fits an existing module: proceed.
- Needs a new module or category, or moves a feature between modules: name
  it and its folder, and proceed after the user confirms.
- Duplicates an existing feature: name it, and let the user choose replace,
  merge, or drop.

## Recording

In the same change as the code:

- Add the feature under its module; add new modules and categories.
- A removed feature loses its line and its code. Delete the code; do not
  comment it out or switch it off with a flag.
- Update Run & check when the commands change. Each line is a command and
  its expected result.

## Execution rules

- Do only what was confirmed. Anything else you notice goes in the report
  under "Noticed", not into the change.
- Create no new documentation files unless the user asks for one.
- No session logs, progress reports, or change summaries in the
  repository. Git history holds them.
- Do not dwell. If you cannot tell which module a feature belongs to, ask
  the user which one; do not pick for them. Do not reorganize the map or
  polish `ENGINEERING.md` beyond what the change needs.
- If you are less than 90% sure of a decision, ask the user in short,
  plain words before acting on it. Do not keep reading code to reach
  certainty.

## Agent instruction files

When `ENGINEERING.md` is first written, add this line to existing
`CLAUDE.md` and `AGENTS.md` files without duplicating it. Ensure the current
host's file exists: `AGENTS.md` for Codex, `CLAUDE.md` for Claude Code;
create it with only this line if missing. Tell the user which files changed.

`Read ENGINEERING.md before any change. It maps this repository's categories, modules, and features.`

## Reporting to the user

Speak in the user's language, in plain words.

- Before code: where the change goes, and the question if one is needed.
- After a change:
  - Changed: the features and modules affected.
  - Check: how to see it works without reading code.
  - Noticed: issues found and left untouched, if any.
- Audit results: relay the audit report in full, in the user's language.
