#!/bin/sh
BASE_DIR="$(dirname "$0")"

"${BASE_DIR}/../../../node_modules/.bin/ts-node-esm" \
    "${BASE_DIR}/pre-process-schema.ts" \
    "${SCHEMA_FILE}"
