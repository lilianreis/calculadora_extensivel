# Data Model: Decimal Numbers Support

## Entities

*No new database entities or JSON models are introduced.*

### Application State (CalculatorState)

The calculator state currently manages the operand strings.

#### Changes needed

Instead of parsing an operand as `int.parse(operand)`, the engine will need to handle decimal strings:
- The input string may contain a comma `,`.
- When appending a comma:
    - If the current string does not contain a comma, append `,`.
    - If the current string is empty or equal to `-`, append `0,` or `-0,`.
    - If the current string already contains a comma, ignore the input.

### Parsing for Calculation (CalculatorEngine)

- To evaluate `operand1 + operand2`, `NumberFormat` or `string.replaceAll(',', '.')` will be used before running `double.parse()`.
- Once the result is a `double`, format it to string, handling trailing `.0` naturally, and replacing `.` back to `,` for UI display.
- To prevent loss of precision, `CalculatorEngine` might need to check the number of decimal places or use `BigDecimal` / `Decimal` packages if basic `double` precision proves insufficient. For Basic operations, `double` might suffice.

## Validation Rules

1. **Max Length**: A number cannot exceed 15 characters (already implemented, needs to be verified if the comma counts towards this).
2. **Duplicate Comma**: A comma cannot be added more than once per operand.
