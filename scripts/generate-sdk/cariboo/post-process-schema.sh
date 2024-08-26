#!/bin/sh

echo "Replacing nullable() with nullish() so these properties can be null | undefined..."
sed -i '' 's/nullable(/nullish(/g' "${SDK_FILE}"

# z.union(enum, z.null).int()
#                        ^----- this is a problem
# So:
echo "Drop qos properties, as SDK generator does not work with them yet"
sed -i '' '/qos: z.union(/d' "${SDK_FILE}"
