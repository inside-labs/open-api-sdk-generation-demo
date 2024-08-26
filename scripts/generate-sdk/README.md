# Generate Zod-based SDK From An Open API Schema

## cariboo

> 🚨 **Please, remember: generate schema only when it's absolutely necessary - SPOT's types are very unstable and we often have to patch them up manually.**

In order to generate the Open API zod-based SDK for cariboo, we have created two files - one responsible for the shape of the generated file and one responsible for the generation and the cleanup.

1. File responsible for how the file storing generated SDK will look like is called `cariboo-template.hbs`. It's a handlebars template describing things such as shape of the type objects, shape of the schema objects, how will we generate endpoints, and so on. If you see need to add some sort of functionality to the generated file, find more details [here](https://github.com/astahmer/openapi-zod-client?tab=readme-ov-file).

2. File responsible for the actual generation of the SDK is a bash script that downloads the schema in a JSON file, uses the [Open Api Zod Client](https://github.com/astahmer/openapi-zod-client?tab=readme-ov-file) library which generates our client and then does the clean up by removing the JSON file.
