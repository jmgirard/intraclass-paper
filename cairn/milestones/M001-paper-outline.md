# M001: The paper has a sourced outline in JOSS's required structure

- **Status:** planned
- **Priority:** high
- **Depends on:** —
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** user-facing — the outline is the first form of the public paper
- **Branch/PR:** —

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

- [ ] AC1: `paper/paper.md` has LF line endings and opens with YAML front matter carrying `title`, `tags`, `authors` (each with `name`, or `given-names` and `surname`, plus `orcid` and an `affiliation` index that exists), `affiliations` (each with `name` and `index`), `date`, and `bibliography: paper.bib`, the fields JOSS's paper page lists (joss.readthedocs.io/en/latest/paper.html, observed 2026-09-13).
- [ ] AC2: The first non-blank line of BODY is `# Summary`, and the lines of BODY that `grep '^# '` prints are exactly these eight, in this order: `# Summary`, `# Statement of need`, `# State of the field`, `# Software design`, `# Research impact statement`, `# AI usage disclosure`, `# Acknowledgements`, `# References`.
- [ ] AC3: Piping BODY through `awk '/^# /{if(s!="")print s": "n" "b; s=$0; n=0; b=0} /^Word budget: [0-9]+$/{n++; t+=$3} /^- /{b++} END{print s": "n" "b; print "total: "t}'` prints, for each of the first seven headings, a budget count of 1 and a bullet count of at least 1, prints `0 0` for `# References`, and prints a total from 750 to 1750.
- [ ] AC4: Piping BODY through `grep -vE '^$|^# |^Word budget: [0-9]+$|^- .*\[src: (intraclass/[^] ]+|https?://[^] ]+|@[A-Za-z0-9_:.-]+|maintainer|to gather)\]$'` prints nothing. So every non-blank body line is a heading, a budget line, or a one-line `- ` bullet ending in one source marker: a path in the intraclass repository, a URL, a citation, the maintainer, or evidence still to gather. Each `intraclass/<path>` marker names a file that `git -C ../intraclass cat-file -e 497d617:<path>` finds.
- [ ] AC5: The citation keys in BODY (`grep -oE '(^|[-[; ])@[A-Za-z0-9_:.-]+'`, the text after `@` with any trailing `.` or `:` removed, sorted unique) equal the entry keys of `paper/paper.bib` (lines matching `^@[A-Za-z]+[[:space:]]*\{`, less `@comment`, `@string` and `@preamble` in any letter case, the text between `{` and the first `,`, sorted unique), and neither set is empty.
- [ ] AC6: By reading: the `# AI usage disclosure` section states that generative AI (Claude Code) was used for the software, the documentation, and the paper, and how their correctness was checked (maintainer review and the package's oracle-verified tests). The `# Research impact statement` section has at least one bullet, and each of its bullets names a kind of evidence and ends in `[src: to gather]`.
- [ ] AC7: The citation keys of the `# State of the field` section (its BODY lines up to the next `^# ` line, keys extracted as in AC5) include exactly-matching `psych`, `irr`, `irrICC`, and `performance`, and those of the `# Software design` section include `glmmTMB` and `lme4`.

## Coverage

- AC1 → T1
- AC2 → T2, T3, T4
- AC3 → T2, T3, T4
- AC4 → T2, T3, T4
- AC5 → T2, T3, T5
- AC6 → T4
- AC7 → T2, T3, T5

## Tasks

- [ ] T1: Write the front matter of `paper/paper.md`: title, tags, sole author with ORCID and affiliation, date, `bibliography: paper.bib`.
- [ ] T2: Outline `# Summary`, `# Statement of need`, and `# State of the field` from the package `DESCRIPTION`, `README.Rmd`, and the comparison article's validation and differentiation sections, citing psych, irr, irrICC, and performance. No numeric results: a bullet that will carry a computed figure names the figure and marks it `[src: to gather]`.
- [ ] T3: Outline `# Software design` from the package's `cairn/DESIGN.md` (architecture, engine choice, Monte-Carlo boundary-aware intervals, classed errors), citing glmmTMB and lme4.
- [ ] T4: Outline `# Research impact statement` (kinds of evidence, all `to gather`), `# AI usage disclosure` (Claude Code for software, documentation and paper, and how correctness was checked), `# Acknowledgements`, and an empty `# References`. Set the seven word budgets.
- [ ] T5: Write `paper/paper.bib` with one entry per cited key, taking each package's citation from its CRAN `citation()` output or reference manual. Run the AC1–AC5 and AC7 commands and summarize their results in one work-log line.

## Work log

- 2026-09-13: created by /milestone-plan. Absorbs the "Paper skeleton" candidate row, less its draft-PDF workflow.
- 2026-09-13: criteria audit (full mode, fresh [O] reader) found YAML list lines failing the bullet check, budgets counted per file, emails matching the citation grep, and PDF artifact evidence that `gh run view` cannot show. Fixed by scoping checks to the body and counting budgets per section.
- 2026-09-13: re-audit of the revised criteria found trailing-dot citation keys, empty sections passing, unchecked `intraclass/` paths, prefix key matches, and CRLF risk. All fixed in the criteria. JOSS's AI section (observed 2026-09-13) also asks how correctness was checked, now in AC6. `performance` added to AC7 because the seed article names it.
- 2026-09-13: plan gate chose outline-only over adding the draft-PDF workflow, by the maintainer's choice. Falsified if outline errors surface only at render time during drafting.
- 2026-09-13: plan gate chose listing research-impact evidence as "to gather" over gathering it now, because gathering belongs to submission timing. Falsified if the other sections depend on that evidence.

## Decisions

## Review
