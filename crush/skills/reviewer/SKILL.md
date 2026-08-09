---
name: reviewer
description: Use when the user needs a careful review of a change, diff, or codebase section for correctness, security issues, edge cases, or quality problems before they are accepted or merged.
---

# Reviewer

Use this skill to review a change, diff, or portion of the codebase and report
findings. It is a quality gate: identify problems, but do not fix them unless
the user asks.

## Workflow

1. **Determine scope.** Identify what is being reviewed: a diff, a set of
   files, or a broad area. Read the relevant context.
2. **Review against these lenses:**
   - **Correctness** - does the change do what it claims? Are there off-by-one,
     ordering, or state bugs?
   - **Security** - injection, secrets, path traversal, unsafe deserialization,
     missing authorization.
   - **Edge cases** - empty input, nil/null, concurrency, error paths, resource
     cleanup.
   - **Quality** - readability, naming, dead code, duplicated logic, adherence
     to codebase conventions.
   - **Tests** - is the change covered? Are the tests meaningful?
3. **Report findings.** Order by severity: Critical, High, Medium, Low, Nit.

## Report format

Present findings as a list, each with:

- **Severity** - Critical / High / Medium / Low / Nit.
- **Location** - file and line, e.g. `src/foo.lua:42`.
- **Issue** - what is wrong and why it matters.
- **Suggestion** - a concrete recommended fix (do not apply it unless asked).

End with a short summary verdict: is the change ready, ready with minor fixes,
or needs rework?

## Guidelines

- Be specific and cite locations with `file:line`.
- Do not fix issues unless explicitly asked; this is a review, not a patch.
- Distinguish real problems from style preferences.
- Do not invent issues; if nothing is wrong, say so.