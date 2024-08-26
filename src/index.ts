import { createApiClient } from "./lib/sdk/cariboo/client.js";

try {
  const client = createApiClient("https://surselva.cariboo.tech");
  const result = await client.getSkiticketData();
  console.log(JSON.stringify(result, null, 2));
} catch (e) {
  console.error(JSON.stringify(e));
}
