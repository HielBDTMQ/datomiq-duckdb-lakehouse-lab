"""Post 1 — DuckDB from zero, with the DuckDB<->Polars zero-copy handoff.

Run: uv run src/duckdb_from_zero.py   (after scripts/download_data.sh)

The DatomIQ angle beyond the DuckDB blog: DuckDB and Polars both speak Apache Arrow, so moving
data between them is a zero-copy pointer pass, not a serialize/deserialize round-trip. That makes
"SQL for the heavy lifting, Polars for the imperative bits" essentially free.
"""

from __future__ import annotations

import duckdb
import polars as pl

CSV = "data/services-2023.csv.gz"


def main() -> None:
    con = duckdb.connect()  # in-process, no server

    # 1. DuckDB reads the 330 MB gzipped CSV directly. Keep it as a lazy relation.
    services = con.sql(f"FROM '{CSV}'")
    total = con.sql(f"SELECT count(*) FROM '{CSV}'").fetchone()[0]
    print(f"rows: {total:,}")

    # 2. Aggregate in DuckDB (fast, out-of-core), then hand the small result to Polars.
    #    NOTE: swap in the real station column after inspecting `DESCRIBE` (see the .sql file).
    busiest = con.sql(
        '''
        SELECT "Stop:Station name" AS station, count(*) AS num_services
        FROM services
        GROUP BY ALL
        ORDER BY num_services DESC
        LIMIT 10
        '''
    )

    # 3. Zero-copy DuckDB -> Polars (via Arrow). No CSV, no copy.
    df: pl.DataFrame = busiest.pl()
    print(df)

    # 4. ...and back: DuckDB can query a Polars DataFrame by name (replacement scan).
    top = con.sql("SELECT station FROM df ORDER BY num_services DESC LIMIT 1").fetchone()[0]
    print(f"busiest station: {top}")


if __name__ == "__main__":
    main()
