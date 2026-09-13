# M002: A push that changes the paper builds a JOSS draft PDF

**Status:** done (2026-09-13, PR #2 https://github.com/jmgirard/intraclass-paper/pull/2)

**Goal:** A push that changes `paper/`, or a manual run, builds the JOSS draft PDF of `paper/paper.md` as a GitHub Actions artifact.

**Outcome:** `.github/workflows/draft-pdf.yml` runs `openjournals/openjournals-draft-action@master` with `journal: joss` and `paper-path: paper/paper.md`. It starts on `workflow_dispatch` and on pushes that change `paper/**` or the workflow file. It uploads `paper/paper.pdf` as the artifact `paper`, with `if-no-files-found: error`, and the job token is `contents: read`. The `cairn/DESIGN.md` Architecture section describes the workflow. The `cairn/PROFILE.md` `verify` slot gives the manual recipe: `gh workflow run`, `gh run list --commit`, `gh run watch`, and `gh run download -n paper`.

**Decisions:** Checkout and upload-artifact are pinned at `@v7`. The draft action stays at `@master`, as its README and JOSS use it.

**Review:** Full three-lens fan-out, because the diff has a workflow file. Both criteria passed on fresh evidence, and the final push run 34779126223 on `e2e5aa3` passed the title check. The blame-history and prior-review lenses found nothing. The diff lens reported 8 low findings. Four were fixed now: F1 (upload passes with no PDF), F3 (no `permissions:` block), F4 (no run-id step), and F5 (branch wording). Four were rejected: F2 (`@master` pin), F6 (tag builds), F7 (no timeout), and F8 (fragile title match). Nothing graduated or retired.
