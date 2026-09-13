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

- [x] AC1: `analysis/comparison-results.csv` is tracked (`git ls-files --error-unmatch` exits 0). `Rscript analysis/comparison.R`, run from the repo root, exits 0 and rewrites it. `git diff --exit-code analysis/comparison-results.csv` then exits 0. The script stops with an error when intraclass, psych, irr, or irrICC is not installed.
- [x] AC2: The results file holds rows `version_intraclass`, `version_psych`, `version_irr`, `version_irrICC` (each `packageVersion()`) and `repository_intraclass` (`packageDescription("intraclass")$Repository`). `version_intraclass` is `0.1.0`, and `repository_intraclass` is `CRAN`.
- [x] AC3: The results file has the columns `name,value`, with values written to 6 significant digits and no interval or timestamp rows. It holds 18 rows named `balanced_<pkg>_<coef>`, for pkg in `intraclass`, `psych`, `irr` and coef in `ICC1`, `ICC1k`, `ICCA1`, `ICCAk`, `ICCC1`, `ICCCk`. It also holds the row `balanced_max_abs_gap`, the largest absolute intraclass-minus-psych or intraclass-minus-irr difference among them. The other rows are `irricc_icc2r`, `irricc_abs_diff_ICCA1`, `incomplete_complete_case_subjects`, `incomplete_intraclass_subjects`, `incomplete_intraclass_ratings`, `incomplete_intraclass_k_eff`, and `incomplete_psych_subjects` (`n.obs` from `psych::ICC` with its defaults).
- [x] AC4: In `paper/paper.md`, three bullets each state the value of their row at a rounding the bullet names, and each ends in `[src: analysis/comparison-results.csv]`. The bullets are the State of the field bullet on the largest gap (`balanced_max_abs_gap`), the irrICC agreement bullet (`irricc_abs_diff_ICCA1`), and the Statement of need bullet on listwise deletion (`incomplete_complete_case_subjects`). The irrICC bullet says "reproduces" only if `irricc_abs_diff_ICCA1` is below 5e-5.

## Coverage

- AC1 → T2, T3
- AC2 → T1, T2
- AC3 → T2
- AC4 → T4

## Tasks

- [x] T1: Reinstall intraclass 0.1.0 from CRAN and confirm that `packageDescription("intraclass")$Repository` is `CRAN`.
- [x] T2: Write `analysis/comparison.R`, adapted from `intraclass/vignettes/comparison-with-other-packages.Rmd` (the validation, irrICC, and incomplete-data chunks). Use a hard `stop()` for missing packages, point estimates only, `signif(x, 6)`, and a fixed row order.
- [x] T3: Run the script, commit the results file, run it again, and confirm `git diff --exit-code`.
- [x] T4: Update the three outline bullets from the results file.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the script half of the candidate row "Draft the text from the package's comparison-with-other-packages article", including the untested irrICC agreement claim (M001 review F4).
- 2026-09-13: criteria audit (full mode, fresh Opus reader) returned 7 findings. An untracked file passes `git diff`, full-precision values can drift between machines, missing packages were skipped silently, "a CRAN release" had no check, row names were open, the irrICC difference had no sign rule, and a bullet was able to keep its placeholder. All were fixed in the wording above. A finding that psych drops incomplete subjects was rejected: `psych::ICC` used all 6 subjects of `ratings_incomplete` on a local run (psych 2.6.5).
- 2026-09-13: plan gate chose CRAN intraclass 0.1.0 over the GitHub development version, because reviewers can install the same version. Falsified by a comparison figure that differs between 0.1.0 and the development version.
- 2026-09-13: implement started on branch m003-comparison-script. No question gate, because the plan left no choice open.
- 2026-09-13: T1 done. The installed intraclass was a local build with no Repository field. `install.packages("intraclass")` from CRAN gave version 0.1.0, Repository CRAN.
- 2026-09-13: T2 done. The first run stopped because the one-way average term in intraclass 0.1.0 is `ICC(k)`, not `ICC(1,k)`, so the script now stops when a term is not one row. A run with `requireNamespace` masked to fail for each of the four packages in turn exited 1 with that package named.
- 2026-09-13: T3 done. The results file is committed with 31 rows. A second run exited 0, changed the file time, and left `git diff --exit-code` at 0.
- 2026-09-13: T4 done in 96afecf. The three bullets give 7e-6, 6e-6, and 2, each from its row. Draft-PDF run 34779506540 passed, and its PDF text holds the gap bullet. The T4 tick went in a later commit, because 96afecf was already pushed.
- 2026-09-13: claim audit: 19 claims read, 1 corrected — analysis/comparison.R, analysis/comparison-results.csv, paper/paper.md. The listwise-deletion bullet cited only the CSV for its usability sentence, so it now also cites the vignette and still ends in the CSV marker. The same reader re-read it and it holds.
- 2026-09-13: draft-PDF run 34779674826 on the audit fix passed. Status set to review.
- 2026-09-13: review found AC1 to AC4 passing, the validator clean, and 7 findings from the diff reviewer. At the gate, the maintainer chose fixes for F2, F3, F5, and F6, and a follow-up row for F1, F4, and F7.
- 2026-09-13: amendment return: AC3 — "with non-integer values written to 6 significant digits, trailing zeros kept, and integer counts written as whole numbers". The results file changed in one row, so the AC1 and AC3 evidence must run again at re-review. Status set to in-progress.

