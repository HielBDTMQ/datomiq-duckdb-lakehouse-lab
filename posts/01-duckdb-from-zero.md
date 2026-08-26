---
title: "DuckDB from zero — and why it exists"
series: smb-duckdb-lakehouse
part: 1
status: draft
author: Hicham el Bouazzaoui
---

# DuckDB from zero — and why it exists

<!--
WRITING GUIDE (delete before publishing). This is YOUR post — the notes below are just prompts.
Voice: hands-on, honest, DatomIQ (cloud-agnostic, tool-neutral). Databricks is a respected tool,
not a punching bag. Each code block should be runnable from this repo.
-->

## Why DuckDB exists
<!-- The hook. What problem DuckDB was built for — not "Snowflake bad", but:
- an in-process, columnar-vectorized analytical database — "SQLite for analytics"
- runs embedded in your process (a library, not a server); zero dependencies to install
- reads Parquet/CSV directly; processes larger-than-memory data out-of-core on ONE node
- the consequence: for data that fits on one fat node (most SMB), you don't need a cluster.
Land the thesis in ~3 sentences, then show it. -->

## Install (30 seconds)
<!-- `uv add duckdb` / `pip install duckdb`, or the standalone CLI. Note: no server, no account. -->

## First query: 21 million rows, one gzipped file, no setup
<!-- Use the NL railway 2023 services dataset (330 MB gzip CSV). Show:
  CREATE TABLE services AS FROM 'data/services-2023.csv.gz';  SELECT count(*) ...
Emphasise: DuckDB decompressed + inferred the schema; you queried 21M rows on a laptop. -->

## Friendly SQL that gets out of your way
<!-- DESCRIBE / SUMMARIZE to explore; then FROM-first + GROUP BY ALL for "busiest stations".
Show why this ergonomics matters when you're iterating. A window function for top-3/month. -->

## Your data doesn't have to be local: remote Parquet, partial reads
<!-- Query https://…/services-2023.parquet directly; DuckDB pulls ~20 MB not 309 MB (range reads +
zonemaps). This is the seed of the lakehouse idea: engine and storage are decoupled. -->

## DuckDB ⇄ Polars: zero-copy, because Arrow
<!-- The DatomIQ angle (src/duckdb_from_zero.py). rel.pl() hands a result to Polars with no copy;
DuckDB can query a Polars frame by name. "SQL for the heavy lifting, Polars for the imperative
bits" — free, because both speak Arrow. -->

## What this buys an SMB
<!-- Tie back to the series thesis (1–2 sentences): compute is ephemeral and near-free; you pay
for storage + a small catalog. And the honest boundary — this is one node; when you truly outgrow
it, Spark/Databricks is the escape hatch (later post). Tease post 2: turning Parquet into a
lakehouse with DuckLake. -->

---
*Reproduce every query in this post: [smb-duckdb-lakehouse-lab](https://github.com/HielBDTMQ/smb-duckdb-lakehouse-lab) → `queries/01_duckdb_from_zero.sql` and `src/duckdb_from_zero.py`.*
