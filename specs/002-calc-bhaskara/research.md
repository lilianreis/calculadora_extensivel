# Research: Bhaskara Operation

## 1. Input Mapping and UI Pattern

**Decision**: The operation will be treated as a composite or special-state operation. Let's reuse the logic in `CalculatorEngine` by introducing an intermediate state that expects sequential inputs, pressing the "Bhaskara" key (e.g. `bhaskara`) to advance. Wait for 'a', then push operation -> clear display -> wait 'b' -> clear display -> wait 'c' -> Calculate.

**Rationale**: The spec requires the user to input the variables *sequentially*, using the operation button to advance to the next variable. This minimizes UI changes (no extra buttons needed other than the Bhaskara trigger).

**Alternatives considered**: 
- A dialog/modal (rejected, goes against minimizing UI changes and sequential prompt requirement).

## 2. Returning Two Values (Roots)

**Decision**: The Bhaskara operation will return a formatted string like `x1: 2.0, x2: 1.0`, or push the values to a structured output if the `Operation` class allows strings, otherwise the display state will need to handle a custom string output. Since it's a calculator, the screen might just need to display the roots as text.

**Rationale**: `Operation` interface usually returns a `double` or a `num`. Handling 2 roots needs a special return type (like a custom `Result` object) or formatting into the calculator display.

**Alternatives considered**:
- Return only `x1` with an option to toggle to `x2` (rejected as it adds complexity to the UI).

## 3. Negative Determinant

**Decision**: Throw a specific `StateError` or `ArgumentError` (e.g., `BhaskaraNegativeDeltaException`) in the domain layer arithmetic. The engine will catch this error and set the display string to an error message like `"Error: Delta < 0"`.

**Rationale**: Adheres to the FR-006 requirement to provide a clean message without crashing.

*All unknowns resolved.*
