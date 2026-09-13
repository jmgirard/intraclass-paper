# M002: A push that changes the paper builds a JOSS draft PDF

- **Status:** planned
- **Priority:** normal
- **Depends on:** —
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** internal — authoring tooling that only the maintainer uses to see the rendered draft
- **Branch/PR:** —

## Goal

A push that changes `paper/`, or a manual run, builds the JOSS draft PDF of `paper/paper.md` as a GitHub Actions artifact.

## Scope

**In:** the workflow file `.github/workflows/draft-pdf.yml`, a branch run that shows it works, and the matching lines in `cairn/DESIGN.md` (Architecture) and `cairn/PROFILE.md` (`verify`).

**Out:** the paper text and its numbers (M003, M004). Copying `paper/` to the package repository at submission stays in the submission candidate row.

## Acceptance criteria

- [ ] AC1: `.github/workflows/draft-pdf.yml` runs `openjournals/openjournals-draft-action` with `journal: joss` and `paper-path: paper/paper.md`. It uploads `paper/paper.pdf` as an artifact named `paper`. It triggers on `workflow_dispatch` and on pushes that change `paper/**` or the workflow file.
- [ ] AC2: A run of that workflow on the milestone branch head SHA (a push run, or one started with `gh workflow run draft-pdf.yml --ref <branch>`) concludes `success`. `gh run download <run-id> -n paper` retrieves a `paper.pdf`. The output of `pdftotext -raw -l 1 paper.pdf -`, with all whitespace squeezed to single spaces, contains the `title:` value from `paper/paper.md` squeezed the same way.

## Coverage

- AC1 → T1
- AC2 → T2

## Tasks

- [ ] T1: Write `.github/workflows/draft-pdf.yml` from the draft action README (checkout, draft action, upload-artifact), with the `workflow_dispatch` trigger and the `paper/**` and workflow-file path filters.
- [ ] T2: Push the branch, find or start the run on the head SHA, download the artifact, and run the title check. Update the Architecture line in `cairn/DESIGN.md` and the `verify` slot in `cairn/PROFILE.md` to name the workflow and the manual-run command.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the candidate row "Draft-PDF workflow".
- 2026-09-13: criteria audit (reduced mode, fresh Opus reader) returned 2 findings for AC2. A run on a tracking-only head needs a manual trigger, and the wrapped PDF title needs whitespace squeezing. Both were fixed in the wording above.

## Decisions
