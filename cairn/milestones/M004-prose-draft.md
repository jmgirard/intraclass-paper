# M004: The paper is drafted as prose within JOSS's length limit

- **Status:** in-progress
- **Priority:** normal
- **Depends on:** M002, M003
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the text that is submitted to JOSS and published there
- **Branch/PR:** m004-prose-draft

## Goal

`paper/paper.md` holds finished prose for every section except the Research impact statement, within 750 to 1750 words.

## Scope

**In:** prose for Summary, Statement of need, State of the field, Software design, AI usage disclosure, and Acknowledgements. The maintainer gives the acknowledgements text at this milestone's start gate. The outline scaffolding is removed outside Research impact, and `paper/paper.bib` is kept in step with the citations.

**Out:** Research impact evidence and prose, which stay in the submission candidate row. New comparison figures go through M003's script or a new milestone. The package vignette's psych claim is fixed in `jmgirard/intraclass` (candidate row).

## Acceptance criteria

- [ ] AC1: `awk '/^# Research impact statement/{s=1;next} /^# /{s=0} !s' paper/paper.md | grep -n -E '\[src:|^Word budget:'` prints nothing. The Acknowledgements section has no line that starts with `- `.
- [ ] AC2: `pandoc paper/paper.md -t plain | wc -w` reports between 750 and 1750. This count includes headings and excludes the front matter and the reference list.
- [ ] AC3: Below the front matter of `paper/paper.md`, each number found by `grep -o -E '[<-]?[0-9][0-9.,]*(e-?[0-9]+)?'` or by `grep -o -i -w -E 'one|two|three|four|five|six|seven|eight|nine|ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen|twenty'` is one of these: a value in `analysis/comparison-results.csv` at the rounding the paper shows, a year, a version number, part of a coefficient label such as ICC(A,1), a count of items that the same sentence names, part of an author name ("ten Hove"), or the digit in the package name lme4 wherever that name appears, including code spans and the `@lme4` citation key.
- [ ] AC4: The set of keys from `grep -o -E '@[A-Za-z0-9_:-]+' paper/paper.md` equals the set of entry keys in `paper/paper.bib`. `pandoc paper/paper.md --citeproc --bibliography paper/paper.bib -o /dev/null` prints no citation-not-found warning.
- [ ] AC5: Each sentence in the Statement of need and State of the field sections that describes the behavior of psych, irr, irrICC, or performance, or that recommends one of them, states, for each of those packages it names, only behavior that `analysis/comparison-results.csv` at the branch head shows or that the package's own reference manual documents. For psych, irr, and irrICC, the manual is the one for the version recorded in that file. For performance, it is the one for version 0.17.1. A sentence that says one of these packages lacks a feature passes only if that manual states the limit in words.
- [ ] AC6: A run of the draft-PDF workflow on the milestone branch head SHA concludes `success`.

## Coverage

- AC1 → T2, T3
- AC2 → T2, T4
- AC3 → T2, T4
- AC4 → T4
- AC5 → T2, T4
- AC6 → T5

## Tasks

