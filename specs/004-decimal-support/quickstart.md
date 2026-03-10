# Quickstart: Decimal Numbers Support

## Feature Overview
Adds support for decimal numbers using a comma (`,`) separator to the standard calculator logic and UI.

## Getting Started

1. Check out the feature branch: `git checkout 004-decimal-support`.
2. Review the spec in `specs/004-decimal-support/spec.md`.
3. Open `lib/src/calculator/logic/calculator_engine.dart` and `lib/src/calculator/presentation/widgets/calculator_grid.dart`.
4. Run the tests: `flutter test`
5. Test manually by running the app and trying `1,5 + 2,5`.

## Key Files
- `CalculatorEngine` (`lib/src/calculator/logic/calculator_engine.dart`): Manages the calculation logic. Parse comma by replacing with dot, then replacing back when displaying.
- `CalculatorGrid` (`lib/src/calculator/presentation/widgets/calculator_grid.dart`): Handles UI output, needs a new `,` button.
