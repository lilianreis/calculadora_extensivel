# Implementation Plan: Bhaskara Operation

**Branch**: `002-calc-bhaskara` | **Date**: 2026-03-07 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/002-calc-bhaskara/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement the Bhaskara quadratic equation calculation ($x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$) as an extra operation in the calculator. It will handle 3 variables input sequentially through the operation button, and display a user-friendly error when the determinant is negative.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart with Flutter ^3.11.0
**Primary Dependencies**: provider ^6.1.2, cupertino_icons
**Storage**: N/A  
**Testing**: flutter_test
**Target Platform**: Android, iOS, Windows, Web, macOS, Linux
**Project Type**: mobile/web/desktop  
**Performance Goals**: Standard Flutter app performance
**Constraints**: Minimal existing UI mutation.
**Scale/Scope**: 1 extra calculation operation with 3 internal numeric states.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- [x] **I. Widget-Driven Architecture**: The UI changes will be minimally invasive and contained within existing or new reusable widgets.
- [x] **II. Test-First Reliability**: We will add tests for the Bhaskara calculation logic in the domain layer.
- [x] **III. State & Logic Separation**: The 3 variables state and calculation will be handled mostly in the `calculator_engine` or `calculator_state`, separate from the UI.
- [x] **IV. Lint & Style Compliance**: Changes will strictly adhere to `flutter_lints`.
- [x] **V. Asset & Localization Discipline**: Any error strings will not be hardcoded directly into logic if possible, though a simple app may use straight strings for now.

## Project Structure

### Documentation (this feature)

```text
specs/002-calc-bhaskara/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
lib/
├── main.dart
└── src/
    └── calculator/
        ├── domain/
        │   ├── operations/
        │   │   ├── ...
        │   │   └── bhaskara_operation.dart  # [NEW]
        │   ├── operation.dart
        │   └── operations_registry.dart
        ├── logic/
        │   ├── calculator_engine.dart       # [MODIFY]
        │   └── calculator_state.dart        # [MODIFY]
        └── presentation/
            ├── calculator_screen.dart       # [MODIFY]
            └── widgets/
                ├── ...
                └── calculator_button.dart
```

**Structure Decision**: The project uses a single app structure mapped to domain, logic, and presentation directories under `lib/src/calculator`. We will add the `bhaskara_operation.dart` in the domain package, and update the logic/presentation layers to handle the 3-input sequencing.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |
