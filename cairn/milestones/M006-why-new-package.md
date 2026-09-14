<!-- Section ownership + write-modes: see tracking-rules.md "Milestone-file
     section ownership". A phase skill never rewrites another phase's section. -->
# M006: State of the field says why intraclass is a new package

- **Status:** review
- **Priority:** normal
- **Depends on:** —
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the JOSS paper text that reviewers and readers read
- **Branch/PR:** m006-why-new-package

## Goal

The State of the field section of `paper/paper.md` says why intraclass is a separate package and not a contribution to psych, irr, irrICC, or performance.

## Scope

**In:** One justification in State of the field, near `paper/paper.md:75-76`. If related tools exist, the JOSS review criteria require a "build vs. contribute" justification. It covers the unique scholarly contribution, why existing alternatives are insufficient, and what gap the software fills. The session drafts the reasons from differences that the manuals and the intraclass source show. The maintainer approves or changes the reason wording at the review gate. The paper states no contact with maintainers of other packages, because none happened. If a reason needs a new citation, its bib entry is in scope.

**Out:** New rows in `analysis/comparison.R` to back a limit claim. The gate chose manual text or existing rows, and a needed new row goes to a candidate row. The psych claim in the intraclass comparison vignette stays with its candidate row, and the fix lands in `jmgirard/intraclass`. The irr listwise-deletion re-check stays with its candidate row. Research impact evidence stays with the submission candidate row.

## Acceptance criteria

- [x] AC1: For each of psych, irr, irrICC, and performance, the State of the field section of `paper/paper.md` has a sentence that names the package. That sentence or the next sentence gives a reason that intraclass is a separate package and not an addition to that package. A reason is a stated difference in scope, design, or dependencies.
- [x] AC2: The added lines are the lines that `git diff main...HEAD -- paper/paper.md` shows as added. An added line can name or refer to psych, irr, irrICC, or performance. It then states only facts about that package from one of two sources. The sources are `analysis/comparison-results.csv` at the branch head and the package's own reference manual: psych 2.6.5, irr 0.85, irrICC 1.0, performance 0.17.1. If a line says that one of these packages lacks a feature, the limit must come from manual text or a results-file row. Each statement about intraclass in the added lines matches the intraclass v0.1.0 source or documentation. No added line states contact with, a request to, or a reply from a maintainer of those packages.
- [x] AC3: Two searches over the AC2 added lines find their numbers. The digit search is `grep -o -E '[<-]?[0-9][0-9.,]*(e-?[0-9]+)?'`. The word search is `grep -o -i -w -E 'one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty'`. Each number is one of these kinds:
  1. a value in `analysis/comparison-results.csv` at the rounding the paper shows
  2. a year or a version number
  3. part of a coefficient label such as ICC(A,1)
  4. a count of items that the same line names
  5. the digit in the package name lme4
  6. the word "one" used as a pronoun, not as a count
- [x] AC4: `pandoc paper/paper.md -t plain | wc -w` reports between 750 and 1750.
- [x] AC5: The set of keys from `grep -o -E '@[A-Za-z0-9_:-]+' paper/paper.md` equals the set of entry keys in `paper/paper.bib`. `pandoc paper/paper.md --citeproc --bibliography paper/paper.bib -o /dev/null` exits with status 0 and prints no citation-not-found warning.
- [x] AC6: A run of the draft-PDF workflow (`.github/workflows/draft-pdf.yml`) on the milestone branch head SHA concludes `success`.

## Coverage

- AC1 → T2, T3
- AC2 → T1, T2, T3
- AC3 → T2, T3
- AC4 → T2, T4
- AC5 → T2, T4
- AC6 → T4

## Tasks

- [x] T1: Read the reference manuals of psych 2.6.5, irr 0.85, irrICC 1.0, and performance 0.17.1 and the intraclass v0.1.0 source. Find the facts that each reason rests on, and log the source of each fact.
- [x] T2: Write the justification into State of the field, near `paper/paper.md:75-76`. When a new citation is needed, add its entry to `paper/paper.bib`.
- [x] T3: A fresh-context reader audits every added line against AC1, AC2, and AC3. Fix what it finds.
- [x] T4: Run the word count and the citation check, push, and run the draft-PDF workflow.

## Work log

