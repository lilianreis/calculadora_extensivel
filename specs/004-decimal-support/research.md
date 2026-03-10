# Research Notes: Decimal Numbers Support

## Topic: Parsing and Formatting Decimal Numbers with Comma in Dart

### Decision
Use string manipulation for comma input, then replace `,` with `.` for Dart's internal `double.parse()` when performing calculations, and replace `.` back to `,` when displaying the result.

### Rationale
Dart's native `double.parse()` requires a period (`.`) as the decimal separator. Converting the user-facing comma to a period before parsing is the simplest and most robust way to calculate the values. When converting the `CalculationResult` back to string, we can format it and replace the period with a comma. 

### Alternatives considered
- Using the `intl` package: The `NumberFormat` class from the `intl` package can parse and format numbers according to locales. While more robust for i18n, adding a dependency just for this feature might violate the simplicity of the current calculator. String replacement is O(N) where N is very small (number length), making it perfectly acceptable.

## Topic: Adding the Comma Button to the UI

### Decision
Modify the `CalculatorGrid` widget to include the `.` (or `,`) button. If the grid is dynamically generated, add `,` to the list of buttons.

### Rationale
The grid handles all inputs. Extending it with a comma button is natural and follows the existing architecture.

### Alternatives considered
- Creating an entirely separate row for the comma. Rejected as standard calculators place the decimal point next to the zero.
