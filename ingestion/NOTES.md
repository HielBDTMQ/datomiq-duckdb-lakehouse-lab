# Ingestion — experiment with dlt

Goal: get the NL railway data into DuckDB using **dlt** (data load tool) instead of a manual
download. This is your first taste of the ingestion layer (post 3 goes deeper) — and dlt's
**default destination is DuckDB**, so "fetch → normalise → load" happens in a few lines *you* write.

## Why dlt here (not curl)
- dlt is a Python EL library: extract from a source, it infers + evolves the schema, loads to a
  destination. Incremental loading and schema evolution come for free.
- Default destination = a local DuckDB file → `source → dlt → a .duckdb file`, no server.
- Downloading *through* dlt means you're already practising the tool you'll lean on later.

## The datasets (from the DuckDB railway post)
- services 2023 — gzipped CSV, ~330 MB, ~21.2M rows:
  `https://blobs.duckdb.org/nl-railway/services-2023.csv.gz`
- services 2023 — Parquet (for the remote / partial-read experiment):
  `https://blobs.duckdb.org/nl-railway/services-2023.parquet`
- stations: `https://blobs.duckdb.org/data/stations-2022-01.csv`
- tariff distances: `https://blobs.duckdb.org/data/tariff-distances-2022-01.csv`

## What to build (you write it)
- A dlt **pipeline** with a **DuckDB destination**.
- A **resource** that reads the remote CSV(s). Two routes worth trying:
  - dlt's **filesystem** source to read the CSV/gzip straight from the URL, or
  - a small custom `@dlt.resource` that streams rows from the file.
- Run it → you get a `.duckdb` file with a `services` table. Then query it (see `../queries`).

## Things to poke at (good material for the post)
- How dlt named + typed the columns, and the `_dlt_*` metadata tables it adds.
- Re-running the pipeline: full vs incremental load (the schema-evolution story for post 3).
- Contrast with "DuckDB reads the file directly": dlt **lands and governs** the data; DuckDB-direct
  is great for one-off exploration. Post 1 can show both and name the trade-off.
