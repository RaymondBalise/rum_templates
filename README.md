# rum_templates

Official Quarto and R Markdown templates for the
[`{rUM}`](https://raymondbalise.github.io/rUM/) R package (`v2.4.0+`), covering
research projects, R packages with vignette manuscripts, and presentations.

## Project Structure
- `analysis/`: Analysis templates (.qmd, .Rmd).
- `manifests/`: YAML definitions for project types and variants.
- `slides/`: Revealjs presentation templates.
- `styling/`: Custom SCSS/CSS themes, title-page HTML, and R/Medicine artwork
  (`styling/img/`).
- `supporting/`: Boilerplate files (`.gitignore.md`, `.csl` styles, `inst/`
  package scripts, `partials/` snippets, and `agents/` AI skills).

## Usage
Templates are managed via YAML manifests in `manifests/` and are consumed by
`{rUM}` to initialize new projects, packages, and presentations.

> **Important:** Do not render `.qmd` or `.Rmd` files directly inside this
> repository. Templates contain `{{knitr_opts}}` tokens that `{rUM}` resolves
> at scaffold time from `supporting/partials/`.

## Updating Templates
To update a template, add the new file to the appropriate directory and
register it in the corresponding manifest.

### Manifest Schema
- `name`: Unique identifier for the template type.
- `description`: A brief summary of the template's purpose.
- `common`: (Optional) Files and actions shared by all variants.
- `variants`: Definitions for specific template configurations.
- `when`: Conditions (e.g., `format`, `example`) that trigger a variant.
- `files`: A list of file mappings for the template:
  - `src`: Path to the source template file in this repository.
  - `dst`: Target path in the new project (supports placeholders).
  - `inject`: (Optional) Map of `{{token}}` names to partial snippet files in
    `supporting/partials/` spliced into `dst` during scaffolding.
- `actions`: Post-initialization tasks:
  - `type`: The action to perform (e.g., `create_dir`, `create_bib`,
    `build_description`, `write_readme`, `write_scss`).
  - `path`: (Optional) The directory target for the action.

### Example: Adding a new analysis style
1. Add `analysis/new_style.qmd`.
2. Update `manifests/project.yml`:
   ```yaml
   variants:
     new_variant:
       when: { format: quarto, example: false }
       files:
         - src: analysis/new_style.qmd
           dst: analysis.qmd
           inject: { knitr_opts: supporting/partials/knitr_analysis.yml }
   ```
