# Implementation Plan: Support for Negative Numbers

**Branch**: `003-negative-numbers` | **Date**: 2026-03-09 | **Spec**: [specs/003-negative-numbers/spec.md](spec.md)
**Input**: Feature specification from `/specs/003-negative-numbers/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Enable support for entering and calculating with negative numbers by implementing a `toggleSign()` function in the `CalculatorEngine` state and exposing a `+/-` button on the UI, relying on native Dart double string parsing to manage math execution.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart 3.11 / Flutter  
**Primary Dependencies**: Flutter, Provider  
**Storage**: N/A  
**Testing**: flutter_test (Widget/Unit Tests)  
**Target Platform**: Cross-platform (Android, iOS, Windows, Web)
**Project Type**: single  
**Performance Goals**: Instantaneous UI updates  
**Constraints**: Basic negative parsing handling  
**Scale/Scope**: 2 active files

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Widget-Driven Architecture**: Yes, `+/-` button will reuse `OperationButton`.
- **Test-First Reliability**: Yes.
- **State & Logic Separation**: Yes, `CalculatorEngine` keeps numeric logic.
- **Lint & Style Compliance**: Yes.

## Project Structure

### Documentation (this feature)

```text
specs/003-negative-numbers/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
lib/
└── src/
    └── calculator/
        ├── logic/
        │   └── calculator_engine.dart
        └── presentation/
            └── widgets/
                └── calculator_grid.dart

test/
└── widget/
    └── calculator_grid_test.dart (ensure coverage)
└── logic/
    └── calculator_engine_test.dart
```

**Structure Decision**: Single Flutter project structure, following Provider patterns separated into `logic` and `presentation`. We will be modifying existing files.

## Complexity Tracking

> **No violations identified.**
