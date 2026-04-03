---
description: Enforce Tab-first discipline across all project skills
globs: []
alwaysApply: true
---

# Tab Discipline

When any `mcp__tab-for-projects__*` tool is available, these rules are non-negotiable.

## Session Start (run once, before any skill executes)

1. `mcp__tab-for-projects__list_projects()` — match the active project
2. Load goal, requirements, design, tasks, and attached KB documents
3. Check for stale `in_progress` tasks — reset to `todo`, or ask if ambiguous
4. Load the "Session Progress Log" document if it exists; create one if not

## Incremental Persistence (after every state change — no batching)

| Event | Save action |
|-------|-------------|
| Any question answered | Update project requirements |
| Research produces reusable knowledge | Save KB doc immediately (background agent) |
| Approach decided or rejected | Update project design |
| Task created, started, or completed | Mark status in Tab |
| Task completed | Also append to Session Progress Log |
| Blocker or significant decision | Append to Session Progress Log |
| Sub-agents about to dispatch | Append to Session Progress Log synchronously (crash recovery) |

## Hard Constraints

- Never let a session end without a final Session Progress Log entry
- Never batch Tab saves — save at each trigger above
- The "before dispatch" progress save must be synchronous, not a background agent
- For intent routing, follow the `/tab` orchestrator
