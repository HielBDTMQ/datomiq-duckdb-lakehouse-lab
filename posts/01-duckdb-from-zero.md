---
title: "DuckDB from zero — and why it exists"
series: smb-duckdb-lakehouse
part: 1
status: draft
author: Hicham el Bouazzaoui
---

# DuckDB from zero — and why it exists

<!--
WRITING GUIDE (delete before publishing). This is YOUR post — the notes below are prompts, not
prose or code. Voice: hands-on, honest, DatomIQ (cloud-agnostic, tool-neutral). Databricks is a
respected tool, not a punching bag. Every code block should be something you actually ran from
this repo. Keep the code in the post minimal — link to `queries/` and `ingestion/` for the full thing.
-->

## Why DuckDB exists
<!-- The hook, ~3 sentences, then show it. What DuckDB was built for: an in-process,
columnar-vectorised analytical database ("SQLite for analytics"), embedded (a library, not a
server), reads Parquet/CSV directly, processes larger-than-memory data out-of-core on one node.
Consequence: for data that fits on one fat node (most SMB), you don't need a cluster. -->

## Install in 30 seconds
<!-- uv-first (this repo): create the venv, add duckdb. Point out: no server, no account, no import
step. The CLI or the Python lib — pick one. -->

## Getting the data in — dlt straight into DuckDB
<!-- Instead of curl, use dlt (its default destination is DuckDB). Show/point to `ingestion/`.
The angle: you ingested 21M rows with a tiny pipeline, and dlt handled schema + metadata. Name the
contrast with "DuckDB reads the file directly" (great for one-off exploration). -->

## First query: 21 million rows, no setup
<!-- Count the rows over the 330 MB dataset; note DuckDB decompressed + inferred the schema. Then
inspect the columns/stats. The story: this ran on your laptop in seconds. -->

## Friendly SQL that gets out of your way
<!-- FROM-first + GROUP BY ALL for the busiest stations; a window function for top-N per month.
Show why the ergonomics matter when you're iterating. -->

## Storage and engine aren't the same thing
<!-- Query the remote Parquet over HTTPS; note how little data crosses the wire (range reads +
zonemaps). This is the seed of the lakehouse idea you build across the series. -->

## DuckDB ⇄ Polars: zero-copy, because Arrow
<!-- Hand a result to Polars and back; both speak Arrow → no copy. "SQL for the heavy lifting,
Polars for the imperative bits", free. -->

## What this buys an SMB
<!-- Tie back to the series thesis in 1–2 sentences: compute ephemeral + near-free, pay for
storage + a small catalog. The honest boundary: one node; when you truly outgrow it,
Spark/Databricks is the escape hatch (a later post). Tease post 2: turning Parquet into a
lakehouse with DuckLake. -->

---
*Reproduce everything: [datomiq-duckdb-lakehouse-lab](https://github.com/HielBDTMQ/datomiq-duckdb-lakehouse-lab) → `ingestion/` and `queries/`.*
