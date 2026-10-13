# Acceptance scenarios

Each scenario runs in a fresh Claude Code session with the plugin enabled.
A scenario passes when every check in its Expected column is true. Each
check is read off the transcript or the repository files.

| # | Setup | User input | Expected |
|---|---|---|---|
| 1 | Empty directory | "Build a todo web app" | (a) No source file exists before the user confirms a plan. (b) After confirmation, ENGINEERING.md exists with Purpose, Scope, Architecture, Features, Verification, Milestones filled. (c) CLAUDE.md contains the pointer line. |
| 2 | Repo with code, no ENGINEERING.md | "Add CSV export" | (a) engineering-audit runs before any source file changes. (b) A proposed contract is shown. (c) No source file changes before the user confirms it. |
| 3 | Same as 2 | "Skip the contract, just add it" | ENGINEERING.md exists, contains only a Deviations section with exactly one `[open]` line, and the feature is then implemented. |
| 4 | Same as 2 | "Fix the crash when the list is empty" | The fix is made; no ENGINEERING.md is created. |
| 5 | Single-file script, no callers | "Add a --verbose flag" | The reply contains one sentence stating the exemption; the flag is added; no ENGINEERING.md is created. |
| 6 | Contract present | Feature that fits one module | (a) Reply names the module and states completion criteria before code changes. (b) Features gains one `active` row. (c) `Features since last review` increases by 1. |
| 7 | Contract present | Feature duplicating an active feature | No source change; reply offers exactly replace / merge / drop. After "replace": old row is `deprecated`, its code paths are listed for removal. |
| 8 | Contract present | Feature needing a new module | No source change before confirmation. After confirmation: Architecture has the new module and Changes has a new dated line. |
| 9 | Contract with an Out item | Request hitting that item | No source change; reply quotes the Out item and its reason. |
| 10 | Contract with `Features since last review: 3` | Any feature request | Session context contains "A review is due"; the reply mentions the review before any source change. |
| 11 | Contract present | "Audit the repo" | (a) Report has a verdict line, a table with 8 dimensions each rated OK / Problem / Severe, and findings each with a path. (b) Deletion findings are marked confirmed or verify. (c) `git diff` shows changes only in ENGINEERING.md's Review section; counter is 0. |
| 12 | Repo with an O(n^2) loop over a list read from user uploads | "Audit the repo" | The finding states what n is. Either measured numbers are reported and no measurement file remains in `git status`, or it is labeled "suspected". |
| 13 | Repo with an O(n^2) loop over a fixed 5-element constant | "Audit the repo" | That loop is not listed as a performance finding. |
| 14 | Contract present, user writes in Chinese | Any gate stop | Reply to the user is in Chinese; text written to ENGINEERING.md is in English. |
| 15 | Contract present | Confirmed feature; an unrelated bug exists in a touched file | The bug appears under "Noticed"; `git diff` shows it unchanged. |
| 16 | Repo with code and a contract | "Add login" | No question in the reply asks for something stated in ENGINEERING.md or answerable by reading the repo (e.g. which framework is used). |
| 17 | Empty directory | "Build something for my shop"; answer every question about the problem vaguely | By the third round the reply lists known facts, unknowns, and a proposed assumption for each unknown, and asks for confirmation. |
| 18 | Contract present | "Add export, dark mode and email alerts" | The reply lists three features and classifies only the first before any source change. |
| 19 | Empty directory | Run scenario 1 to the plan stage | Every Verification and Milestone line names a command or observation and an expected result; none uses "works", "correctly", or "properly" as the criterion. |
| 20 | Repo with a null check on a non-nullable typed parameter, a try/catch around pure arithmetic, and a helper called once | "Audit the repo" | All three appear under Entropy with paths. |
| 21 | Contract present; conversation earlier claimed "the tests all pass" while one test fails | "Audit the repo" | The report states the failing test. |
