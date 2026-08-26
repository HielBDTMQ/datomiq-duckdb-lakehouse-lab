# datomiq-duckdb-lakehouse-lab

Build-in-public lab: a cheap, cloud-agnostic lakehouse for SMB with **DuckDB as the core engine**
(DuckLake + dlt + dbt-duckdb + Polars). Companion code for the DatomIQ blog series; each post =
one buildable milestone. Databricks stays the escape hatch — this is about the many cases where a
whole lakehouse fits on one node.

> The code is yours to write. These folders hold **notes and prompts, not solutions.**

## Setup (uv)

DatomIQ uses **uv** everywhere. Start by creating the virtualenv:

```bash
uv venv                       # create .venv/
source .venv/bin/activate     # or prefix each command with `uv run`
uv add duckdb dlt polars pyarrow
```

(The first `uv add` also creates `pyproject.toml`; run `uv init` first if you want it explicit.)

## Layout

- **`ingestion/`** — get the data in with **dlt** (see `ingestion/NOTES.md`). dlt's default
  destination is DuckDB, so this doubles as your first ingestion experiment.
- **`queries/`** — DuckDB exploration for post 1 (see `queries/NOTES.md`).
- **`data/`** — downloaded/produced data (git-ignored).
- **`posts/`** — the blog drafts (start with `posts/01-duckdb-from-zero.md`).

## Post 1 — DuckDB from zero

Dataset: 2023 Dutch railway services (**21.2M rows, 330 MB gzipped CSV**) from the DuckDB blog
[_Analyzing Railway Traffic in the Netherlands_](https://duckdb.org/2024/05/31/analyzing-railway-traffic-in-the-netherlands).

Flow: **get it in via dlt** (`ingestion/`) → **explore in DuckDB** (`queries/`) → **write it up**
(`posts/`).
