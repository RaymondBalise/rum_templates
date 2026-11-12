# Project Decision Log

This document records technical and architectural decisions made throughout the
lifecycle of `rum_templates`.

Entries are ordered chronologically with newest entries at the top.

---

## 2026-11-12: v1 Template Architecture, Bundled Assets, and Agent Tooling

- **Context / Problem**: Externalizing `{rUM}` (`v2.4.0+`) templates into a
  standalone repository exposed several maintenance and runtime issues:
  `knitr` option drift across 14 `.qmd`/`.Rmd` templates, conflicting coding
  conventions between standalone projects and R packages, live network fetches
  to `zotero.org` and `RaymondBalise/rUM` during scaffolding, root-level `.bib`
  and `.csl` clutter, and installed-only `system.file()` lookup errors during
  active package vignette development.
- **Decision Taken**:
  1. **Scaffold-Time Partial Injection**: Extract shared `knitr` chunks to
     `supporting/partials/` (`knitr_analysis.yml`, `knitr_slides.yml`,
     `knitr_rmd.Rmd`) and splice `{{knitr_opts}}` via manifest `inject:` maps,
     stamping templates with `template-version: 1` while `{rUM}` fetches live
     `main.zip` archives.
  2. **Split Project vs. Package Agent Rules & Root Dogfooding**: Map
     `AGENTS_project.md` and `AGENTS_package.md` (plus `rum-workflow-*`) to
     `AGENTS.md` and `.agents/skills/rum-workflow/SKILL.md` via `project.yml`
     and `package.yml`, replacing `dated_progress_notes.md` with `rum-devlog`
     (`DECISIONS.md` + `CHANGELOG.md` / `NEWS.md`) and `rum-commit`. Track a
     matching root `AGENTS.md` with lightweight `CLAUDE.md` and `GEMINI.md`
     wrappers in `rum_templates` itself.
  3. **Bundled Citation & Slide Assets**: Vendor `apa.csl` (new default),
     `mla.csl`, and `the-new-england-journal-of-medicine.csl` into `bib/`
     (`vignettes/bib/` for packages), and bundle `clean_title_page.html`,
     R/Medicine `styling/img/` artwork, and `quarto_slides_example.qmd` in
     `manifests/slides.yml`.
  4. **Package Data & Script Scaffolding**: Scaffold `inst/extdata/`,
     `inst/scripts/{libraries,do_everything}.R`, `vignettes/.gitignore`,
     guarded `library(arrow)` (`requireNamespace()`), and an
     `inst/extdata/`-scoped `read_extdata()` helper across package vignette
     templates (omitting pre-created `data/` in `package.yml` so non-`.rda`
     files are not placed in `data/`, while `usethis::use_data()` creates
     `data/` on demand).
  5. **Classroom Ergonomics & Agent Adaptability**: Keep `error: true`,
     `analysis` dataset naming, and `{r label}` chunk headers intact for
     teaching workflows; adapt `AGENTS_*.md` and `rum-workflow` to match the
     existing chunk style in `.qmd` files and inspect render stderr for chunk
     errors; preserve existing `@R-*` package citations across multi-document
     `bib/packages.bib` renders; and guard `libraries.R` auto-installation
     with `interactive()` and a CRAN mirror fallback.
- **Rationale & Trade-offs**: Consolidates every scaffolded template and binary
  asset into a single versioned download (`rum_templates` `main.zip`), keeps
  delivered `.qmd`/`.Rmd` files self-contained with teaching comments intact,
  prevents contradictory AI rules, and supports `devtools` workflows before
  package installation. Raw templates in this repo require `{rUM}` scaffolding
  before rendering.
- **Related Files**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `manifests/*.yml`,
  `analysis/*`, `slides/*`, `styling/**`, `supporting/**`
