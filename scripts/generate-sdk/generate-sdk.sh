#!/bin/sh

BASE_DIR="$(dirname "$0")"
OPEN_API_SCHEMA_URL="https://surselva.cariboo.dev/api/api-docs/api-docs.json"
SCHEMA_FILE="$(mktemp)"

SDK_NAME="cariboo"
SDK_FILE="${BASE_DIR}/../../src/lib/sdk/${SDK_NAME}/client.ts"
HANDLEBAR_TEMPLATE_FILE="${BASE_DIR}/${SDK_NAME}/template.hbs"

echo ""
echo "================================"
echo "Generate SDK \"${SDK_NAME}\""
echo "================================"
echo ""
echo "🛜 Download OpenAPI Schema to ${SCHEMA_FILE}"
curl "${OPEN_API_SCHEMA_URL}" -o "${SCHEMA_FILE}"

echo ""
echo "================================"
echo "🦑 Preprocess OpenAPI Schema"
"${BASE_DIR}/../../node_modules/.bin/ts-node-esm" \
    "${BASE_DIR}/${SDK_NAME}/pre-process-schema.ts" \
    "${SCHEMA_FILE}"

echo ""
echo "================================"
echo "🦑 Generate SDK for ${SDK_NAME} from ${SCHEMA_FILE}"
"${BASE_DIR}/../../node_modules/.bin/openapi-zod-client" \
    "${SCHEMA_FILE}" \
    -t "${HANDLEBAR_TEMPLATE_FILE}" \
    -o "${SDK_FILE}" \
    --export-schemas \
    --implicit-required \
    --additional-props-default-value=false

echo ""
echo "================================"
echo "🦑 Postprocess OpenAPI Schema"
echo "Replacing nullable() with nullish() so these properties can be null | undefined..."
sed -i '' 's/nullable(/nullish(/g' "${SDK_FILE}"

echo ""
echo "================================"
echo "🧹 Cleanup ${SCHEMA_FILE}"
rm "$SCHEMA_FILE"

echo ""
echo "================================"
echo "✅ SDK Generated"
