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

- [ ] AC1: For each of psych, irr, irrICC, and performance, the State of the field section of `paper/paper.md` has a sentence that names the package. That sentence or the next sentence gives a reason that intraclass is a separate package and not an addition to that package. A reason is a stated difference in scope, design, or dependencies.
- [ ] AC2: The added lines are the lines that `git diff main...HEAD -- paper/paper.md` shows as added. An added line can name or refer to psych, irr, irrICC, or performance. It then states only facts about that package from one of two sources. The sources are `analysis/comparison-results.csv` at the branch head and the package's own reference manual: psych 2.6.5, irr 0.85, irrICC 1.0, performance 0.17.1. If a line says that one of these packages lacks a feature, the limit must come from manual text or a results-file row. Each statement about intraclass in the added lines matches the intraclass v0.1.0 source or documentation. No added line states contact with, a request to, or a reply from a maintainer of those packages.
- [ ] AC3: Two searches over the AC2 added lines find their numbers. The digit search is `grep -o -E '[<-]?[0-9][0-9.,]*(e-?[0-9]+)?'`. The word search is `grep -o -i -w -E 'one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty'`. Each number is one of these kinds:
  1. a value in `analysis/comparison-results.csv` at the rounding the paper shows
  2. a year or a version number
  3. part of a coefficient label such as ICC(A,1)
  4. a count of items that the same line names
  5. the digit in the package name lme4
  6. the word "one" used as a pronoun, not as a count
- [ ] AC4: `pandoc paper/paper.md -t plain | wc -w` reports between 750 and 1750.
- [ ] AC5: The set of keys from `grep -o -E '@[A-Za-z0-9_:-]+' paper/paper.md` equals the set of entry keys in `paper/paper.bib`. `pandoc paper/paper.md --citeproc --bibliography paper/paper.bib -o /dev/null` exits with status 0 and prints no citation-not-found warning.
- [ ] AC6: A run of the draft-PDF workflow (`.github/workflows/draft-pdf.yml`) on the milestone branch head SHA concludes `success`.

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
