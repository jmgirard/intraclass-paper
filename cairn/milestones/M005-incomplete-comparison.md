# M005: The paper's comparison with psych and irrICC rests on script rows for incomplete data and the no-interaction model

- **Status:** review
- **Priority:** normal
- **Depends on:** M004
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the paper text submitted to JOSS and the results file it cites
- **Branch/PR:** m005-incomplete-comparison

## Goal

`analysis/comparison-results.csv` records psych's and intraclass's six estimates on `ratings_incomplete` and irrICC's no-interaction coefficient on `ratings`, and `paper/paper.md` states the comparison from those rows.

## Scope

**In:** 15 new rows in `analysis/comparison.R` and its results file, two of which replace the interaction-model irrICC rows. State of the field sentences say which coefficients psych and intraclass agree or differ on for `ratings_incomplete`. They give each package's divisor for the averaged coefficients. The irrICC comparison sentence names the model without interaction. The sentence "On the `ratings_incomplete` example, psych reported 6 subjects." is removed.

**Out:** the Statement of need stays as it is (plan gate). The psych vignette fix, the irr listwise citation re-check, the RSPM repository check, and the why-a-new-package paragraph stay as candidate rows. Research impact stays in the submission row.

## Acceptance criteria

- [x] AC1: From the repository root, with intraclass 0.1.0 from CRAN and the psych, irr, and irrICC versions that the committed version rows record, `Rscript analysis/comparison.R` exits 0. `git diff --exit-code analysis/comparison-results.csv` then exits 0. The committed file has exactly one row for each of 15 names: `incomplete_psych_<c>` and `incomplete_intraclass_<c>` for `<c>` in ICC1, ICC1k, ICCA1, ICCAk, ICCC1, ICCCk, plus `incomplete_psych_k`, `irricc_nointer_icc2r`, and `irricc_nointer_abs_diff_ICCA1`. It has no row named `irricc_icc2r` or `irricc_abs_diff_ICCA1`, and `grep -c 'icc2.inter.fn' analysis/comparison.R` prints 0.
- [x] AC2: Each of the 15 values matches, at 6 significant digits, a value from an R session that does not source the script. That session can reshape data with its own code. It computes `psych::ICC()` on the wide `ratings_incomplete` matrix, types ICC1, ICC1k, ICC2, ICC2k, ICC3, and ICC3k in `<c>` order. From psych's ICC2 and ICC2k it computes `incomplete_psych_k`, the rater count k that solves the Spearman-Brown formula ICC2k = k ICC2 / (1 + (k - 1) ICC2). It computes `tidy()` of `intraclass::icc()` on `ratings_incomplete` for the six terms, with `unit` "single" or "average". ICC(1) and ICC(k) use `model = "oneway", type = "agreement"`. ICC(A,1) and ICC(A,k) use `model = "twoway", type = "agreement"`. ICC(C,1) and ICC(C,k) use `model = "twoway", type = "consistency"`. It computes `irrICC::icc2.nointer.fn()` icc2r on the wide `ratings` frame, and its absolute difference from the same session's intraclass ICC(A,1) on `ratings`.
- [x] AC3: The State of the field section of `paper/paper.md` covers ICC(1), ICC(k), ICC(A,1), ICC(A,k), ICC(C,1), and ICC(C,k) on `ratings_incomplete`. It says in words whether each one agreed or differed between psych and intraclass. A group statement counts only if it names each coefficient it covers. A coefficient said to agree has an absolute difference below 0.00001 between its `incomplete_psych_<c>` and `incomplete_intraclass_<c>` rows. One said to differ has a difference of 0.001 or more. The section gives the divisor each package uses for its averaged coefficients. Each divisor it prints equals `incomplete_psych_k` or `incomplete_intraclass_k_eff`, rounded to the decimal places the paper prints. The divisor sentence names only averaged coefficients and gives no cause for the ICC(1) difference. The section no longer contains "On the `ratings_incomplete` example, psych reported 6 subjects."
- [x] AC4: The State of the field section has at least one sentence that states the difference between intraclass and irrICC. Each such sentence of `paper/paper.md` names the random factorial model without subject-rater interaction. No such sentence names a model with interaction. The difference it states equals `irricc_nointer_abs_diff_ICCA1` rounded to the decimal places the paper prints.
- [x] AC5: Below the front matter of `paper/paper.md`, each number found by `grep -o -E '[<-]?[0-9][0-9.,]*(e-?[0-9]+)?'` or by `grep -o -i -w -E 'one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty'` is one of these: a value in `analysis/comparison-results.csv` rounded to the decimal places the paper prints, a year, a version number, part of a coefficient label such as ICC(A,1), a count of items that the same sentence names, part of an author name ("ten Hove"), or the digit in the package name lme4 wherever that name appears, including code spans and the `@lme4` citation key.
- [x] AC6: The set of keys from `grep -o -E '@[A-Za-z0-9_:-]+' paper/paper.md` equals the set of entry keys in `paper/paper.bib`, and `pandoc paper/paper.md --citeproc --bibliography paper/paper.bib -o /dev/null` prints no citation-not-found warning. `pandoc paper/paper.md -t plain | wc -w` reports between 750 and 1750.
- [x] AC7: This criterion covers each sentence of `paper/paper.md` that `git diff main...HEAD -- paper/paper.md` shows as added or changed. Each sentence on a changed line counts as changed. If such a sentence describes the behavior of psych, irr, irrICC, performance, or intraclass, it states only behavior that `analysis/comparison-results.csv` at the branch head shows or that the package's own reference manual documents. For psych, irr, irrICC, and intraclass, the manual is the one for the version recorded in that file. For performance, it is the one for version 0.17.1. A sentence that says one of these packages lacks a feature passes only if that manual states the limit in words.
- [x] AC8: A run of the draft-PDF workflow on the milestone branch head SHA concludes `success`.

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

