#!/bin/sh
set -e
set -eo pipefail

BASE_DIR="$(dirname "$0")"

# Get SDK_NAME from cli params:
SDK_NAME="$1"
if [ -z "$SDK_NAME" ]; then
    echo "Please provide a valid SDK name as first parameter. Example: generate-sdk.sh cariboo"
    exit 1
fi
if [ ! -d "${BASE_DIR}/${SDK_NAME}" ]; then
    echo "No directory for SDK \"${SDK_NAME}\" found."
    exit 2
fi

SCHEMA_FILE="$(mktemp)"
SDK_FILE="${BASE_DIR}/../../src/lib/sdk/${SDK_NAME}/client.ts"
HANDLEBAR_TEMPLATE_FILE="${BASE_DIR}/${SDK_NAME}/template.hbs"

# Load SDK-specific config:
. "${BASE_DIR}/${SDK_NAME}/config.sh"
if [ -z "${OPEN_API_SCHEMA_URL}" ]; then
    echo "Config for ${SDK_NAME} did not export OPEN_API_SCHEMA_URL as expected."
    exit 3
fi

# Make variables available to shell scripts down the road:
export SDK_FILE
export SCHEMA_FILE
export SDK_NAME

echo ""
echo "================================"
echo "Generate SDK \"${SDK_NAME}\""
echo "================================"
echo ""
echo "🛜 Download OpenAPI Schema to ${SCHEMA_FILE}"
curl "${OPEN_API_SCHEMA_URL}" -o "${SCHEMA_FILE}"

if [ -f "${BASE_DIR}/${SDK_NAME}/pre-process-schema.sh" ]; then
    echo ""
    echo "================================"
    echo "🦑 Preprocess OpenAPI Schema for ${SDK_NAME}"
    "${BASE_DIR}/${SDK_NAME}/pre-process-schema.sh"
fi

echo ""
echo "================================"
echo "🦑 Generate SDK for ${SDK_NAME} from ${SCHEMA_FILE}"
"${BASE_DIR}/../../node_modules/.bin/openapi-zod-client" \
    "${SCHEMA_FILE}" \
    -t "${HANDLEBAR_TEMPLATE_FILE}" \
    -o "${SDK_FILE}" \
    --with-docs \
    --export-schemas \
    --implicit-required \
    --additional-props-default-value=false


if [ -f "${BASE_DIR}/${SDK_NAME}/post-process-schema.sh" ]; then
    echo ""
    echo "================================"
    echo "🦑 Postprocess OpenAPI Schema for ${SDK_NAME}"
    "${BASE_DIR}/${SDK_NAME}/post-process-schema.sh"
fi

echo ""
echo "================================"
echo "🧹 Cleanup ${SCHEMA_FILE}"
rm "$SCHEMA_FILE"

echo ""
echo "================================"
echo "✅ SDK Generated"
