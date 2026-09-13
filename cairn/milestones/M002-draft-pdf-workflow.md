# M002: A push that changes the paper builds a JOSS draft PDF

- **Status:** review
- **Priority:** normal
- **Depends on:** —
- **Driving RR:** —
- **Principles touched:** —
- **Resolves:** —
- **Surface tier:** internal — authoring tooling that only the maintainer uses to see the rendered draft
- **Branch/PR:** `m002-draft-pdf-workflow`

## Goal

A push that changes `paper/`, or a manual run, builds the JOSS draft PDF of `paper/paper.md` as a GitHub Actions artifact.

## Scope

**In:** the workflow file `.github/workflows/draft-pdf.yml`, a branch run that shows it works, and the matching lines in `cairn/DESIGN.md` (Architecture) and `cairn/PROFILE.md` (`verify`).

**Out:** the paper text and its numbers (M003, M004). Copying `paper/` to the package repository at submission stays in the submission candidate row.

## Acceptance criteria

- [x] AC1: `.github/workflows/draft-pdf.yml` runs `openjournals/openjournals-draft-action` with `journal: joss` and `paper-path: paper/paper.md`. It uploads `paper/paper.pdf` as an artifact named `paper`. It triggers on `workflow_dispatch` and on pushes that change `paper/**` or the workflow file.
- [x] AC2: A run of that workflow on the milestone branch head SHA (a push run, or one started with `gh workflow run draft-pdf.yml --ref <branch>`) concludes `success`. `gh run download <run-id> -n paper` retrieves a `paper.pdf`. The output of `pdftotext -raw -l 1 paper.pdf -`, with all whitespace squeezed to single spaces, contains the `title:` value from `paper/paper.md` squeezed the same way.

## Coverage

- AC1 → T1
- AC2 → T2

## Tasks

- [x] T1: Write `.github/workflows/draft-pdf.yml` from the draft action README (checkout, draft action, upload-artifact), with the `workflow_dispatch` trigger and the `paper/**` and workflow-file path filters.
- [x] T2: Push the branch, find or start the run on the head SHA, download the artifact, and run the title check. Update the Architecture line in `cairn/DESIGN.md` and the `verify` slot in `cairn/PROFILE.md` to name the workflow and the manual-run command.

## Work log

- 2026-09-13: created by /milestone-plan. It absorbs the candidate row "Draft-PDF workflow".
- 2026-09-13: criteria audit (reduced mode, fresh Opus reader) returned 2 findings for AC2. A run on a tracking-only head needs a manual trigger, and the wrapped PDF title needs whitespace squeezing. Both were fixed in the wording above.
- 2026-09-13: implement started on branch `m002-draft-pdf-workflow`. Question gate skipped because nothing was open.
- 2026-09-13: T1 done. The workflow follows the action README, with checkout and upload-artifact at `@v7` and the draft action at `@master`.
- 2026-09-13: T2 push run 34778514375 on `da1e155` concluded success. Manual run 34778562793 on `566c359` concluded success, and its `paper` artifact held `paper.pdf`.
- 2026-09-13: T2 title check passed with `-raw`, and the title with `XYZ` appended failed. A first FAIL came from a trailing space in my title extraction, not from the PDF.
- 2026-09-13: T2 note for review: the match comes from the one-line citation block on page 1. The heading copy of the title has margin line number `1` inside it.
- 2026-09-13: T2 done. DESIGN Architecture and the PROFILE `verify` slot name the workflow and the manual-run command.
- claim audit: not owed — internal tier
- 2026-09-13: implement complete, status set to review.

## Decisions

## Review

- Sync: `origin/main` is `db5b480`, the branch merge base. The default branch did not move, so no merge was needed.
- AC1 evidence (2026-09-13): a YAML parse of `.github/workflows/draft-pdf.yml` shows the triggers `workflow_dispatch` and `push` with paths `paper/**` and `.github/workflows/draft-pdf.yml`. The steps are checkout, `openjournals/openjournals-draft-action@master` with `journal: joss` and `paper-path: paper/paper.md`, and `upload-artifact` with `name: paper` and `path: paper/paper.pdf`. PASS.
- AC2 evidence (2026-09-13): manual run 34778819323 on head `8365aad` concluded `success`. `gh run download 34778819323 -n paper` retrieved `paper.pdf` (211150 bytes). The squeezed `pdftotext -raw -l 1` output contains the squeezed title "intraclass: Modern intraclass correlation coefficients for interrater reliability in R". The same title with `XYZ` appended does not match. PASS. The later review commits change only `cairn/`, so the built files are the same at the merged head.
- Consistency gate (2026-09-13): `cairn_validate.py` exit 0, all checks passed. No principle changed, so `cairn_impact` was skipped. The `generic` profile names no toolchain checks.
- Independent review (2026-09-13): the diff touches a workflow file, so all three lenses ran. The history lens and the prior-review lens found nothing. The diff lens found no criterion failure and reported 8 low findings, ranked:
  - F1: `draft-pdf.yml:23-26` leaves `if-no-files-found` at `warn`, so a run with no PDF still ends green.
  - F2: `draft-pdf.yml:18` uses the draft action at `@master`, which pulls `inara:latest`, so the same commit can render differently later.
  - F3: the workflow has no `permissions:` block. If the repo setting changes to read/write, the job gets a write token.
  - F4: the PROFILE `verify` recipe does not say how to find the run id after `gh workflow run`, so a reader can download an older run.
  - F5: DESIGN says a manual run starts "on any branch", but it only works on a branch that holds the workflow file.
  - F6: tag pushes ignore the `paths` filter, so each release tag starts one build.
  - F7: no `concurrency` or `timeout-minutes`, so quick pushes each build and a hung build runs up to 6 hours.
  - F8: the AC2 title match comes from the page-1 citation block. If the template changes, the check can fail on a good PDF.
- Triage: none of the findings shows a criterion failing, so the return floor does not apply. Dispositions are set at the approval gate.
