# M001: The paper has a sourced outline in JOSS's required structure

- **Status:** review
- **Priority:** high
- **Depends on:** —
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the outline is the first form of the public paper
- **Branch/PR:** m001-paper-outline

## Goal

`paper/paper.md` and `paper/paper.bib` hold an outline of the JOSS paper: every required section, a word budget per section, and bullets stating each claim with its source.

## Scope

**In:** YAML front matter for a sole author (Jeffrey Girard, ORCID 0000-0002-7359-3746, University of Kansas). The eight sections JOSS's paper page lists (joss.readthedocs.io/en/latest/paper.html, observed 2026-09-13), each with a word budget and one-line bullets that each end in a `[src: …]` marker. A `paper.bib` holding exactly the entries the outline cites. Sources are the intraclass package repository: `DESCRIPTION`, `README.Rmd`, `vignettes/comparison-with-other-packages.Rmd`, and `cairn/DESIGN.md`. The budget lines and source markers are outline scaffolding and are removed when the prose is drafted.

**Out:**
- Prose drafting, and every number the paper reports → the candidate row "Draft the text from the package's comparison-with-other-packages article".
- The draft-PDF GitHub Action → candidate row "Draft-PDF workflow" (added by this plan).
- Gathering research-impact evidence and submitting → the "Submission" candidate row.

## Acceptance criteria

BODY below means the output of `awk 'f>=2{print} /^---$/&&f<2{f++}' paper/paper.md`, the file after its front matter.

