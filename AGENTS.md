# Repository Instructions (`AGENTS.md`): `rum_templates`

`rum_templates` is the canonical template source for `{rUM}` (`v2.4.0+`).
`{rUM}` downloads this repository (`refs/heads/main.zip`), resolves YAML
manifests in `manifests/`, injects shared `knitr` partials, and copies files
into newly initialized analysis projects, R packages, and Revealjs slide decks.

---

## 1. Directory Structure

- `manifests/`: Declarative YAML manifests consumed by `{rUM}`:
  - `project.yml`: `rUM::make_project()` (Quarto and R Markdown projects).
  - `package.yml`: `rUM::make_package()` (Quarto and R Markdown packages).
  - `slides.yml`: `rUM::write_slides()` (`none`, `miami`, and `rmed` themes).
  - `quarto_standalone.yml`: `rUM::write_quarto()` standalone `.qmd` documents.
- `analysis/`: `.qmd` and `.Rmd` manuscript, vignette, and standalone templates.
- `slides/`: Quarto Revealjs slide templates (`default`, `miami`, `rmed`, with
  and without worked examples).
- `styling/`: Custom `.scss` themes (`custom.scss`, `slides.scss`,
  `custom_miami.scss`, `slides_example_rmed.scss`), `clean_title_page.html`,
  and R/Medicine slide artwork in `styling/img/`.
- `supporting/`: Shared scaffold payloads:
  - `.gitignore.md` (aggressive PHI-safe `.gitignore`) and
    `vignettes_gitignore.md` (`vignettes/.gitignore`).
  - Bundled Zotero citation styles (`apa.csl`, `mla.csl`,
    `the-new-england-journal-of-medicine.csl`).
  - `partials/`: Shared `knitr` snippets (`knitr_analysis.yml`,
    `knitr_slides.yml`, `knitr_rmd.Rmd`) spliced via `{{knitr_opts}}`.
  - `inst/scripts/`: Starter package scripts (`libraries.R`, `do_everything.R`).
  - `agents/`: Scaffolded `AGENTS_{project,package}.md`, `CLAUDE.md`,
    `GEMINI.md`, and `.agents/skills/` (`rum-workflow`, `rum-devlog`,
    `rum-commit`).

---

## 2. Manifest & Partial Injection Architecture

- **Manifest Schema**: Each YAML manifest defines `name`, `description`,
  `common` (`files` and `actions`), and conditional `variants` matched via
  `when:` flags (`format`, `example`, `template`). Every variant in a
  multi-variant manifest must include a non-empty `when:` map, and `main` must
  remain backward-compatible with `{rUM}` `v2.4.0+` manifest keys and actions.
- **Path & Partial Tokens**:
  - `dst` strings support `{package_name}`, `{path}`, and `{filename}` tokens
    expanded by `{rUM}` at scaffold time.
  - `inject: { knitr_opts: supporting/partials/... }` splices canonical
    `knitr` chunk options into `{{knitr_opts}}` before writing the destination
    file.
- **Template Versioning**:
  - Every `.qmd` and `.Rmd` template carries `template-version: <int>` in YAML
    frontmatter matching the top release section in `CHANGELOG.md`.
  - Only increment `template-version` when explicitly cutting a new template
    release.

---

## 3. Hard Rules & Development Conventions

- **Never Render Raw Templates In-Place**: `.qmd` and `.Rmd` files in this repo
  contain `{{knitr_opts}}` tokens and relative destination paths (`bib/apa.csl`,
  `styling/`). Always scaffold into a temporary directory via `{rUM}` before
  running `quarto render` or `rmarkdown::render()`.
- **80-Character Line Limit**: Wrap all R code, YAML comments, Markdown docs,
  and agent skill files at or before **80 characters** (exempting long URLs or
  unbreakable YAML keys).
- **Template Safety & Quarto Standards**:
  - Use straight ASCII quotes (`"` / `'`) only; never introduce curly quotes.
  - Protect sampling snippets against length-1 vector surprises with
    `x[sample.int(length(x), size)]`.
  - Use tidyverse/tidymodels idioms (`|>` pipe) and `palmerpenguins` or `mtcars`
    for generic examples.
  - If adding `_quarto.yml` website/book templates, include
    `execute-dir: project` and place `index.qmd` at the project root.
- **Styling & Citations**:
  - Keep presentation and document styling in `styling/*.scss` rather than
    inline CSS/HTML styles.
  - Keep `.bib` and `.csl` references routed to `bib/` (`vignettes/bib/` in
    package vignettes) with `apa.csl` as the default style.

---

## 4. Verification & Documentation Gate

1. **Manifest Integrity**: Whenever adding, renaming, or moving files, verify
   every `src:` and `inject:` path across `manifests/*.yml` resolves on disk.
2. **End-to-End Scaffold Check**: Test template or manifest changes against
   `../rUM` (`devtools::test()` and temp-directory renders).
3. **Decision & Release Logs**:
   - Record architectural or convention choices in
     [`DECISIONS.md`](DECISIONS.md). When logging multiple updates on the same
     date, append to the existing `## YYYY-MM-DD` entry rather than creating
     duplicate date headers.
   - Record user-facing template additions, changes, and fixes in
     [`CHANGELOG.md`](CHANGELOG.md).
