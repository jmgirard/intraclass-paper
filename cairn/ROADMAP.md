# Roadmap

_The only authority on milestone status. Grouped by status, not ID._
_Last hygiene check: 2026-09-13 (M004 archived, M001 row pruned, M003 gap-bound row cut to its remainder, one lesson added, validator clean, byte budgets within caps)_

## Milestones

| ID | Title | Status | Depends on | Priority | File/Archive |
|---|---|---|---|---|---|
| M004 | The paper is drafted as prose within JOSS's length limit | done | M002, M003 | normal | milestones/archive/M004-prose-draft.md |
| M003 | A committed script produces the comparison figures the paper reports | done | — | normal | milestones/archive/M003-comparison-script.md |
| M002 | A push that changes the paper builds a JOSS draft PDF | done | — | normal | milestones/archive/M002-draft-pdf-workflow.md |
<!-- rows grouped by status, not sorted by ID; keep only the 3 most recent
     terminal (done or dropped) rows — older ones live in milestones/archive/ + git -->

## Candidates
<!-- unnumbered ideas; one line each, ordered high → normal → low:
     - [high] idea — added YYYY-MM-DD — links
     - idea — added YYYY-MM-DD — links
     the opening token is `[high]`/`[low]` or absent (`normal`) — tracking-rules "Candidate priority token" -->
- [high] Correct the intraclass comparison vignette's claim that psych needs complete data. `psych::ICC` defaults to `lmer = TRUE` and reported all 6 subjects of `ratings_incomplete` (psych 2.6.5, run 2026-09-13, corrected M004 because `n.obs` counts input rows). The matrix's psych "no" for incomplete data and the listwise-deletion text are wrong. The fix lands in `jmgirard/intraclass` — added 2026-09-13 — M001 review F1
- Re-check the paper's irr listwise-deletion citation once the vignette row above is fixed. The gap-as-bound half was declined at the M004 start gate — added 2026-09-13 — M003 review F4
- Check what `packageDescription("intraclass")$Repository` records for intraclass 0.1.0 installed from Posit Package Manager on Linux. If it is `RSPM`, decide whether `analysis/comparison.R` accepts it, because the script stops unless the field is `CRAN` — added 2026-09-13 — M003 review G1
- Add rows to `analysis/comparison.R` for psych's estimates on `ratings_incomplete`. The paper can then say they differ from intraclass (psych ICC(1) 0.116 against 0.276 in a 2026-09-13 run). That also restores the incomplete-data contrast with psych in the need argument — added 2026-09-13 — M004 review F2, R1
- In `analysis/comparison.R`, also compare against irrICC `icc2.nointer.fn`. The `icc2.inter.fn` manual says it needs replicate ratings, and `ratings` has one rating per cell — added 2026-09-13 — M004 review R7
- In State of the field, say why intraclass is a new package and not a contribution to psych or irr. Current JOSS review guidance asks for this — added 2026-09-13 — M004 review F4
- Submission: research-impact evidence gathered (including the mention of past or ongoing research projects that the JOSS paper guide asks for, M004 review G1), the `paper/` directory copied onto a never-merged `joss-paper` branch of `jmgirard/intraclass` (that repository's candidate row "JOSS submission and acceptance follow-through"), the JOSS form filed by the maintainer; timing is the maintainer's call — added 2026-09-10 — package repository D-045