- 2026-09-13: created by /milestone-plan. The scope comes from the candidate row from M004 review F4, which named psych and irr only.
- 2026-09-13: criteria audit, full mode, by a fresh reader. It returned 8 findings, and 5 were fixed. AC1 got the next-sentence allowance and the reason definition. AC2 got facts of any kind and unnamed references. AC3 got "one" as a pronoun, and AC5 got the exit status. The limit-claim bar and package coverage went to the gate.
- 2026-09-13: plan gate chose drafted reasons from documented differences over reasons the maintainer supplies now. The differences can be checked against the manuals, and the maintainer approves the wording at review. Falsified by: the maintainer rejects the drafted reasons as not their own.
- 2026-09-13: plan gate chose a reason for all four packages over psych and irr only. The JOSS criterion covers every related tool that the section names. Falsified by: a JOSS reviewer or guide text limits the justification to the closest alternatives.
- 2026-09-13: plan gate chose limit claims from manual text or existing results rows over new comparison-script rows. Most reasons can be stated as what each package does. Falsified by: a reason needs a limit that no manual states and no existing row shows.
- 2026-09-13: implement started on branch m006-why-new-package. No implementation choice was open, so the question gate was skipped.
- 2026-09-13: T1 sources. psych 2.6.5: DESCRIPTION (general purpose toolbox for personality, psychometric theory, and experimental psychology). psych `ICC`: x is a matrix or data frame of ratings, rows subjects and columns raters. irr 0.85: DESCRIPTION (Title, data types, Depends lpSolve, no Imports) and `icc` (n*m matrix). irrICC 1.0: help titles (coefficients and mean squares under ANOVA models of Gwet 2014). performance 0.17.1: DESCRIPTION (model-quality measures for many regression models) and `icc` (model argument is a fitted mixed model). intraclass v0.1.0: DESCRIPTION Imports glmmTMB. Its `icc` Rd says data has one rating per row and a `cluster` column gives the multilevel ICC.
- 2026-09-13: T2 added an 8-line paragraph after the `ratings_incomplete` paragraph of State of the field. No new citation was needed. The paper is 1292 words by `pandoc -t plain`.
- 2026-09-13: T3 fresh [O] reader audited the added lines against AC1 to AC3. It found one overstated claim: only the default engine was said to need glmmTMB, but intraclass imports it. The line was fixed. Advisory wording was also applied: the cluster sentence, "by default" for mixed models, and a scope clause for performance, split into two lines. The same reader re-read the 4 changed claims once, and all are supported. The paper is 1299 words.
- 2026-09-13: claim audit: 13 claims read, 1 corrected (paper/paper.md). This was run in the same T3 reader pass.
- 2026-09-13: T4 results. `pandoc -t plain` counts 1299 words. The citation key sets are equal, and `pandoc --citeproc` exits 0 with no citation warning. Draft-PDF run 34795519804 on d631aae concluded success, and the PDF contains the new paragraph. The completion commit changes only `cairn/`, so it starts no workflow run. Review must start a run by hand on the final head for AC6.
- 2026-09-13: all tasks done, status set to review.

## Decisions

## Review

Evidence gathered 2026-09-13 on branch head 556d1e6, with psych 2.6.5, irr 0.85, irrICC 1.0, performance 0.17.1, and intraclass 0.1.0 installed. These match the versions the criteria name.

