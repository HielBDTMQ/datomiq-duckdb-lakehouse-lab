-- Post 1 — DuckDB from zero.
-- Run: duckdb < queries/01_duckdb_from_zero.sql   (assumes scripts/download_data.sh has run)
-- The point: 21M rows, 330 MB gzipped CSV, queried on a laptop with zero setup — no server,
-- no import job, no schema. This is *why DuckDB exists*.

-- 1. Load a 330 MB gzipped CSV directly. DuckDB decompresses + sniffs the schema for you.
CREATE OR REPLACE TABLE services AS
    FROM 'data/services-2023.csv.gz';

SELECT count(*) AS rows FROM services;          -- ~21,239,393

-- 2. Look before you leap — DuckDB's friendly inspection commands.
DESCRIBE services;                              -- inferred columns + types
SUMMARIZE services;                             -- min/max/nulls/approx-distinct per column

-- 3. FROM-first + GROUP BY ALL (DuckDB "friendly SQL"): busiest stations.
--    NOTE: replace "Stop:Station name" with the real column from DESCRIBE above.
SELECT "Stop:Station name" AS station, count(*) AS num_services
FROM services
GROUP BY ALL
ORDER BY num_services DESC
LIMIT 10;

-- 4. A window function: top-3 stations per month.
--    Adjust the date column name to match DESCRIBE.
-- SELECT month, station, num_services FROM (
--     SELECT strftime("Service:Date", '%Y-%m') AS month,
--            "Stop:Station name"               AS station,
--            count(*)                          AS num_services,
--            rank() OVER (PARTITION BY month ORDER BY count(*) DESC) AS rnk
--     FROM services GROUP BY ALL
-- ) WHERE rnk <= 3 ORDER BY month, rnk;

-- 5. Query a REMOTE Parquet file — DuckDB pulls only the bytes it needs (HTTP range reads),
--    ~20 MB over the wire instead of the whole 309 MB file.
SELECT count(*) AS remote_rows
FROM 'https://blobs.duckdb.org/nl-railway/services-2023.parquet';

-- 6. Export gold to Parquet — one line, the lakehouse storage format.
-- COPY (SELECT * FROM services USING SAMPLE 1000) TO 'data/sample.parquet' (FORMAT parquet);
