<!-- Instantiated by /cairn-init as cairn/DECISIONS.md (file header; entries
     are appended from templates/decision.md). A migration replaces the body
     note with its pointer-only or re-recorded disposition (migration
     protocol step 5). -->
# Decisions

Append-only. Never renumber; supersede with a new entry. D-entries record
choices with rationale — never deferrals ("not now" is a ROADMAP fact).

### D-001 (2026-09-13): Comparison figures come from the committed comparison script

**Context:** The DESIGN.md convention named the package's own oracle-verified test values as the source of every comparison figure. M003's script instead runs intraclass, psych, irr, and irrICC and writes their results.
**Decision:** A comparison figure comes from `analysis/comparison.R` run against the package versions its results file records. The package tests are not the source.
**Consequences:** Readers can rerun the comparison without the package's test suite. The figures depend on the compared packages' versions, which the results file records.