- [x] T1: In `analysis/comparison.R`, add the 12 incomplete-data estimate rows and the `incomplete_psych_k` row, and replace the `icc2.inter.fn` rows with `icc2.nointer.fn` rows. Rerun the script and commit the results file.
- [x] T2: In a separate R session, recompute the 15 values as AC2 states, and compare them to the committed rows. Record the comparison in the work log.
- [x] T3: Rewrite the State of the field sentences on `ratings_incomplete` and irrICC from the new rows, and remove the "psych reported 6 subjects" sentence. Take each divisor from its results row, and read the psych 2.6.5 `ICC` manual and the intraclass 0.1.0 `icc` manual for the sentence around it (M001 and M004 lessons).
- [x] T4: Run the number, citation, word-count, and package-claim checks, fix what they find, and record the number ledger in the work log.
- [x] T5: Push the branch and confirm the draft-PDF run on the head SHA.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the candidate rows "Add rows to `analysis/comparison.R` for psych's estimates on `ratings_incomplete`" (M004 review F2, R1) and "compare against irrICC `icc2.nointer.fn`" (M004 review R7).
- 2026-09-13: criteria audit (full mode, fresh Opus reader) returned 7 findings. The irrICC difference row and the `icc()` arguments were unnamed. A documentation-site sentence outside the scope failed the claim criterion. Removing the psych subjects sentence was unbound, and the no-interaction model had no value that set it apart. "Placed as agreeing" was vague, compared-package updates broke the diff with no defect, and "rounding the paper shows" was undefined. All were fixed in the wording above.
- 2026-09-13: criteria re-audit after the gate (full mode, second fresh Opus reader, AC1, AC3, AC4, AC7) returned 4 findings. psych's manual gives no divisor for missing data, so `incomplete_psych_k` was added. AC4 passed with no irrICC sentence, so it now requires one. The divisor sentence must not explain the ICC(1) gap. A changed line with two sentences now counts both. The reader's proposed wording was adopted.
- 2026-09-13: the Scope row count was corrected from 14 to 15 after the plan commit, to match AC1. The 8 criteria pass the sizing advisory by one. They stay in one milestone, because the script rows and the paper sentences that cite them change together.
- 2026-09-13: plan gate chose to replace the interaction-model irrICC rows over keeping both, because the `icc2.inter.fn` manual says it needs replicate ratings and the paper cites only one model. Falsified by a reviewer or JOSS asking for the interaction model on single-rating data.
- 2026-09-13: plan gate chose to explain the averaged-coefficient gap by each package's divisor over stating results only, because without it readers can assume one package is wrong. Falsified by a divisor that neither package's manual documents.
- 2026-09-13: plan gate chose to leave the Statement of need unchanged over adding psych's incomplete-data difference to it, because the paper states facts and does not judge which package is right. Falsified by a JOSS review asking for a stronger incomplete-data need.
- 2026-09-13: implement started on branch m005-incomplete-comparison. Question gate skipped, because the plan left no implementation choice open.
- 2026-09-13: T1 done. The script writes the 15 rows and exits 0, and `grep -c 'icc2.inter.fn'` prints 0. `incomplete_psych_k` is 4.00000.
- 2026-09-13: T2 done. A separate R session used its own matrix reshape and `uniroot()` for the Spearman-Brown k. It matched all 15 committed rows at 6 significant digits.
- 2026-09-13: T3 done. State of the field now says which of the six coefficients agree and gives the divisors 4 and 3.27. The irrICC sentence names the model without interaction. The divisor wording follows the psych `ICC` manual ("means of k raters") and the intraclass `ratings_incomplete` manual (harmonic mean `k_eff`).
- 2026-09-13: T4 number ledger. 0.000006 is `irricc_nointer_abs_diff_ICCA1`, 0.000007 is `balanced_max_abs_gap`, and 3.27 is `incomplete_intraclass_k_eff`. The divisor 4 is `incomplete_psych_k`, and 2, 20, and 6 are the incomplete subject and rating counts. 1979, 2014, and 2022 are years, and the other 1s and six 4s are ICC labels and lme4. "Four" and "three" count items their sentences name.
- 2026-09-13: T4 checks. Agree gaps are 0.000001 for ICC(A,1) and 0 for ICC(C,1). Differ gaps are 0.024 to 0.21. Citation keys equal the bib keys, pandoc gives no citation warning, and the word count is 1128.
- 2026-09-13: T5 done. Branch pushed. Draft-PDF run 34789943136 on 1e92e67 concluded `success`. Later tracking-only commits do not change `paper/`.
- 2026-09-13: claim audit: 8 claims read, 1 corrected — paper/paper.md, analysis/comparison.R. The fresh Opus reader found all 8 true but called "divides these coefficients by 3.27" loose. The two divisor sentences now use the manual's term "averaging divisor", and the reader's re-read found them true.
- 2026-09-13: draft-PDF run 34790031099 on 7498aaf, the last commit that changes `paper/`, concluded `success`. The word count is now 1129. Status set to review.
- 2026-09-13: review gate chose to fix D1, D3, and D8 on the branch and reject the other findings with reasons (Review section).
- step-7 approval: m005-incomplete-comparison approved for merge