- [x] AC1: `paper/paper.md` has LF line endings and opens with YAML front matter carrying `title`, `tags`, `authors` (each with `name`, or `given-names` and `surname`, plus `orcid` and an `affiliation` index that exists), `affiliations` (each with `name` and `index`), `date`, and `bibliography: paper.bib`, the fields JOSS's paper page lists (joss.readthedocs.io/en/latest/paper.html, observed 2026-09-13).
- [x] AC2: The first non-blank line of BODY is `# Summary`, and the lines of BODY that `grep '^# '` prints are exactly these eight, in this order: `# Summary`, `# Statement of need`, `# State of the field`, `# Software design`, `# Research impact statement`, `# AI usage disclosure`, `# Acknowledgements`, `# References`.
- [x] AC3: Piping BODY through `awk '/^# /{if(s!="")print s": "n" "b; s=$0; n=0; b=0} /^Word budget: [0-9]+$/{n++; t+=$3} /^- /{b++} END{print s": "n" "b; print "total: "t}'` prints, for each of the first seven headings, a budget count of 1 and a bullet count of at least 1, prints `0 0` for `# References`, and prints a total from 750 to 1750.
- [x] AC4: Piping BODY through `grep -vE '^$|^# |^Word budget: [0-9]+$|^- .*\[src: (intraclass/[^] ]+|https?://[^] ]+|@[A-Za-z0-9_:.-]+|maintainer|to gather)\]$'` prints nothing. So every non-blank body line is a heading, a budget line, or a one-line `- ` bullet ending in one source marker: a path in the intraclass repository, a URL, a citation, the maintainer, or evidence still to gather. Each `intraclass/<path>` marker names a file that `git -C ../intraclass cat-file -e 497d617:<path>` finds.
- [x] AC5: The citation keys in BODY (`grep -oE '(^|[-[; ])@[A-Za-z0-9_:.-]+'`, the text after `@` with any trailing `.` or `:` removed, sorted unique) equal the entry keys of `paper/paper.bib` (lines matching `^@[A-Za-z]+[[:space:]]*\{`, less `@comment`, `@string` and `@preamble` in any letter case, the text between `{` and the first `,`, sorted unique), and neither set is empty.
- [x] AC6: By reading: the `# AI usage disclosure` section states that generative AI (Claude Code) was used for the software, the documentation, and the paper, and how their correctness was checked (maintainer review and the package's oracle-verified tests). The `# Research impact statement` section has at least one bullet, and each of its bullets names a kind of evidence and ends in `[src: to gather]`.
- [x] AC7: The citation keys of the `# State of the field` section (its BODY lines up to the next `^# ` line, keys extracted as in AC5) include exactly-matching `psych`, `irr`, `irrICC`, and `performance`, and those of the `# Software design` section include `glmmTMB` and `lme4`.

## Coverage

- AC1 → T1
- AC2 → T2, T3, T4
- AC3 → T2, T3, T4
- AC4 → T2, T3, T4
- AC5 → T2, T3, T5
- AC6 → T4
- AC7 → T2, T3, T5

## Tasks

- [x] T1: Write the front matter of `paper/paper.md`: title, tags, sole author with ORCID and affiliation, date, `bibliography: paper.bib`.
- [x] T2: Outline `# Summary`, `# Statement of need`, and `# State of the field` from the package `DESCRIPTION`, `README.Rmd`, and the comparison article's validation and differentiation sections, citing psych, irr, irrICC, and performance. No numeric results: a bullet that will carry a computed figure names the figure and marks it `[src: to gather]`.
- [x] T3: Outline `# Software design` from the package's `cairn/DESIGN.md` (architecture, engine choice, Monte-Carlo boundary-aware intervals, classed errors), citing glmmTMB and lme4.
- [x] T4: Outline `# Research impact statement` (kinds of evidence, all `to gather`), `# AI usage disclosure` (Claude Code for software, documentation and paper, and how correctness was checked), `# Acknowledgements`, and an empty `# References`. Set the seven word budgets.
- [x] T5: Write `paper/paper.bib` with one entry per cited key, taking each package's citation from its CRAN `citation()` output or reference manual. Run the AC1–AC5 and AC7 commands and summarize their results in one work-log line.

## Work log

- 2026-09-13: created by /milestone-plan. Absorbs the "Paper skeleton" candidate row, less its draft-PDF workflow.
- 2026-09-13: criteria audit (full mode, fresh [O] reader) found YAML list lines failing the bullet check, budgets counted per file, emails matching the citation grep, and PDF artifact evidence that `gh run view` cannot show. Fixed by scoping checks to the body and counting budgets per section.
- 2026-09-13: re-audit of the revised criteria found trailing-dot citation keys, empty sections passing, unchecked `intraclass/` paths, prefix key matches, and CRLF risk. All fixed in the criteria. JOSS's AI section (observed 2026-09-13) also asks how correctness was checked, now in AC6. `performance` added to AC7 because the seed article names it.
- 2026-09-13: plan gate chose outline-only over adding the draft-PDF workflow, by the maintainer's choice. Falsified if outline errors surface only at render time during drafting.
- 2026-09-13: plan gate chose listing research-impact evidence as "to gather" over gathering it now, because gathering belongs to submission timing. Falsified if the other sections depend on that evidence.
- 2026-09-13: implement gate chose the DESCRIPTION-based title, the name Jeffrey M. Girard, today's date to refresh at submission, and four extra citations: intraclass, ten Hove et al. (2022), brms, and lavaan.
- 2026-09-13: T1 done. Front matter written with the given-names and surname author form.
- 2026-09-13: T2 done. Summary, Statement of need, and State of the field outlined from the four named sources. The one computed figure, the largest psych or irr gap, is marked to gather.
- 2026-09-13: T3 done. Software design outlined from the package DESIGN.md, citing glmmTMB, lme4, brms, and lavaan.
- 2026-09-13: T4 done. Research impact (four evidence kinds, all to gather), AI usage disclosure, Acknowledgements, and an empty References outlined. Budgets total 1300 words.
- 2026-09-13: T5 done. paper.bib holds 10 entries from local `citation()` output (first journal entry where several). irrICC's spurious "Ph.D." co-author was dropped, intraclass follows the package's inst/CITATION with CRAN 0.1.0 (published 2026-09-10), and tenhove2022 follows the package BIBLIOGRAPHY.md. The AC1 to AC5 and AC7 commands all pass. The budget total is 1300, all four intraclass paths exist at 497d617, and the two key sets are equal. The AC4 and AC5 greps were shown to catch planted bad lines.
- 2026-09-13: claim audit: 50 claims read, 10 corrected — paper/paper.md, paper/paper.bib
- 2026-09-13: claim-audit corrections: tenhove2022 scoped to multilevel methods and "raters nested" fixed to "subjects nested". One bullet was split to keep one marker each. Four Software design bullets were narrowed to their sources, and the psych note is 2.6.5. The reader's re-read found all ten supported, and an install-check clause that README does not state was dropped. AC3 and AC4 re-run clean, budget total still 1300.
- 2026-09-13: author kept as "Jeffrey M. Girard" by the implement gate. The package inst/CITATION still says "Jeffrey Girard".
- 2026-09-13: status set to review.
- 2026-09-13: review gate triage: F1, F2, F3, F5, and F6 fixed in paper/paper.md, F4 and the vignette error sent to candidate rows, F7 and F8 rejected.
- 2026-09-13: step-7 approval: m001-paper-outline approved for merge

## Decisions

## Review

Evidence gathered 2026-09-13 on branch head eefe6a0; `main` had not moved since the branch was cut.

- AC1: pass. Line 1 is `---`, `file` reports ASCII text, and the file has 0 CR bytes. A YAML parse of the front matter gives the keys affiliations, authors, bibliography, date, tags, and title. The one author has given-names, surname, an ORCID, and affiliation 1, which matches the one affiliation index. `bibliography` is `paper.bib`.
- AC2: pass. The first non-blank BODY line is `# Summary`. `grep '^# '` prints the eight required headings in the required order and no others.
- AC3: pass. The awk command prints budget count 1 for each of the first seven headings, with bullet counts 6, 8, 7, 12, 4, 3, and 1. It prints `0 0` for `# References` and a total of 1300.
- AC4: pass. The grep prints nothing. The four distinct `intraclass/` paths (DESCRIPTION, README.Rmd, cairn/DESIGN.md, vignettes/comparison-with-other-packages.Rmd) all exist at 497d617. Planted lines with no marker, an unlisted marker, or plain prose were printed, and a made-up path failed `cat-file -e`. A planted line with two markers passed the grep. No BODY line has two markers (count 0).
- AC5: pass. BODY gives 10 keys and `paper.bib` gives 10 entry keys, and `diff` of the two sorted lists is empty. The keys are brms, glmmTMB, intraclass, irr, irrICC, lavaan, lme4, performance, psych, and tenhove2022. With planted input, the key grep stripped a trailing `.` or `:` and skipped an email address. The entry grep skipped `@comment` and `@STRING`.
- AC6: pass, by reading. The AI usage disclosure bullets state that Claude Code helped write the software, the documentation, and the paper. They state two correctness checks: maintainer review of every change, and tests against at least two independent oracles. The Research impact statement has 4 bullets. Each names a kind of evidence (CRAN downloads, citing studies, outside user issues, teaching use) and ends in `[src: to gather]`.
- AC7: pass. The `# State of the field` keys are exactly irr, irrICC, performance, and psych. The `# Software design` keys are brms, glmmTMB, lavaan, and lme4, which include glmmTMB and lme4. Keys were compared as whole sorted-unique values, so a prefix does not match.
- Consistency gate: `cairn_validate.py` passed all checks after the ticks, including coverage complete. No principle changed, so `cairn_impact` was skipped. The generic profile names no toolchain checks.
- Independent review: full three-lens fan-out, because the surface tier is user-facing. The [S] blame-history reviewer found nothing. The branch keeps every claim-audit correction, and the ROADMAP candidate rows match `main`. The [S] prior-review reviewer found no archived reviews and no GitHub review threads, so it had zero findings. The [O] diff-bug reviewer re-ran AC1 to AC7 (all pass) and reported the 8 findings below, most severe first. Dispositions are pending at the approval gate.
  - F1: `paper/paper.md` State of the field, "psych [@psych] and irr [@irr] compute the classical ICC family from ANOVA mean squares and assume balanced, complete data." This is false for psych. `psych::ICC` defaults to `lmer = TRUE`. On `ratings_incomplete` it reported `n.obs = 6` and all six coefficients (re-run 2026-09-13, psych 2.6.5). With `lmer = FALSE` it stops on the missing cells. The bullet matches its source, so the package vignette carries the same error.
  - F2: AI usage disclosure, "The maintainer reviewed every change before it reached the default branch." This is not literally true, because tracking commits land on the default branch directly.
  - F3: Summary, "Every coefficient comes with a boundary-aware Monte-Carlo confidence interval." The brms engine uses posterior intervals, and bootstrap intervals are selectable. Only the default interval is Monte-Carlo.
  - F4: State of the field, "intraclass's ICC(A,1) reproduces the two-way random agreement coefficient of irrICC." This numeric-agreement claim has no committed script or test behind it.
  - F5: State of the field, "A capability matrix contrasts the four packages". The section cites performance, but the matrix covers psych, irr, irrICC, and intraclass.
  - F6: Software design and AI usage disclosure, "at least two independent oracles". The package DESIGN.md says two oracle types, and the brms oracle runs offline against committed fixtures.
  - F7: `paper/paper.bib` intraclass author "Jeffrey M. Girard" differs from the package `inst/CITATION` "Jeffrey Girard". The implement gate chose this, and the work log records it.
  - F8: `paper/paper.bib` psych note says 2.6.5, but `citation("psych")` prints 2.6.4. The installed version is 2.6.5, so the bib is correct.
- Triage (maintainer, 2026-09-13):
  - F1: fixed now. The bullet is split: irr keeps the vignette claim, and psych cites its ICC help page, which says `lmer` is the default and allows missing data. A follow-up candidate row covers the vignette.
  - F2, F3, F5, F6: fixed now. The disclosure says each milestone and bug fix was reviewed before merge. The Summary names the Monte-Carlo interval as the default. The matrix bullet names its four packages. Both oracle bullets say types of oracle.
  - F4: follow-up. The claim is added to the existing drafting candidate row.
  - F7, F8: rejected. The name form is a logged implement-gate choice, and the bib's psych version is the installed one.
- Re-check after the fixes: AC3 prints bullet counts 6, 8, 8, 12, 4, 3, 1, then `0 0`, and total 1300. The AC4 grep prints nothing, with no two-marker lines. The new psych URL returns HTTP 200. The AC5 key sets stay equal at 10 keys, and the AC7 section keys are unchanged. The file is still ASCII with LF endings.
