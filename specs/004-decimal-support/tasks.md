# Implementation Tasks: Decimal Numbers Support

## Pre-requisites
- [x] Review the `spec.md` and `plan.md`.

## Phase 1: Logic Implementation
- [x] Update `CalculatorEngine` to parse `,` as decimal separator. Implement `isDecimal` check and logic to prevent multiple commas.
- [x] Add unit tests for `CalculatorEngine` to verify decimal handling (FR-004, FR-005, FR-006, FR-007, FR-008).

## Phase 2: UI Implementation
- [x] Update `CalculatorGrid` to add the `,` button.
- [x] Add widget tests for `CalculatorGrid` to ensure the comma button is rendered and triggers the correct event.

## Phase 3: Integration & QA
- [x] Verify UI tests and unit tests pass.
- [x] Perform manual testing to ensure "1,5 + 2,5 = 4" works correctly.