## Decisions

## Review

Evidence gathered 2026-09-13 on branch head 5978fcb, with intraclass 0.1.0 (CRAN), psych 2.6.5, irr 0.85, and irrICC 1.0 installed. These match the version rows.

- AC1: `Rscript analysis/comparison.R` exited 0, and `git diff --exit-code analysis/comparison-results.csv` exited 0. Each of the 15 names has a `grep -c` count of 1. `irricc_icc2r` and `irricc_abs_diff_ICCA1` each count 0, and `grep -c 'icc2.inter.fn' analysis/comparison.R` printed 0.
- AC2: A separate `Rscript` session that does not source the script built the wide matrices with its own indexing code. It ran `psych::ICC()` and six `intraclass::icc()` fits with the stated arguments, found k with `uniroot()` on the Spearman-Brown formula, and ran `irrICC::icc2.nointer.fn()` on `ratings`. All 15 values equal the committed rows at 6 significant digits. A planted change of `incomplete_psych_ICC1` to 0.115531 made that row and the overall result FALSE.
- AC3: State of the field says psych and intraclass agreed on ICC(A,1) and ICC(C,1), and it names ICC(1), ICC(k), ICC(A,k), and ICC(C,k) as differing. The CSV gaps are 0.000001 and 0 for the agreeing pair, and 0.160, 0.212, 0.050, and 0.024 for the others. The printed divisors are 4 (`incomplete_psych_k` 4.00000, 0 places) and 3.27 (`incomplete_intraclass_k_eff` 3.27273, 2 places). The two divisor sentences name only ICC(k), ICC(A,k), and ICC(C,k) and give no cause for ICC(1). `grep -c` on the removed psych subjects sentence printed 0.
- AC4: `grep -n irrICC paper/paper.md` finds two lines. Only line 67 states a difference between intraclass and irrICC. It names "the random factorial model without subject-rater interaction" and names no model with interaction. Its 0.000006 equals `irricc_nointer_abs_diff_ICCA1` (0.00000625078) rounded to 6 places.
- AC5: Below the front matter the digit grep finds 0.000006, 0.000007, seven 1s, 1979, 2, 20, 2014, 2022, 3.27, seven 4s, and 6. The word grep finds "Four" and "three". 0.000006 is `irricc_nointer_abs_diff_ICCA1`, 0.000007 is `balanced_max_abs_gap`, 3.27 is `incomplete_intraclass_k_eff`, and 4 is `incomplete_psych_k`. 2, 20, and 6 are `incomplete_complete_case_subjects`, `incomplete_intraclass_ratings`, and `incomplete_intraclass_subjects`. 1979, 2014, and 2022 are years. The 1s are ICC(1) twice, ICC(A,1) three times, and ICC(C,1) twice, and six 4s are lme4. "Four" counts four named engines and "three" counts three named functions.
- AC6: The 12 `@` keys in `paper/paper.md` equal the 12 entry keys in `paper/paper.bib`. `pandoc --citeproc` printed no citation warning, but a planted `@nokey` printed "citation nokey not found". `pandoc -t plain | wc -w` reports 1129.
- AC7: `git diff main...HEAD -- paper/paper.md` changes five sentences and removes one. The irrICC sentence matches the irrICC 1.0 `icc2.nointer.fn` manual ("Model 2 without any subject-rater interaction", `icc2r` inter-rater) and the CSV gap. The agreed and differed sentences match the CSV gaps. The psych divisor sentence matches `incomplete_psych_k` 4.00000 and the psych 2.6.5 `ICC` manual ("means of k raters"). Spearman-Brown on the CSV rows gives k of 4.00 for all three averaged psych values. The intraclass sentence matches `incomplete_intraclass_k_eff` and the intraclass 0.1.0 `ratings_incomplete` manual ("averaging divisor", "harmonic mean"). The CSV rows give 3.27 for all three averaged intraclass values. No changed sentence says a package lacks a feature.
- AC8: The manual draft-PDF run 34790358122 on branch head f162a24 concluded `success`. Later commits on the branch change only `cairn/`.
- Consistency gate: `cairn_validate.py` exited 0 with one advisory warning (8 criteria, over the sizing tripwire, as the plan recorded). No principle changed, so `cairn_impact` was skipped. The generic profile names no toolchain checks.
- Independent review: full three-lens fan-out, because the tier is user-facing. The blame-history and prior-review lenses found nothing, and there are no PR review threads. The diff-bug lens reported D1 to D14, ranked, and none makes a criterion fail. Dispositions are set at the approval gate.
- D1 (paper.md:71-72): readers of the divisor sentences see the divisor as the cause of every averaged gap, but most of the ICC(k) gap is the ICC(1) gap.
- D2 (paper.md:71): only ICC2 and ICC2k give `incomplete_psych_k`, and the ICC1/ICC1k and ICC3/ICC3k pairs give 4 only by derivation.
- D3 (comparison.R:162): k is 4.0000000000000009 and prints `4.00000`, and an exact 4 on another platform prints `4` and breaks the rerun diff.
- D4 (paper.md:70): the ICC(1) difference is unexplained, by plan.
- D5 (paper.md:71): "averaging divisor" is the intraclass manual's term, applied to psych.
- D6 (paper.md:71-72): the paper does not say that 4 is the total number of raters.
- D7 (paper.md:72): 3.27 for ICC(k) and ICC(C,k) rests on the manual, not on a results row.
- D8 (paper.md:69): "incomplete `ratings_incomplete`" repeats the word.
- D9 (paper.md:67): the irrICC noun phrase is long.
- D10 (comparison.R:142,145): `psych::ICC(wm_inc)` runs twice.
- D11 (comparison.R:118-127): the irrICC reshape duplicates `to_wide()`, and the code predates the branch.
- D12 (comparison-results.csv): `incomplete_psych_k` sits apart from the psych rows, and its name does not parallel `k_eff`.
- D13 (comparison.R:11-12): the "adapted from the vignette" header may be stale.
- D14 (paper.md:67): the no-interaction value equals the old interaction value. This is a note, not a defect.
- Gate triage 2026-09-13: D1 fix now. The paper adds "For ICC(A,k) and ICC(C,k), whose single-rating values agree, the divisor accounts for the whole gap." Spearman-Brown with 4 and with 3.27273 on psych's single values gives gaps of 0.0497111 and 0.0241762, against actual gaps of 0.049712 and 0.0241762. D3 fix now: the script rounds k to 6 places, so the row reads `4`. D8 fix now: the repeated "incomplete" is removed. D2 and D7 rejected, because the manuals and the committed rows support the claims. D4 rejected, because the plan bars a cause for the ICC(1) gap. D5, D6, D9, and D12 rejected as wording or ordering choices. D10 rejected as a duplicate call with identical results. D11 rejected as predating the branch. D13 rejected, because the script is still adapted from those vignette chunks. D14 noted.
- Re-verification after fixes on 25a10e5: the script reran with no diff, and the independent session matched all 15 rows (`incomplete_psych_k` now `4`). The printed divisor 4 still equals the rounded row. The number and word greps give the same ledger as AC5, and citations give no warning. The word count is 1143. The draft-PDF push run 34793849427 on 25a10e5 concluded `success`. The added sentence names only ICC(A,k) and ICC(C,k) and gives no cause for ICC(1).