## Decisions

## Review

- AC1 (2026-09-13): `git ls-files --error-unmatch analysis/comparison-results.csv` exited 0. `Rscript analysis/comparison.R` from the repo root exited 0 and changed the file time, and `git diff --exit-code` on the file then exited 0. With `requireNamespace` masked to fail for intraclass, psych, irr, and irrICC in turn, each run exited 1 with "Install these packages before running the script: <pkg>".
- AC2 (2026-09-13): the file holds `version_intraclass` 0.1.0, `version_psych` 2.6.5, `version_irr` 0.85, `version_irrICC` 1.0, and `repository_intraclass` CRAN. Each value matched `packageVersion()` or `packageDescription()` in a separate R session.
- AC3 (2026-09-13): the header is `name,value`, with 31 rows and no duplicate names. The name set equals the 31 names the criterion lists. No name matches an interval or time pattern. Every numeric value has at most 6 significant digits and equals its own `signif(x, 6)`. The largest gap recomputed from the 18 balanced rows is 7e-6, which agrees with `balanced_max_abs_gap` 7.15543e-6. A separate count gave 2 complete-case subjects, and `psych::ICC` gave `n.obs` 6, as the file records.
- AC4 (2026-09-13): `paper/paper.md` has 3 lines that cite `[src: analysis/comparison-results.csv]`, and each line ends in that marker. The State of the field gap bullet gives 7e-6, "rounded to one significant digit", from 7.15543e-6. The irrICC bullet gives 6e-6 at the same rounding, from 6.25078e-6. It says "reproduces", and 6.25078e-6 is below 5e-5. The Statement of need listwise-deletion bullet gives 2 as "an exact count", from `incomplete_complete_case_subjects` 2. Draft-PDF run 34779674826 passed on 297c91c, the last commit that changed the paper.
- Consistency gate (2026-09-13): `cairn_validate.py` exited 0 with all checks passed. No principle changed, so `cairn_impact` was skipped. The generic profile names no toolchain checks.
- Independent review (2026-09-13): the blame-history and prior-review reviewers reported no findings. The diff-bug reviewer reported 7 findings, ranked below. Dispositions are pending at the approval gate.
- F1: intraclass estimates come from an optimizer and differ from the exact irr values by up to 7.2e-6, so the 5th and 6th digits, the gap row, and the irrICC row can change on another machine or glmmTMB version.
- F2: `cairn/DESIGN.md` Conventions says that the package's own oracle-verified test values are the source of any comparison figure, but the script computes new values from psych, irr, and irrICC.
- F3: the script records the intraclass version and repository but does not stop when they are not 0.1.0 and CRAN, so a development build silently rewrites the file.
- F4: "reproduces" in the irrICC bullet rests on a 6e-6 difference that is optimizer tolerance. AC4 permits the word below 5e-5.
- F5: `format()` drops trailing zeros, so `balanced_intraclass_ICCA1` is written as 0.28977 (5 digits shown). AC3 says "written to 6 significant digits", and the AC3 evidence line above read it as "at most 6". Integer rows such as `incomplete_intraclass_subjects` 6 also show fewer than 6 digits.
- F6: `format()` follows `getOption("OutDec")`, so a user with a comma decimal setting gets a broken CSV.
- F7: the listwise-deletion bullet cites the vignette passage that also holds the false claim that psych listwise-deletes. The bullet's own sentence does not repeat that claim.
- F3 disposition: fixed now. The script stops unless intraclass is 0.1.0 from CRAN. Copies with a planted version or repository mismatch exited 1 with that message.
- F6 disposition: fixed now. The script sets `OutDec` to a period. The old script under a comma setting wrote `0,165742`, and the new script under the same setting wrote the normal file.
- F5 disposition: the script now writes non-integer values with trailing zeros, so `balanced_intraclass_ICCA1` is 0.289770, the only changed row. Integer counts stay whole, so AC3 needs a gated wording amendment.
- F2 disposition: fixed now. The DESIGN.md convention now names `analysis/comparison.R` as the source of comparison figures, recorded as D-001.
- F1, F4, F7 disposition: follow-up. One candidate row asks M004 to state the gaps as a bound and to re-check the vignette citation.
