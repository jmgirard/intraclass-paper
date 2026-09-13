# M005: The paper's comparison with psych and irrICC rests on script rows for incomplete data and the no-interaction model

- **Status:** planned
- **Priority:** normal
- **Depends on:** M004
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the paper text submitted to JOSS and the results file it cites
- **Branch/PR:** —

## Goal

`analysis/comparison-results.csv` records psych's and intraclass's six estimates on `ratings_incomplete` and irrICC's no-interaction coefficient on `ratings`, and `paper/paper.md` states the comparison from those rows.

## Scope

**In:** 15 new rows in `analysis/comparison.R` and its results file, two of which replace the interaction-model irrICC rows. State of the field sentences say which coefficients psych and intraclass agree or differ on for `ratings_incomplete`. They give each package's divisor for the averaged coefficients. The irrICC comparison sentence names the model without interaction. The sentence "On the `ratings_incomplete` example, psych reported 6 subjects." is removed.

**Out:** the Statement of need stays as it is (plan gate). The psych vignette fix, the irr listwise citation re-check, the RSPM repository check, and the why-a-new-package paragraph stay as candidate rows. Research impact stays in the submission row.

## Acceptance criteria

- [ ] AC1: From the repository root, with intraclass 0.1.0 from CRAN and the psych, irr, and irrICC versions that the committed version rows record, `Rscript analysis/comparison.R` exits 0. `git diff --exit-code analysis/comparison-results.csv` then exits 0. The committed file has exactly one row for each of 15 names: `incomplete_psych_<c>` and `incomplete_intraclass_<c>` for `<c>` in ICC1, ICC1k, ICCA1, ICCAk, ICCC1, ICCCk, plus `incomplete_psych_k`, `irricc_nointer_icc2r`, and `irricc_nointer_abs_diff_ICCA1`. It has no row named `irricc_icc2r` or `irricc_abs_diff_ICCA1`, and `grep -c 'icc2.inter.fn' analysis/comparison.R` prints 0.
- [ ] AC2: Each of the 15 values matches, at 6 significant digits, a value from an R session that does not source the script. That session can reshape data with its own code. It computes `psych::ICC()` on the wide `ratings_incomplete` matrix, types ICC1, ICC1k, ICC2, ICC2k, ICC3, and ICC3k in `<c>` order. From psych's ICC2 and ICC2k it computes `incomplete_psych_k`, the rater count k that solves the Spearman-Brown formula ICC2k = k ICC2 / (1 + (k - 1) ICC2). It computes `tidy()` of `intraclass::icc()` on `ratings_incomplete` for the six terms, with `unit` "single" or "average". ICC(1) and ICC(k) use `model = "oneway", type = "agreement"`. ICC(A,1) and ICC(A,k) use `model = "twoway", type = "agreement"`. ICC(C,1) and ICC(C,k) use `model = "twoway", type = "consistency"`. It computes `irrICC::icc2.nointer.fn()` icc2r on the wide `ratings` frame, and its absolute difference from the same session's intraclass ICC(A,1) on `ratings`.
- [ ] AC3: The State of the field section of `paper/paper.md` covers ICC(1), ICC(k), ICC(A,1), ICC(A,k), ICC(C,1), and ICC(C,k) on `ratings_incomplete`. It says in words whether each one agreed or differed between psych and intraclass. A group statement counts only if it names each coefficient it covers. A coefficient said to agree has an absolute difference below 0.00001 between its `incomplete_psych_<c>` and `incomplete_intraclass_<c>` rows. One said to differ has a difference of 0.001 or more. The section gives the divisor each package uses for its averaged coefficients. Each divisor it prints equals `incomplete_psych_k` or `incomplete_intraclass_k_eff`, rounded to the decimal places the paper prints. The divisor sentence names only averaged coefficients and gives no cause for the ICC(1) difference. The section no longer contains "On the `ratings_incomplete` example, psych reported 6 subjects."
- [ ] AC4: The State of the field section has at least one sentence that states the difference between intraclass and irrICC. Each such sentence of `paper/paper.md` names the random factorial model without subject-rater interaction. No such sentence names a model with interaction. The difference it states equals `irricc_nointer_abs_diff_ICCA1` rounded to the decimal places the paper prints.
- [ ] AC5: Below the front matter of `paper/paper.md`, each number found by `grep -o -E '[<-]?[0-9][0-9.,]*(e-?[0-9]+)?'` or by `grep -o -i -w -E 'one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty'` is one of these: a value in `analysis/comparison-results.csv` rounded to the decimal places the paper prints, a year, a version number, part of a coefficient label such as ICC(A,1), a count of items that the same sentence names, part of an author name ("ten Hove"), or the digit in the package name lme4 wherever that name appears, including code spans and the `@lme4` citation key.
- [ ] AC6: The set of keys from `grep -o -E '@[A-Za-z0-9_:-]+' paper/paper.md` equals the set of entry keys in `paper/paper.bib`, and `pandoc paper/paper.md --citeproc --bibliography paper/paper.bib -o /dev/null` prints no citation-not-found warning. `pandoc paper/paper.md -t plain | wc -w` reports between 750 and 1750.
- [ ] AC7: This criterion covers each sentence of `paper/paper.md` that `git diff main...HEAD -- paper/paper.md` shows as added or changed. Each sentence on a changed line counts as changed. If such a sentence describes the behavior of psych, irr, irrICC, performance, or intraclass, it states only behavior that `analysis/comparison-results.csv` at the branch head shows or that the package's own reference manual documents. For psych, irr, irrICC, and intraclass, the manual is the one for the version recorded in that file. For performance, it is the one for version 0.17.1. A sentence that says one of these packages lacks a feature passes only if that manual states the limit in words.
- [ ] AC8: A run of the draft-PDF workflow on the milestone branch head SHA concludes `success`.

