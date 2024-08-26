import { readFileSync, writeFileSync } from "fs";
import { OpenAPIV3 } from "openapi-types";
import { basename, dirname, join, resolve } from "path";

export const padSingleOneOfWithNullable = (
  schema: OpenAPIV3.SchemaObject | OpenAPIV3.ReferenceObject
): OpenAPIV3.SchemaObject | OpenAPIV3.ReferenceObject => {
  if (schema && typeof schema === "object" && !("$ref" in schema)) {
    for (const key in schema) {
      const value = schema[key as keyof OpenAPIV3.SchemaObject];
      if (key === "oneOf" && Array.isArray(value) && value.length === 1) {
        if ("nullable" in schema) {
          console.log(
            `Schema has nullable property and single element in oneOf. Padding with additional null element`,
            schema
          );
          schema["oneOf"] = [
            ...value,
            {
              type: "null",
            },
          ];
        }

        return schema;
      } else if (typeof value === "object" && value !== null) {
        schema[key as keyof OpenAPIV3.SchemaObject] =
          padSingleOneOfWithNullable(value);
      }
    }
  } else if (Array.isArray(schema)) {
    for (let i = 0; i < schema.length; i++) {
      schema[i] = padSingleOneOfWithNullable(schema[i]);
    }
  }
  return schema;
};

export const cleanSchemas = (schemas: {
  [schemaName: string]: OpenAPIV3.SchemaObject | OpenAPIV3.ReferenceObject;
}): {
  [schemaName: string]: OpenAPIV3.SchemaObject | OpenAPIV3.ReferenceObject;
} => {
  console.log("Cleaning schemas...");

  const cleanedSchemas: {
    [schemaName: string]: OpenAPIV3.SchemaObject | OpenAPIV3.ReferenceObject;
  } = {};
  for (const schemaName in schemas) {
    console.log(`Cleaning schema: ${schemaName}`);
    cleanedSchemas[schemaName] = padSingleOneOfWithNullable(
      schemas[schemaName]!
    );
  }
  return cleanedSchemas;
};

export const cleanOpenAPISpec = (
  openapiSpec: OpenAPIV3.Document
): OpenAPIV3.Document => {
  if (openapiSpec.components && openapiSpec.components.schemas) {
    openapiSpec.components.schemas = cleanSchemas(
      openapiSpec.components.schemas
    );
  }
  return openapiSpec;
};

const run = () => {
  const args = process.argv.slice(2);
  if (args.length !== 1) {
    console.error("Usage: npx ts-node pre-process-schema.ts <filename>");
    process.exit(1);
  }

  const filename = args[0];

  const filePath = resolve(filename);

  try {
    const data = readFileSync(filePath, "utf-8");
    const openapiSpec: OpenAPIV3.Document = JSON.parse(data);

    const cleanedSpec = cleanOpenAPISpec(openapiSpec);

    const outputFilename = basename(filename);
    const outputPath = join(dirname(filename), outputFilename);

    writeFileSync(outputPath, JSON.stringify(cleanedSpec, null, 2), "utf-8");
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

run();
