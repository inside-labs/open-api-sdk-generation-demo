import { createApiClient } from "./lib/sdk/cariboo/client.js";

const SURSELVA_PRODUCTION_URL = "https://surselva.cariboo.tech";

try {
  const cariboo = createApiClient(SURSELVA_PRODUCTION_URL);

  const offers = await cariboo.getPrices({
    id: 801, // Wanderticket, Brigels Burleun Retour
    persons: [{ person_id: 2, quantity: 1 }], // 1x Erwachsen
    from: "2024-09-20",
    to: "2024-09-22",
  });

  console.log(JSON.stringify(offers, null, 2));
} catch (e) {
  console.error(JSON.stringify(e));
}
