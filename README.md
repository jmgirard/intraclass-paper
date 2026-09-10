# intraclass-paper

The companion software paper for the R package
[**intraclass**](https://github.com/jmgirard/intraclass), which estimates
interrater-reliability intraclass correlation coefficients (ICCs) within the
generalizability-theory framework using mixed-model variance-component
estimation. The package is on CRAN
(<https://CRAN.R-project.org/package=intraclass>); its documentation site is
<https://jmgirard.github.io/intraclass/>.

## Venue

The paper targets the [Journal of Open Source Software](https://joss.theoj.org/)
(JOSS). It is drafted here, in its own repository, so that the paper's drafting
and submission are tracked separately from the package's releases.

## How the paper reaches the package repository

JOSS asks that the paper be hosted in a Git repository together with the
software it describes, and allows the paper to live on a short-lived branch
that is never merged into the default branch. At submission, this repository's
`paper/` directory is copied onto a `joss-paper` branch of
`jmgirard/intraclass`, cut from that repository's default branch and never
merged. Until then, the paper is drafted only here. That arrangement is recorded
as decision D-045 in the package repository's `cairn/DECISIONS.md`.

## License

The paper text in this repository is licensed under
[CC BY 4.0](LICENSE.md). The `intraclass` package itself is MIT-licensed in its
own repository.

## Project tracking

This repository uses the cairn plugin for planning and review; project state
lives under `cairn/`.
