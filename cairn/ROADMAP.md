# Roadmap

_The only authority on milestone status. Grouped by status, not ID._
_Last hygiene check: 2026-09-13 (M001 archived, validator clean, byte budgets within caps)_

## Milestones

| ID | Title | Status | Depends on | Priority | File/Archive |
|---|---|---|---|---|---|
| M001 | The paper has a sourced outline in JOSS's required structure | done | — | high | milestones/archive/M001-paper-outline.md |
<!-- rows grouped by status, not sorted by ID; keep only the 3 most recent
     terminal (done or dropped) rows — older ones live in milestones/archive/ + git -->

## Candidates
<!-- unnumbered ideas; one line each, ordered high → normal → low:
     - [high] idea — added YYYY-MM-DD — links
     - idea — added YYYY-MM-DD — links
     the opening token is `[high]`/`[low]` or absent (`normal`) — tracking-rules "Candidate priority token" -->
- [high] Correct the intraclass comparison vignette's claim that psych needs complete data. `psych::ICC` defaults to `lmer = TRUE` and used all 6 subjects of `ratings_incomplete` (psych 2.6.5, run 2026-09-13). The matrix's psych "no" for incomplete data and the listwise-deletion text are wrong. The fix lands in `jmgirard/intraclass` — added 2026-09-13 — M001 review F1
- Draft-PDF workflow: the Open Journals draft action rendering `paper/paper.md` to a PDF artifact on push — added 2026-09-13 — split from the "Paper skeleton" row when M001 absorbed it
- Draft the text from the package's comparison-with-other-packages article, with every reported number produced by a committed script against a named `intraclass` version. This includes the claim that intraclass's ICC(A,1) reproduces irrICC's two-way random agreement coefficient, which no script checks yet — added 2026-09-10 — DESIGN Conventions, M001 review F4
- Submission: research-impact evidence gathered, the `paper/` directory copied onto a never-merged `joss-paper` branch of `jmgirard/intraclass` (that repository's candidate row "JOSS submission and acceptance follow-through"), the JOSS form filed by the maintainer; timing is the maintainer's call — added 2026-09-10 — package repository D-045
