# smb-duckdb-lakehouse-lab

A **build-in-public** lab: a cheap, cloud-agnostic lakehouse for small/medium businesses with
**DuckDB as the core engine** — DuckLake + dlt + dbt-duckdb + Polars, portable across object
storage and Azure. Companion code for the DatomIQ blog series; each post = one buildable milestone.

> Why DuckDB, not "why not Databricks": Databricks stays the escape hatch for genuinely
> big/distributed jobs. This series is about the many SMB cases where a whole lakehouse fits on
> one node — so compute is ephemeral and near-free, and you only pay for storage + a small catalog.

## Setup

```bash
uv sync                       # install duckdb, polars, pyarrow
bash scripts/download_data.sh # fetch the NL railway datasets into data/
```

(No `uv`? `pip install duckdb polars pyarrow` works too.)

## Posts

| # | Post | Code |
|---|---|---|
| 1 | DuckDB from zero — and why it exists | `queries/01_duckdb_from_zero.sql`, `src/duckdb_from_zero.py`, `posts/01-duckdb-from-zero.md` |

### Post 1 — run it

```bash
# SQL, in the DuckDB CLI:
duckdb < queries/01_duckdb_from_zero.sql

# or the Python version (adds the DuckDB⇄Polars zero-copy handoff):
uv run src/duckdb_from_zero.py
```

Dataset: 2023 Dutch railway services — **21.2M rows in a 330 MB gzipped CSV** — from the DuckDB
blog [_Analyzing Railway Traffic in the Netherlands_](https://duckdb.org/2024/05/31/analyzing-railway-traffic-in-the-netherlands).
