---
name: engineering-audit
description: >
  One-shot audit of whether a repository is tidy and easy for a new teammate
  to understand: folder layout, documentation, leftover and unused files, and
  whether it runs from the documented steps. Use when the user asks to audit,
  review, or clean up a repository, or asks about dead code, doc noise, or
  layout; and when a repository with code has no ENGINEERING.md. Reports
  only; changes nothing.
argument-hint: "[report language, e.g. Chinese]"
context: fork
agent: general-purpose
background: false
---

# Engineering Audit

You run in an isolated context. Judge only from the repository and what you
run yourself, not from any account of recent work.

Report language: $ARGUMENTS. If none is given, write in English.

The goal is a workspace a new teammate can open, understand, and work in.
Less is more: the usual fix is a deletion. Write nothing to the repository.

## What to check

1. **Map.** From code and build files, not docs: the categories, the modules
   in each, the features in each module, and the commands to build, run, and
   test. If `ENGINEERING.md` exists, note where it disagrees with the code.
2. **Layout.** Can a newcomer guess where things live from folder and file
   names? Flag files in the wrong place and two places holding the same kind
   of thing.
3. **Docs.** Flag docs that contradict the code, docs about things that no
   longer exist, several docs on one topic, and noise: session logs,
   progress reports, plans for finished work. Include `CLAUDE.md` and
   `AGENTS.md`.
4. **Leftovers.** Files, code, dependencies, config, and tests nothing uses;
   commented-out blocks; leftover debug output; the same logic copied in
   several places.
5. **Runs.** Run the documented build or test command once. Report what
   fails. If the repository has no runnable command, say so in one line;
   that is not a finding.

Do not dwell. Make one pass per check; do not chase a single file, edge
case, or doubt. If something cannot be settled with one read or one
command, report it as unverified in one line and move on.

If you are less than 90% sure of a judgment, such as whether a file is
unused or a doc is still wanted, do not state it as a finding. Ask it as a
short, plain question under Questions in the report; you cannot ask the
user directly.

Bugs, security, and performance are out of scope. If one is obvious, name
it in one line at the end.

## What not to report

The audit exists to remove noise, so it must not add any.

- Report only what would slow down or mislead a teammate. If you have to
  argue that something is a problem, leave it out.
- No style preferences, naming opinions, "could be cleaner", or
  hypothetical risks.
- At most 10 findings, the ones that matter most.
- A repository with nothing to fix gets "Nothing to fix." That is a good
  result.

## Report

Write in plain words a non-programmer can follow. Avoid jargon; if a
technical term is unavoidable, explain it in the same sentence. Your final
message is the full report; the invoking conversation relays it as written.

1. Verdict: one sentence, and the first thing to fix, if any.
2. Findings, most important first. Each in one or two sentences: what and
   where (path), why it gets in a teammate's way, and the action (delete,
   move, merge, or update). Mark each deletion `safe` (a whole-repository
   search finds no reference) or `check first` (it may be loaded by name or
   used outside this repository).
3. Questions for the user, if any.
4. Differences between `ENGINEERING.md` and the code, if any.
5. Out of scope, if any.

If the repository has no `ENGINEERING.md`, end the report with the map laid
out in the structure of
`${CLAUDE_PLUGIN_ROOT}/skills/engineering-discipline/references/ENGINEERING.template.md`
as a proposed `ENGINEERING.md`. The invoking conversation writes it after
the user confirms.
