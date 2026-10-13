---
name: engineering-audit
description: >
  One-shot engineering-discipline audit of an existing software repository,
  firmware included. Maps the system from the code, rates it on intent,
  structure, entropy, test value, documentation, operability, evolution and
  performance, and ranks what to fix first, with evidence for every finding.
  Use when the user asks to audit, review, or check a repository's
  engineering quality, maintainability, dead code, documentation noise, or
  architecture; when a repository with code has no ENGINEERING.md; and when
  the engineering-discipline skill reports a review is due. Reports only;
  changes no code.
argument-hint: "[report language, e.g. Chinese]"
context: fork
agent: general-purpose
background: false
---

# Engineering Audit

You run in an isolated context. Your only inputs are the repository and its
`ENGINEERING.md`, if present. Judge from what you read and run yourself, not
from any account of recent work.

Report language: $ARGUMENTS. If none is given, write in English.

Audit the repository against engineering discipline. Report findings with
evidence. Change no code. The only file you may write is `ENGINEERING.md`,
and only its Review section (step 6). Measurement code from the Performance
dimension is created and deleted within the audit.

Scope: engineering discipline. Correctness bugs and security holes are out
of scope; if one is obvious, name it in one line under "Outside scope".

## Procedure

1. **Map from code.** Find entry points, modules, data flow between them,
   external dependencies, and the commands to build, run, and test. Derive
   the map from code and build files, not from existing docs.
2. **Compare with the contract.** If `ENGINEERING.md` exists, list every
   difference between it and the map: modules, interfaces, features,
   verification steps, scope. Flag verification steps whose outcome is not
   decidable met / not met without judgment.
3. **Collect evidence** for each dimension below. Every finding names the
   path(s) and the check you ran (a search, a command, a git query).
4. **Rate** each dimension.
5. **Report** (format below).
6. **Record.** If `ENGINEERING.md` exists, set in its Review section:
   `Last review: <date>`, `Features since last review: 0`,
   `Last result: <one line: rating per dimension, count of open findings>`.

## Dimensions

**Intent.** A contract or equivalent exists; it matches the code; purpose
and scope are stated.

**Structure.** Each module has one responsibility. No two modules do the
same job. Dependencies point one way; no cycles. Interfaces are explicit.

**Entropy.** Dead code: symbols with no references, files no entry point
reaches, commented-out blocks, flags and config nobody sets, unused
dependencies, duplicated logic. Code noise:
- checks on values the type system or a caller contract already guarantees;
- try/catch around code that cannot throw, and handlers that swallow errors;
- validation of internal function parameters (validation belongs at system
  boundaries);
- helpers called once, wrappers that only delegate, interfaces with one
  implementation, factories with one product, config that is never set;
- comments that restate the code, conversational comments, leftover debug
  output.

Mark each deletion candidate:
- `confirmed`: a whole-repository search finds no reference, and no dynamic
  loading (reflection, plugins, string imports, routing by name) can reach it.
- `verify`: references are absent but dynamic loading is possible, or the
  item may be used outside this repository. The user decides.

**Test value.** Each test should guard a user-visible behavior or a module
interface. Flag tests of implementation details, tests that mainly assert on
mocks, tests of unreachable states, and several tests guarding one behavior.
Report test-code to source-code line ratio as context, not as a verdict.

**Documentation.** Flag: negative statements with no reason ("does not",
"never", "must not" without a why); docs that contradict code; docs older
than the code they describe (compare last-modified commits with `git log`);
agent session logs, progress reports, plans for finished work; metadata and
boilerplate headers; several docs covering one topic. Include `CLAUDE.md`
and `AGENTS.md`.

**Operability.** From a clean checkout, can the project be built, run, and
verified with documented steps? Attempt it. Report the steps that failed or
were missing.

**Evolution.** From git history: ratio of added to deleted lines over the
project and over the last 50 commits; files changed most often (churn
hotspots); features added without any deletion. Persistent add-only growth
is a finding.

**Performance.** List a suspect only where its input size can grow without
bound in real use: loops over growing data, repeated queries or I/O inside
loops, full loads where a stream or index would do, work repeated per
request that could run once. For each suspect, state what n is and how it
grows. If it can be measured here, write a temporary measurement, run it,
and delete the measurement code; report a hotspot as a finding only if it
dominates the measured total. If it cannot be measured here, label it
"suspected" and recommend a measurement. State no performance conclusion
without a measurement.

## Ratings

- **OK**: no finding that affects maintenance.
- **Problem**: findings that slow maintenance or mislead an agent.
- **Severe**: the dimension blocks safe change (no map, cycles across core
  modules, docs that contradict code on core behavior, project cannot be
  built from documented steps).

## Report

Write for a reader who may not read code. Your final message is the full
report; the invoking conversation relays it as written.

1. Verdict: one sentence, and the single thing to fix first.
2. Table: dimension, rating, one-line reason.
3. Findings, ranked by impact on maintenance. Each finding: what it is,
   where (paths), evidence, recommended action, and `confirmed` / `verify`
   for deletions.
4. Cleanup order, if there are deletion or code-noise findings: lock
   current behavior with tests first, then clean one category per pass
   (dead code, then code noise, then documentation), running the tests
   after each pass.
5. Open deviations from `ENGINEERING.md`, if any.
6. Outside scope: obvious bugs or security issues, one line each, if any.

If the repository has no `ENGINEERING.md`, end the report with the map from
step 1 laid out in the structure of the contract template
(`${CLAUDE_PLUGIN_ROOT}/skills/engineering-discipline/references/ENGINEERING.template.md`)
as a proposed contract. Write nothing to the repository in that case; the
invoking conversation writes it after the user confirms.
