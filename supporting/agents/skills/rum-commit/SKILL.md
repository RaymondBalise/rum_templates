---
name: rum-commit
description: >-
  Draft clean, structured git commit messages with a concise conventional
  header and 2-space indented bullets explaining what changed and why. Activate
  whenever committing changes or drafting a commit message in this project.
---

# `{rUM}` Git Commit Message Skill (`rum-commit`)

Draft clear, structured git commit messages that capture both *what* changed
and *why*.

---

## 1. Reconnaissance Before Drafting

1. Run `git status -s` and `git diff --stat` (plus `git diff` on modified files
   as needed) to inspect staged and unstaged changes.
2. Run `git log --oneline -n 5` to match recent commit scope conventions.
3. Always include the formatted commit message draft directly in your response
   when offering to commit.

---

## 2. Commit Message Format

```text
type(scope): concise summary of what it solved
  - indented bullet explaining how or what changed
  - indented bullet explaining why the change was needed
  - reference to issue or source URL if applicable
```

### Allowed Types
* `feat`: New manuscript section, package function, data pipeline, or table
* `fix`: Bug fix, filtering correction, broken render fix, or `R CMD check` fix
* `docs`: `README.md`, `DECISIONS.md`, `CHANGELOG.md`, `NEWS.md`, or `roxygen2`
* `refactor`: Restructuring `R/` code or chunks without changing outputs
* `test`: Adding or updating `testthat` tests or verification checks
* `chore`: `.gitignore`, `.Rbuildignore`, `DESCRIPTION`, `.csl`, or `.scss`

---

## 3. Formatting Rules

1. **Header Line (`<= 72` characters)**:
   * Keep the first line strictly at or under **72 characters**.
   * Use lowercase `type(scope): summary` with no trailing period.
2. **Indented Bullet Body**:
   * Use **2-space indented bullets** (`  - `) directly below the header line
     (2 to 5 bullets).
   * Never write free-form multi-paragraph commit bodies.
   * Explain **why** the change was made, not just filenames.
3. **Zero AI Attribution**:
   * Never add AI/LLM attribution, agent signatures, or `Co-Authored-By:`
     trailers.

---

## 4. Example

```text
feat(penguins): stratify bill dimension summary table by island
  - Clean species and island factor levels in R/clean_penguins.R
  - Add stratified gtsummary table (@tbl-morphology) to analysis.qmd
  - Account for island-level body size differences noted in exploratory plots
```