## Coverage

- AC1 → T1
- AC2 → T2
- AC3 → T3, T4
- AC4 → T1, T3
- AC5 → T4
- AC6 → T4
- AC7 → T3, T4
- AC8 → T5

## Tasks

- [ ] T1: In `analysis/comparison.R`, add the 12 incomplete-data estimate rows and the `incomplete_psych_k` row, and replace the `icc2.inter.fn` rows with `icc2.nointer.fn` rows. Rerun the script and commit the results file.
- [ ] T2: In a separate R session, recompute the 15 values as AC2 states, and compare them to the committed rows. Record the comparison in the work log.
- [ ] T3: Rewrite the State of the field sentences on `ratings_incomplete` and irrICC from the new rows, and remove the "psych reported 6 subjects" sentence. Take each divisor from its results row, and read the psych 2.6.5 `ICC` manual and the intraclass 0.1.0 `icc` manual for the sentence around it (M001 and M004 lessons).
- [ ] T4: Run the number, citation, word-count, and package-claim checks, fix what they find, and record the number ledger in the work log.
- [ ] T5: Push the branch and confirm the draft-PDF run on the head SHA.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the candidate rows "Add rows to `analysis/comparison.R` for psych's estimates on `ratings_incomplete`" (M004 review F2, R1) and "compare against irrICC `icc2.nointer.fn`" (M004 review R7).
- 2026-09-13: criteria audit (full mode, fresh Opus reader) returned 7 findings. The irrICC difference row and the `icc()` arguments were unnamed. A documentation-site sentence outside the scope failed the claim criterion. Removing the psych subjects sentence was unbound, and the no-interaction model had no value that set it apart. "Placed as agreeing" was vague, compared-package updates broke the diff with no defect, and "rounding the paper shows" was undefined. All were fixed in the wording above.
- 2026-09-13: criteria re-audit after the gate (full mode, second fresh Opus reader, AC1, AC3, AC4, AC7) returned 4 findings. psych's manual gives no divisor for missing data, so `incomplete_psych_k` was added. AC4 passed with no irrICC sentence, so it now requires one. The divisor sentence must not explain the ICC(1) gap. A changed line with two sentences now counts both. The reader's proposed wording was adopted.
- 2026-09-13: the Scope row count was corrected from 14 to 15 after the plan commit, to match AC1. The 8 criteria pass the sizing advisory by one. They stay in one milestone, because the script rows and the paper sentences that cite them change together.
- 2026-09-13: plan gate chose to replace the interaction-model irrICC rows over keeping both, because the `icc2.inter.fn` manual says it needs replicate ratings and the paper cites only one model. Falsified by a reviewer or JOSS asking for the interaction model on single-rating data.
- 2026-09-13: plan gate chose to explain the averaged-coefficient gap by each package's divisor over stating results only, because without it readers can assume one package is wrong. Falsified by a divisor that neither package's manual documents.
- 2026-09-13: plan gate chose to leave the Statement of need unchanged over adding psych's incomplete-data difference to it, because the paper states facts and does not judge which package is right. Falsified by a JOSS review asking for a stronger incomplete-data need.

## Decisions

## Review
