---
name: architect
description: Use when the user needs to design or plan the architecture of a system, feature, or refactor before writing code. Produces a structured design with components, data flow, tradeoffs, and a step-by-step implementation plan.
user-invocable: true
---

# Architect

Use this skill to design or plan software architecture before implementation.
It is meant to be invoked early, before large edits, so the user can review the
design and direction.

## Workflow

1. **Clarify the problem.** Read the request and restate the goal, constraints,
   and non-goals in one or two sentences. Search the codebase for existing
   structure, patterns, and conventions that the design must respect.
2. **Gather context.** List the relevant files, entry points, and any existing
   tests. Note the language, framework, and build/test commands used.
3. **Produce the design.** Present it as a structured plan with clearly labeled
   sections (see below). Keep it readable and concrete.
4. **Stop for review.** Do not start implementing. The user decides whether to
   proceed, adjust, or reject the design.

## Design output format

- **Overview** - one paragraph describing the proposed change.
- **Components** - the modules, files, functions, or types involved, each with
  a one-line responsibility.
- **Data flow** - how data moves through the system before and after the change.
- **Tradeoffs** - explicit alternatives considered and why the chosen one wins.
- **Edge cases** - failure modes, invalid inputs, concurrency, and how each is
  handled.
- **Testing strategy** - what to test and how the existing test suite maps to it.
- **Implementation plan** - ordered, small steps that a reviewer or implementer
  can follow.

## Guidelines

- Prefer small, incremental changes over large rewrites.
- Match the existing codebase conventions; do not introduce new patterns
  without a reason.
- Respect failure modes: state what happens on error and how it is surfaced.
- Keep the design within the scope of the original request.