- [x] T1: At the start gate, get the acknowledgements text (people and funding) from the maintainer.
- [x] T2: Turn the outline bullets of Summary, Statement of need, State of the field, and Software design into prose. Take each figure from `analysis/comparison-results.csv`, and run any function whose behavior a sentence states (M001 lesson).
- [x] T3: Write the AI usage disclosure and Acknowledgements prose, and delete the `Word budget:` lines and `[src:]` markers outside Research impact.
- [x] T4: Run the word count, the number greps, and the citation key comparison, and fix what they find. Record the number classification for review in the work log.
- [ ] T5: Push the branch and confirm the draft-PDF run on the head SHA.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the prose half of the candidate row "Draft the text from the package's comparison-with-other-packages article".
- 2026-09-13: criteria audit (full mode, fresh Opus reader) returned 8 findings. The section exclusion had no procedure, the placeholder text had no rule, the word count was undefined, the number grep missed number words and scientific notation, the number exemption was open, the bib check had no procedure, the package-claim check read lines instead of sentences, the manual version was not pinned, and the workflow trigger was missing. All were fixed in the wording above, and the gate settled the three judgment calls.
- 2026-09-13: plan gate chose to leave Research impact for the submission milestone over drafting it now, because its evidence (downloads, citations) is new data that the submission row already owns. Falsified by JOSS requiring that section in the pre-submission draft.
- 2026-09-13: plan gate chose a closed number exemption list over no exemptions, because counts such as "four engines" have no script source. Falsified by a number in the exempt classes that a reader cannot check against a named source.
- 2026-09-13: implement started on branch m004-prose-draft, cut from main at 275def3.
- 2026-09-13: start gate: no funding and no people to acknowledge. Performance is pinned at 0.17.1 through an AC5 amendment. Gaps are stated as rounded CSV values, not as the bound that the M003 review candidate row suggests. The AI disclosure covers package code, tests, documentation, and paper. T1 done.
- 2026-09-13: amendment: AC5 as planned blocked every performance sentence, because the CSV records no performance version. User chose to pin performance 0.17.1.
- re-audit: AC5 (full) — referent unclear for sentences naming several packages, "lacks a feature" claims unruled, performance version recorded only in the criterion, opinion sentences unclear. Wording revised for the first two, and the last two carried to the second reader.
- re-audit: AC5 (full) — recommendations unclear as claims, "states the limit" vague, CSV copy unpinned, pin to be recorded in Decisions. All four fixed in the adopted wording at the mini gate (stop reached, user adopted).
- 2026-09-13: amendment: AC3 as planned failed any mention of lme4, because its digit fits no exempt class. User adopted an lme4 exemption at the mini gate.
- re-audit: AC3 (full) — "in prose or in its citation key" left out code spans. Wording revised to "wherever that name appears, including code spans".
- re-audit: AC3 (full) — S3, one-way, two-way, and pronoun "one" still uncovered, grep hits carry no line numbers. Not adopted, because the draft avoids those words (stop reached, user adopted the lme4 wording).
- 2026-09-13: T2 and T3 landed in one commit, because both write the same file. Prose written from same-session reads: the installed manuals of psych 2.6.5, irr 0.85, irrICC 1.0, and performance 0.17.1, the intraclass 0.1.0 DESCRIPTION, README, and DESIGN, and runs of `icc()`, `d_study()`, `choose_icc()`, `irr::icc()` on incomplete data (listwise, 2 subjects), and a disconnected design (`intraclass_unidentified`).
- 2026-09-13: T4: words 1052 (pandoc plain). AC1 awk/grep empty, and no `- ` line in Acknowledgements. 10 citation keys equal the bib keys, no citeproc warning, and a planted `@lavaanX` key did raise one. The number grep flagged "Word budget: 150" in Research impact (AC3 covers that section), so that line was removed, and "agree with these packages" was narrowed to psych, irr, and irrICC, because performance has no comparison value.
- 2026-09-13: T4 number ledger (below front matter): 2022 year (@tenhove2022). 2 = incomplete_complete_case_subjects. 20 = incomplete_intraclass_ratings. 6 (line with 20) = incomplete_intraclass_subjects. 6 (psych sentence) = incomplete_psych_subjects. 0.000007 = balanced_max_abs_gap 0.00000715543 at one significant digit. 0.000006 = irricc_abs_diff_ICCA1 0.00000625078 at one significant digit. Each 1 is in an ICC(1), ICC(A,1), or ICC(C,1) label. Each 4 is the lme4 digit (prose, `@lme4`). "three" counts `icc()`, `d_study()`, `choose_icc()` named in its sentence. "Four" counts glmmTMB, lme4, brms, lavaan named in its sentence.
- 2026-09-13: T4 AC5 ledger: irr listwise omission (both sections) and agreement/consistency for single/average ratings = irr 0.85 manual `icc` Details and arguments. psych Shrout and Fleiss ICCs with confidence limits, `lmer()` default that handles missing data = psych 2.6.5 manual `ICC`. psych used 6 subjects = CSV. irrICC inter- and intra-rater ICCs from Gwet's handbook under ANOVA models = irrICC 1.0 package description and `icc2.inter.fn`. performance ICC also called variance partition coefficient from a fitted mixed model = performance 0.17.1 manual `icc`. Agreement figures = CSV. "psych and irr remain direct choices" for balanced complete classical designs = the irr and psych manuals above.

## Decisions

- 2026-09-13 (implement): Claims about performance rest on the reference manual of version 0.17.1, the version installed when the prose was drafted. The comparison results file records no performance version, and the paper cites performance through its 2021 JOSS article, which names no version.
