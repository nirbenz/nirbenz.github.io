---
layout: page
title: Configuring AI Coding Assistants
subtitle: Skills, MCP, Subagents, and Shared Configuration for Cursor & Claude Code
---

## Abstract

AI coding assistants are now part of every developer's toolkit - but most teams use them out of the box, with generic behavior that misses project conventions, ignores architectural decisions, and produces inconsistent output. The difference between a generic assistant and one that _knows your project_ comes down to configuration.

This 1-hour workshop fixes that. Participants start with a bare project and progressively layer in real configuration: a shared skills framework that both Cursor and Claude Code discover automatically, MCP servers that connect assistants to external tools, and Claude Code subagents that handle complex autonomous tasks. Every addition is immediately testable -- participants prompt their assistant and see the behavior change in real time.

The workshop is config-first: participants write skill definitions, wire up MCP servers, and configure assistant behavior in guided exercises, using a production-grade reference configuration ([dev-config](https://github.com/<this-part-is-private>)) as the blueprint.

## Workshop Variants

The workshop can be tailored to the audience's tooling:

| Variant                 | Focus                                                                              | Best For                                           |
| ----------------------- | ---------------------------------------------------------------------------------- | -------------------------------------------------- |
| **Cursor-focused**      | Skills in Cursor, MCP in Cursor, migration from legacy rules                       | Teams standardized on Cursor IDE                   |
| **Claude Code-focused** | `CLAUDE.md`, settings & hooks, skills, subagents                                   | Teams using Claude Code (CLI or VS Code extension) |
| **Combined**            | Shared skills & MCP config, tool-specific features, where they overlap and diverge | Teams using both, or evaluating which to adopt     |

The syllabus below follows the **combined** variant. In single-tool variants, the time freed from the other tool's section is reallocated to deeper exercises and discussion in the focused tool.

## Target Audience

- Developers and tech leads who use Cursor or Claude Code daily and want to go beyond default behavior.
- Team leads looking to standardize AI assistant behavior across their organization.
- Engineers evaluating how to encode project conventions, tooling preferences, and workflows into their AI setup.
- Participants should be comfortable with a code editor and terminal; no prior experience with Cursor or Claude Code configuration is required.
- Works well for groups of 5-15.

## Syllabus

| Time         | Phase | Topic                                                                                                                                                                                                             |
| ------------ | ----- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 0:00 -- 0:05 | --    | **Intro & orientation** -- the problem with unconfigured assistants, the convergence of Cursor and Claude Code, workshop goals                                                                                    |
| 0:05 -- 0:20 | 1     | **The skills framework** -- `SKILL.md` anatomy, YAML frontmatter, auto-invocation vs explicit `/slash` commands, shared discovery across `.cursor/skills/` and `.claude/skills/`, writing your first skill        |
| 0:20 -- 0:35 | 2     | **Claude Code configuration** -- `CLAUDE.md` as persistent context, `.claude/settings.json` permissions model, hooks (auto-format on save, notifications), rules directory for scoped instructions                |
| 0:35 -- 0:45 | 3     | **MCP servers** -- what MCP is and why it matters, `.mcp.json` walkthrough, wiring up Context7 (live docs), Linear (issue tracking), and GitHub (repo operations); shared config across both tools                |
| 0:45 -- 0:55 | 4     | **Workflow skills & subagents** -- building multi-step workflow skills (`/commit`, `/pr`, `/deps`), subagents for autonomous complex tasks (code review, test generation, architecture review), when to use which |
| 0:55 -- 1:00 | --    | **Wrap-up** -- the dev-config setup script, sharing configs across projects via symlinks, migrating from legacy Cursor rules, open questions                                                                      |

<sub>_Timings are approximate; each phase includes a live demo followed by a guided exercise._</sub>

<!-- ## Phase Breakdown

### Phase 1 -- The Skills Framework

Both Cursor and Claude Code now use a shared skills model: a `SKILL.md` file in a folder under `.cursor/skills/` or `.claude/skills/` (both tools discover from both paths). Participants create their first skill -- a simple coding-standards skill that teaches the assistant their project's tech stack and style preferences.

**Key concepts:**

- What a skill is: a portable, version-controlled package that teaches agents domain-specific tasks
- `SKILL.md` structure: YAML frontmatter (`name`, `description`) + markdown body with instructions
- Auto-invocation (agent decides when to apply) vs explicit slash commands (`disable-model-invocation: true`)
- Discovery paths: project-level (`.cursor/skills/`, `.claude/skills/`) and user-level (`~/.cursor/skills/`, `~/.claude/skills/`)
- Migration from legacy Cursor rules (`.mdc` files) via `/migrate-to-skills`

**Exercise:** Create a `coding-standards` skill that defines the project's tech stack, typing requirements, and docstring format. Prompt the assistant to write a function -- compare output with and without the skill present.

### Phase 2 -- Claude Code Configuration

Beyond skills, Claude Code has its own configuration layer: `CLAUDE.md` for persistent project context, `settings.json` for permissions and hooks, and a `rules/` directory for scoped instructions. Participants configure these and see how they interact with the skills layer.

**Key concepts:**

- `CLAUDE.md` as persistent context (project-level vs user-level) -- different from skills in that it is always loaded
- Permission tiers: `allow`, `ask`, `deny` -- controlling what the assistant can do
- Hooks: `SessionStart`, `PostToolUse`, `Stop` -- automating side-effects (e.g., auto-format after edits)
- The `.claude/rules/` directory for topic-scoped instructions (e.g., test-writing guidelines)

**Exercise:** Write a `CLAUDE.md` with project preferences and a `PostToolUse` hook that runs `ruff format` after every Python file edit. Ask Claude Code to write a function and observe the auto-format trigger.

### Phase 3 -- MCP Servers

MCP (Model Context Protocol) gives assistants access to external tools and live data. The same `.mcp.json` file is read by both Cursor and Claude Code. Participants wire up a documentation server and see how it changes response quality.

**Key concepts:**

- MCP as a protocol: tool servers that any compatible client can use
- Server types: `stdio` (npx-based) vs `http` (API-based)
- Shared config: one `.mcp.json` serves both Cursor and Claude Code
- Practical examples: Context7 for live library docs, Linear for issue tracking, GitHub for repo operations

**Exercise:** Add Context7 to `.mcp.json` and ask the assistant to look up the API for a library. Compare the response quality to a prompt without MCP access.

### Phase 4 -- Workflow Skills & Subagents

With the basics in place, participants look at real production skills that automate multi-step workflows -- semantic commits, pull request creation, dependency research. Then a brief dive into Claude Code subagents: autonomous agents with specialized expertise that can run in the background.

**Key concepts:**

- Workflow skills: multi-step instructions the agent follows end-to-end (`/commit`, `/pr`, `/deps`)
- Skills with scripts: including executable code in `scripts/` for the agent to run
- Subagents (`.claude/agents/*.md`): specialized agents for code review, test generation, architecture review
- Decision framework: skills for repeatable workflows, subagents for deep autonomous exploration

**Exercise:** Read through the `/commit` skill, then invoke it on a staged change. Examine the commit message format, co-author attribution, and staging logic. -->

## What Participants Walk Away With

- A working skills directory with at least one custom skill, discoverable by both Cursor and Claude Code
- A configured `.claude/` directory with `CLAUDE.md`, settings, and hooks
- A `.mcp.json` wiring up at least one external tool
- Understanding of the skills framework and how it unifies configuration across tools
- Understanding of when to use skills vs subagents
- Access to the [dev-config](https://github.com/nirbenz/dev-config) reference repository and its setup script for bootstrapping future projects

## Prerequisites

- **Cursor IDE** (2.4+) installed, or **VS Code** with the Claude Code extension (or both, for the combined variant)
- **Node.js 18+** (for MCP servers via npx)
- A **GitHub account** with a personal access token
- _Optional:_ a Linear account for the MCP exercise
