---
layout: page
title: A Hands-On AI Coding Workshop for Developers
subtitle: How I Learned to Stop Worrying and Love The Claude
---

## Abstract

**AI Coding** is one of the most FOMO inducing "recent" (2-3 years) developments affecting software engineering.
My goal is to create a compact, hands-on workshop for learning how to use the most recent tools and more importantly - how to slightly reduce that feeling that things are moving at lightspeed without you.

Over the past 3 years I have found myself changing tooling multiple times. So my goal is to not only teach what the "latest and greatest" is - as that can change fast - but rather to adapt people's workflows into ones that can allow such fast changes.

Practically speaking - in this 1.5-2.5\* hour-workshop I will present **how I work** using **Cursor** and **Claude Code**. My goal is to cover initial set-up all the way to advanced tooling such as *subagents*, *skills* and *hooks*, explain how they interact, how they can use eachother, and how to create your own.

The workshop is "code-first": participants are going to be using their own laptops on a shared codebase that has the basics ready for learning and enhancements.

## Target Audience

- Backend, data, and ML engineers who want to level up their AI coding skills.
- Participants should optimally already have Cursor/VSCode installed but we can also do that part together.
- A shorter, no-hands-on is also an option.
- Works well for groups of 5-15; this allows for a "sit down" experience.

## Prerequisites
Sent ahead of time: install Cursor + Claude Code, Node, `gh`, clone the shared repo, set API keys.

## Syllabus

**Part 1 - Foundations (~30 min)**
- Cursor tour; picking the right model (Haiku/Sonnet/Opus, thinking models)
- Context engineering: `CLAUDE.md`, `@file` references, project vs user memory
- Claude Code - what it is, what it does, how it differs from Cursor

**Part 2 - Tooling That Compounds (~45 min)**
- *How I work with Claude Code?:* honest review of how I work
- Planning vs execution: plan mode, interview-style prompting, `/handoff` between sessions
- MCPs and CLIs (`gh`, Linear) as first-class tools
- `SKILLS.md` and *subagents* - tour the provided `.claude/`, then open the hood on one skill and one subagent
- Hooks and scripts - automating the boring parts

**Part 3 - Problems (~20 min)**
- Git hygiene with agents: worktrees, commit discipline, reviewing diffs before accepting
- Evaluation and guardrails: catching "LGTM drift" and silent wrong answers
- Security issues and how to best avoid them

**Part 4 - Capstone: the self-improve skill (~30 min)**

One exercise that threads everything together. Participants build a skill that, at session end, reviews what they just did and proposes updates to their own `CLAUDE.md`.

<!-- - **Skill** - the `self-improve.md` definition
- **Subagent** - delegates diff and transcript analysis to keep main context clean
- **Script** - `git-utils session-diff` feeds the input
- **MCP** - pulls the Linear issue they worked on and cross-references the diff
- **Hook** - wires it to `Stop` so it runs automatically (stretch goal; manual `/self-improve` is the baseline)
- **Safety** - propose-diff-don't-auto-apply; self-improving skills can happily rewrite your config into mush -->

## What You Walk Away With
- A working `self-improve` skill committed to your own dotfiles
- A mental model for when to reach for Cursor vs Claude Code vs a subagent vs a hook
- A workflow that survives the next tooling cycle, not just this one

<sub>\**Timings are approximate; a precise structure/syllabus will be decided depending on final duration.*</sub>
