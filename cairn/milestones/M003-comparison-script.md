# M003: A committed script produces the comparison figures the paper reports

- **Status:** in-progress
- **Priority:** normal
- **Depends on:** —
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the paper publishes its figures, and readers can run it again
- **Branch/PR:** m003-comparison-script

## Goal

`analysis/comparison.R` writes every comparison figure the paper cites to `analysis/comparison-results.csv`, together with the package versions that produced them.

## Scope

**In:** the script, its committed results file, a CRAN reinstall of intraclass 0.1.0 before the run, and the three outline bullets in `paper/paper.md` that cite these figures.

**Out:** prose that uses the figures (M004). The package vignette's wrong psych claim is fixed in `jmgirard/intraclass` (candidate row). Research-impact figures stay in the submission candidate row.

## Acceptance criteria

- [ ] AC1: `analysis/comparison-results.csv` is tracked (`git ls-files --error-unmatch` exits 0). `Rscript analysis/comparison.R`, run from the repo root, exits 0 and rewrites it. `git diff --exit-code analysis/comparison-results.csv` then exits 0. The script stops with an error when intraclass, psych, irr, or irrICC is not installed.
- [ ] AC2: The results file holds rows `version_intraclass`, `version_psych`, `version_irr`, `version_irrICC` (each `packageVersion()`) and `repository_intraclass` (`packageDescription("intraclass")$Repository`). `version_intraclass` is `0.1.0`, and `repository_intraclass` is `CRAN`.
- [ ] AC3: The results file has the columns `name,value`, with values written to 6 significant digits and no interval or timestamp rows. It holds 18 rows named `balanced_<pkg>_<coef>`, for pkg in `intraclass`, `psych`, `irr` and coef in `ICC1`, `ICC1k`, `ICCA1`, `ICCAk`, `ICCC1`, `ICCCk`. It also holds the row `balanced_max_abs_gap`, the largest absolute intraclass-minus-psych or intraclass-minus-irr difference among them. The other rows are `irricc_icc2r`, `irricc_abs_diff_ICCA1`, `incomplete_complete_case_subjects`, `incomplete_intraclass_subjects`, `incomplete_intraclass_ratings`, `incomplete_intraclass_k_eff`, and `incomplete_psych_subjects` (`n.obs` from `psych::ICC` with its defaults).
- [ ] AC4: In `paper/paper.md`, three bullets each state the value of their row at a rounding the bullet names, and each ends in `[src: analysis/comparison-results.csv]`. The bullets are the State of the field bullet on the largest gap (`balanced_max_abs_gap`), the irrICC agreement bullet (`irricc_abs_diff_ICCA1`), and the Statement of need bullet on listwise deletion (`incomplete_complete_case_subjects`). The irrICC bullet says "reproduces" only if `irricc_abs_diff_ICCA1` is below 5e-5.

## Coverage

- AC1 → T2, T3
- AC2 → T1, T2
- AC3 → T2
- AC4 → T4

## Tasks

- [x] T1: Reinstall intraclass 0.1.0 from CRAN and confirm that `packageDescription("intraclass")$Repository` is `CRAN`.
- [x] T2: Write `analysis/comparison.R`, adapted from `intraclass/vignettes/comparison-with-other-packages.Rmd` (the validation, irrICC, and incomplete-data chunks). Use a hard `stop()` for missing packages, point estimates only, `signif(x, 6)`, and a fixed row order.
- [x] T3: Run the script, commit the results file, run it again, and confirm `git diff --exit-code`.
- [ ] T4: Update the three outline bullets from the results file.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the script half of the candidate row "Draft the text from the package's comparison-with-other-packages article", including the untested irrICC agreement claim (M001 review F4).
- 2026-09-13: criteria audit (full mode, fresh Opus reader) returned 7 findings. An untracked file passes `git diff`, full-precision values can drift between machines, missing packages were skipped silently, "a CRAN release" had no check, row names were open, the irrICC difference had no sign rule, and a bullet was able to keep its placeholder. All were fixed in the wording above. A finding that psych drops incomplete subjects was rejected: `psych::ICC` used all 6 subjects of `ratings_incomplete` on a local run (psych 2.6.5).
- 2026-09-13: plan gate chose CRAN intraclass 0.1.0 over the GitHub development version, because reviewers can install the same version. Falsified by a comparison figure that differs between 0.1.0 and the development version.
- 2026-09-13: implement started on branch m003-comparison-script. No question gate, because the plan left no choice open.
- 2026-09-13: T1 done. The installed intraclass was a local build with no Repository field. `install.packages("intraclass")` from CRAN gave version 0.1.0, Repository CRAN.
- 2026-09-13: T2 done. The first run stopped because the one-way average term in intraclass 0.1.0 is `ICC(k)`, not `ICC(1,k)`, so the script now stops when a term is not one row. A run with `requireNamespace` masked to fail for each of the four packages in turn exited 1 with that package named.
- 2026-09-13: T3 done. The results file is committed with 31 rows. A second run exited 0, changed the file time, and left `git diff --exit-code` at 0.

## Decisions
