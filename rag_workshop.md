---
layout: page
title: A Hands-On RAG Workshop For Developers
subtitle: Understand and Build a Full Production Retrieval Workflow
---


## Abstract

**RAG (Retrieval-Augmented Generation)** is the most common pattern for grounding LLMs in real data - yet most teams treat the retrieval half as a black box. Chunking strategy, embedding choice, similarity search, and prompt design each have a dramatic effect on answer quality, but are rarely explored hands-on.

This 3-4\*-hour workshop fixes that. Participants start with bringing their *own data* - a WhatsApp conversation they which to search - and build upon a working baseline (a simple chunker + naive retrieval) and progressively build more sophisticated components: embedding-based similarity, vector database search with re-ranking, and advanced chunking strategies. Every change is immediately visible in a live UI, so the impact of each decision is felt, not just described.

The workshop is code-first: participants implement core functions (cosine similarity, re-ranking, prompt engineering, time-gap segmentation) in guided exercises, with reference solutions available at the flip of a toggle.

The workshop is accompanied by an introductiory lecture for retrieval/RAG, as well as some more advanced topics in the field.

## Target Audience

- Backend, data, and ML engineers who use RAG in production (or plan to) and want to understand what is actually happening beneath their framework of choice.
- Technical leads and architects evaluating chunking and retrieval strategies for their products.
- Participants should be comfortable reading and writing Python; no prior NLP or embedding experience is required.
- A shorter, no-coding format can also be chosen.
- Works well for groups of 5-20. Larger groups benefit from a TA.

## Syllabus

| Time         | Phase | Topic                                                                                          |
| ------------ | ----- | ---------------------------------------------------------------------------------------------- |
| 0:00 - 0:30 | --    | **Setup & orientation** -- environment, UI walkthrough, WhatsApp data exploration              |
| 0:30 - 1:00 | 1     | **Baseline chunking & naive retrieval** -- sliding-window chunker, passthrough engine          |
| 1:00 - 1:45 | 2     | **Embedding-based retrieval** -- implement cosine similarity & top-k selection (exercise)      |
| 1:45 - 2:00 | --    | *Break*                                                                                        |
| 2:00 - 2:45 | 3     | **Vector search & generation** -- Qdrant ANN, re-ranking exercise, prompt engineering exercise |
| 2:45 - 3:30 | 4     | **Advanced chunking** -- time-gap segmentation exercise, sentence-boundary & semantic chunkers |
| 3:30 - 4:00 | --    | **Wrap-up** -- comparing strategies side-by-side, open discussion, extension pointers          |

<sub>\**Timings are approximate; exercises include built-in solution toggles so pace can be adapted to the group.*</sub>
