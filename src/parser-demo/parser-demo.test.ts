import z from "zod";

const Person = z.object({
  firstName: z.string(),
  lastName: z.string(),
});
type Person = z.infer<typeof Person>;

describe("Person Parser", () => {
  test("parses a full person JSON", () => {
    const fullJson = {
      firstName: "Han",
      lastName: "Solo",
    };

    const person: Person = Person.parse(fullJson);
    expect(person).toEqual({
      firstName: "Han",
      lastName: "Solo",
    });
  });

  test("can parse a person JSON without first name", () => {
    const jsonWithoutFirstName = {
      lastName: "Solo",
    };

    const person: Person = Person.parse(jsonWithoutFirstName);
    expect(person).toEqual({
      lastName: "Solo",
    });
  });
});
