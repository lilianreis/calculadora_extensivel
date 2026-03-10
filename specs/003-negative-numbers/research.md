# Phase 0: Research for Negative Numbers

## Introduction
The goal of this research phase is to determine how to satisfy the requirements outlined in the feature specification for negative numbers within the existing Dart/Flutter and Provider-based architecture.

## Technical Unknowns and Best Practices

### 1. How to handle the state of a negative number?
- **Analysis**: The calculator state (`CalculatorState`) stores the current input as a string in `display` and parsed values in `accumulator` (or `bhaskaraA/B`). The `double.tryParse` method in Dart naturally supports strings starting with `-` (e.g., `"-5"` parses to `-5.0`).
- **Decision**: Represent negative numbers by prepending a minus sign (`"-"`) to the current `display` string.
- **Rationale**: Minimal state changes are required. We avoid creating complex new state fields for "sign". The Dart built-in string-to-double parsing works natively with standard minus signs.

### 2. How to implement the sign toggle action?
- **Analysis**: The sign toggle is an immediate action on the current operand rather than an `Operation` that waits for a second operand or evaluates an expression.
- **Decision**: Add a new method `toggleSign()` directly on the `CalculatorEngine`.
- **Rationale**: The engine handles string manipulation of the display during number input. A `toggleSign` method can flip the negative sign string directly and notify listeners without convoluting the `pendingOperation` pattern.

### 3. Where to place the user interface for the toggle?
- **Analysis**: The `CalculatorGrid` has 16 cells in the main grid plus a row for extra operations.
- **Decision**: Add a `+/-` `OperationButton` directly in the `CalculatorGrid`, perhaps substituting an existing setup or appending to the extra operations, or adding another row. Given the grid currently uses a 4-column layout filled out perfectly, appending a new row exclusively for `+/-` and perhaps future modifiers (like `.`) or adding it to the `extraOps` style wrap is ideal. We will add `+/-` below the extra operations wrap.
- **Rationale**: Keeps the primary grid clean.

### 4. Edge Cases - Toggling 0 and Error states
- **Analysis**: It makes no mathematical sense to have `"-0"`.
- **Decision**: The `toggleSign()` method must verify if the current display is purely `"0"` and ignore the toggle. It must also ignore toggling if the state is in an `"Error"` condition.

## Conclusion
The implementation is straightforward. We will update `CalculatorEngine` state manipulation logic and add a button to `CalculatorGrid`. This meets all `spec.md` requirements seamlessly.
