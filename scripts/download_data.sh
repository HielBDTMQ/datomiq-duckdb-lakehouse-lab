#!/usr/bin/env bash
# Download the NL railway datasets used in post 1 (from the DuckDB blog, 2024-05-31).
set -euo pipefail
cd "$(dirname "$0")/../data"
echo "Downloading NL railway services 2023 (~330 MB gzipped CSV)…"
curl -L -O https://blobs.duckdb.org/nl-railway/services-2023.csv.gz
echo "Downloading station metadata + tariff distances…"
curl -L -O https://blobs.duckdb.org/data/stations-2022-01.csv
curl -L -O https://blobs.duckdb.org/data/tariff-distances-2022-01.csv
echo "Done → $(pwd)"
