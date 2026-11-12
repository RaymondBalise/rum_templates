# Project Instructions (`CLAUDE.md`)

`rum_templates` is the manifest-driven Quarto, R Markdown, SCSS, and agent-skill
template repository consumed by `{rUM}` (`v2.4.0+`).

1. Read and follow all architecture rules, manifest conventions, 80-character
   line limits, and verification steps in [`AGENTS.md`](AGENTS.md).
2. Before committing template or manifest changes:
   - Verify all `src:` and `inject:` paths in `manifests/*.yml` exist on disk
     and never render raw `{{knitr_opts}}` templates directly in this repo.
   - Append architectural choices to the current dated entry in
     [`DECISIONS.md`](DECISIONS.md) (do not create duplicate same-day headers)
     and update [`CHANGELOG.md`](CHANGELOG.md).
