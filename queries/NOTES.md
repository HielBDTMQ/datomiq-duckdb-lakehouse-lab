# DuckDB exploration — post 1 (you write the SQL)

The point of post 1: 21M rows in a 330 MB gzipped file, queried on a laptop — no server, no import
job, no schema. This list is **what to demonstrate**, not the answers. Write the SQL yourself.

- **Load with zero ceremony.** Point DuckDB at the gzipped CSV (or the `.duckdb` file dlt produced)
  and count the rows. Notice DuckDB decompressed and inferred the schema for you.
- **Look before you leap.** Use DuckDB's inspection commands to see columns + types, and per-column
  stats (min/max, nulls, approx-distinct). You'll need the real column names for the next steps.
- **Friendly SQL.** Try the FROM-first form (no `SELECT *`) and `GROUP BY ALL`. Compute the busiest
  stations. Feel how much ceremony disappears vs "normal" SQL.
- **A window function.** Top-N stations per month (rank + partition).
- **Remote, partial reads.** Query the *Parquet* version straight from its HTTPS URL and note how
  little data actually crosses the wire (HTTP range reads + zonemaps). This is the seed of
  engine/storage decoupling — the whole lakehouse idea.
- **Write gold as Parquet.** Export a result to a Parquet file — the lakehouse storage format.
- **DuckDB ⇄ Polars.** Hand a result to Polars and back. Both speak Apache Arrow, so it's a
  zero-copy pointer pass — "SQL for the heavy lifting, Polars for the imperative bits", for free.

Reference (read for ideas, don't copy): the DuckDB blog —
<https://duckdb.org/2024/05/31/analyzing-railway-traffic-in-the-netherlands>.