- AC1: Line 2 of the added paragraph names psych. Line 3 gives the reason: a column per rater against one rating per row. Line 5 names irr, and line 6 gives the reason: lpSolve only against glmmTMB. Line 7 names irrICC and gives the reason: analysis-of-variance models against mixed models by default. Line 8 names performance. Lines 8 and 9 give the reason: a model the user fitted against a model fitted from the stated design.
- AC2: `git diff main...HEAD -- paper/paper.md` shows 9 added lines. Each package fact was read in the installed manual. psych DESCRIPTION says "general purpose toolbox developed originally for personality, psychometric theory and experimental psychology". The psych `ICC` Details lay data out in rows (subjects) and columns (raters). irr DESCRIPTION lists the three data types, Depends lpSolve, and has no Imports. Every irrICC help title names an ANOVA model. performance DESCRIPTION says "measures to assess model quality" for "a large variety of regression models". Its `icc` argument `model` is a fitted mixed effects model. The intraclass 0.1.0 DESCRIPTION imports glmmTMB and names linear mixed models. Its `icc` Rd says `data` has one rating per row, `engine` defaults to glmmTMB, and a `cluster` column switches on the multilevel ICC. No added line says a package lacks a feature. The irr line says glmmTMB is a dependency irr does not have, and the irr DESCRIPTION shows this. No added line matches contact, maintainer, request, or reply.
- AC3: The digit search finds no match in the 9 added lines. The word search finds one match, "one" in "one rating per row" on line 3. It counts ratings, an item that the same line names (kind 4).
- AC4: `pandoc paper/paper.md -t plain | wc -w` reports 1299.
- AC5: The 12 `@` keys in `paper/paper.md` equal the 12 entry keys in `paper/paper.bib`. `pandoc --citeproc` exited 0 and printed only the output-format warning, with no citation warning. A planted `@nokey` printed "citation nokey not found".
- AC6: The manual draft-PDF run 34796922107 on branch head 556d1e6 concluded `success`. Later review commits on the branch change only `cairn/`.
- Consistency gate: `cairn_validate.py` exited 0 with all checks passed. No principle changed, so `cairn_impact` was skipped. The generic profile names no toolchain checks.
- Independent review: full three-lens fan-out, because the tier is user-facing. No finding shows a criterion failing. There are no PR review threads. Dispositions are set at the approval gate.
- D1 (paper.md:77-78): the psych reason is only wide against long data, but psych 2.6.5 exports `mlr()` and `multilevel.reliability()`, which take long data and compute multilevel reliability.
- D2 (paper.md:75-83): the lines state differences but not why a difference rules out a contribution, for example a new dependency or a changed interface.
- D3 (paper.md:75-85): the strongest reasons are in the next paragraph (line 85), which is not tied back to the build-vs-contribute case.
- D4 (paper.md:82): repeats line 63, that performance works from a model the user fitted.
- D5 (paper.md:81): repeats line 61, that irrICC works under analysis-of-variance models.
- D6 (paper.md:80): glmmTMB is named without a citation, and lines 96-97 repeat that intraclass imports it.
- D7 (AC3): "one rating per row" passes only under kind 4, and a strict audit can read the criterion otherwise.
- D8 (paper.md:81): "by default ... with mixed models" holds for the default engine, and the lavaan engine fits structural-equation models.
- D9 (paper.md:75): "these packages" points back to lines 57-63, two paragraphs earlier.
- D10 (paper.md:79): "depends only on lpSolve" rests on DESCRIPTION metadata, not help-page text.
- D11 (paper.md:79): the irr sentence does not connect irr's scope to its listwise deletion, the ICC difference the paper reports.
- B1 (paper.md:76): the reviewer asked whether "first developed for" adds history beyond the source. The psych DESCRIPTION says "developed originally for", so the claim is supported.
- B2 (paper.md:82): "many kinds of regression models" sits next to a breadth claim that M004 cut. The performance DESCRIPTION says "a large variety of regression models", so the claim is supported.
- B3 (paper.md:75-87): the new paragraph and the M004 closing paragraph both argue how intraclass differs, which reads as two conclusions.
- P1 (M004 F4): the paragraph is the follow-up that F4 asked for. Noted.
- P2 (M004 F14/H1): the irr dependency line is close to a lack claim, and the irr DESCRIPTION supports it. Noted.
- P3 (M004 AC5): the new package claims need a manual audit. T3 and the AC2 evidence above did this audit. Noted.
- Gate triage 2026-09-13: the maintainer chose revise, then re-ask. D1, D2, D3, D4, D5, D9, and B3 fix now. The justification now opens from the closing paragraph's list of what intraclass brings together. It names each package and gives psych a scope reason from the `mlr()` manual. The irrICC and performance reasons do not repeat lines 61 and 63. D6 fix now in part: glmmTMB is cited at its first mention, and line 98 still says it is the only engine that intraclass imports. D7 noted, because kind 4 covers "one rating per row". D8 rejected, because the irrICC line no longer claims mixed models. D10 rejected, because the reference manual reproduces the DESCRIPTION fields. D11 rejected, because listwise deletion is on line 58 and needs no repeat. B1 and B2 rejected, because the manuals support both claims.
- Fresh audit of the revision on bc1660b by a new [O] reader. A1: line 76 said that all three parts share a rating data frame. The `choose_icc()` manual says it has no `data` argument. A2, psych `ICC()` also takes a data frame. A3, `mlr()` also takes long data and can compute ICCs. A4, "depends on glmmTMB" differs from the Imports field. A5, the glmmTMB citation and import fact repeat lines 97-98. A6, "subjects nested in clusters" repeats line 50. A7, "instead" has no clear point of contrast. A1, A2, A4, and A7 fix now on b9e00be. The interface claim names only `icc()`. The psych contrast is a column per rater against one rating per row. The glmmTMB line says "imports". A3 rejected, because the paper says only what `mlr()` is for and claims no psych limit. A5 and A6 noted as small repeats.
- Re-verification on b9e00be: the diff adds 10 lines. AC1: psych is named on line 2 with the reason on line 3. irr is named on line 6 with the reason on line 7. irrICC is named on line 8 with the reason in the same sentence. performance is named on line 9 with the reason on line 10. AC2: line 4 matches the psych `multilevel.reliability` Description. Line 5 matches the intraclass `cluster` argument. Line 8 matches the irrICC function list, which has one function per ANOVA model. Line 9 matches the performance DESCRIPTION. No line matches contact, maintainer, request, or reply. AC3: no digits, and the only number word is "one" in "one rating per row" on line 3 (kind 4). AC4: 1330 words. AC5: the 12 keys still match, and `pandoc --citeproc` exits 0 with no citation warning. AC6: the push run 34797314284 on b9e00be concluded `success`.
