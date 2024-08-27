# From <br/>Open API Schema To <br/>TypeScript SDK
## @Inside Labs

---
# Why?

- Manual SDK-creation is
	- Time and maintenance intensive
	- Prone to failure
- A shared source of truth
	- You know your API best
	- Less room to interpret API surface on our side
- Efficiency
	- Initial creation is a push of a button
	- Recreation after updates is straight-forward (less trail and error)
- Engineering Excellence
	- Type-safety for:
		- Endpoints
		- Actual JSON exchange: No more guessing/believing/"trusting" about data

---
# How?

/assets/pako_eNpVUMtqwzAQ_BWxpxTiH_ChkBIopSkt9a1WDoq0lkWsldCjEEL-vRsnLu1NszOzM9oz6GAQWrBJxVHsPiVJyhH16j0ibT5eRMfgQZJFwqRKSH3fbV_F8wL3-9lRD7cFmxgnp1VxgadCZHNcsZz9shxqdoQ574J1un-6IzFDXoJklmzRNI_iN_BPNhPLHPOs4gD2mOOVkRBT-HaGqXKK2GQ1oOAvMAwSZvm_DkISrMFj8soZPsH52.svg
background: true
size: contain



1. All starts with your Open API schema
2. We download it, and put it to a code generator
3. The code generator creates a TypeScript-based SDK. SDK contains:
	- Types for requests and responses
	- All CRUD endpoints
4. We use the SDK in our applications business logic

---

## Tool Stack

##### 🆎 ==[TypeScript](https://www.typescriptlang.org/)== Statically typed JavaScript
##### 🧩 [==zod==](https://zod.dev/) Type-safe JSON Parsers
##### ⚙️ ==[openapi-zod-client](https://github.com/astahmer/openapi-zod-client)== TypeScript SDK Generator
##### ... and some ✨ ==Shell Script== magic 😉

---
# Demo Time

#### 1️⃣ ==SDK== Generation

#### 2️⃣ ==JSON== Parsing

---
# Questions?

---
# Thank You 🙏



