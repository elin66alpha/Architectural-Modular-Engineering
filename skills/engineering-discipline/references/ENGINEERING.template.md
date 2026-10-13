# ENGINEERING.md

Engineering contract for this repository. Every agent reads this before any
change. Keep each section short; this file is the map, not the manual.

## Purpose

<One or two sentences: the problem this system solves and for whom.>

## Scope

In:
- <capability this version delivers>

Out:
- <excluded direction>. Reason: <why>.

## Architecture

| Module | Responsibility | Interface | Depends on |
|---|---|---|---|
| <name> | <one responsibility> | <entry points, inputs, outputs> | <modules> |

Dependency direction: <e.g. ui -> service -> storage; no reverse edges>.

## Features

| Feature | Module | Status |
|---|---|---|
| <feature> | <module> | active / deprecated |

Deprecated features stay listed until their code is deleted, then the row is
removed.

## Verification

How to confirm the system works without reading code. Each line is decidable
met / not met with no judgment call.
- <command or demo step> -> <expected result>

## Milestones

| Milestone | Completion criteria | Status |
|---|---|---|
| <name> | <command or observation -> expected result> | planned / done |

## Changes

Architecture-level changes only. Keep the latest 10; fold older entries into
one summary line.

- YYYY-MM-DD: <what changed in the architecture>. Reason: <why>.

## Review

Last review: none
Features since last review: 0
Last result: none

## Deviations

None.
