<!-- Instantiated by /cairn-init as cairn/LESSONS.md (file header; the
     scaffold ships it empty of lessons). One line per lesson; corrected in
     place when proven false; retirement per tracking-rules "Retiring a
     lesson". -->
# Lessons

Durable repo lessons — build quirks, testing tricks, gotchas worth
remembering next time — captured at milestone end and surfaced at plan time.
Not status, not decisions: a lesson is a reusable "how this repo actually
behaves" note. Cross-cutting *choices* still go to `DECISIONS.md`.

One line per lesson: `- YYYY-MM-DD (M<NNN>): <lesson>`. Two caps: 50 lines
and 20,000 bytes; over either, retire or prune before adding. Corrected in
place when proven false (never append a correction).

- 2026-09-13 (M001): A `[src: …]` marker shows a bullet matches its source, not that the claim is true. Run another package's function before the paper states its limits, because the intraclass comparison vignette was wrong about `psych::ICC`.
- 2026-09-13 (M002): In the JOSS draft PDF, `pdftotext` puts a margin line number inside the page-1 title heading. A text match on the title passes only through the citation block, so squeeze whitespace and use `-raw`.
- 2026-09-13 (M003): In R, `format(signif(x, 6))` drops trailing zeros and uses `getOption("OutDec")`, so a CSV of rounded values can show 5 digits or break on a comma locale. Use `formatC(x, digits = 6, format = "fg", flag = "#")` and set `OutDec` to a period.
- 2026-09-13 (M004): A count returned by another package can measure something other than what prose says. `psych::ICC()$n.obs` counts input rows before `lmer()` runs, so it shows how many subjects psych reported, not how many it used. Read the function source before a sentence says "used".
- 2026-09-13 (M005): `add()` in `analysis/comparison.R` writes a whole number without decimals, so a derived value such as a Spearman-Brown k of 4.0000000000000009 prints as `4.00000` on one machine and `4` on another. Round a derived whole number before writing it.
