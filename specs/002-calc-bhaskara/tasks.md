# Tasks: Bhaskara Operation

**Input**: Design documents from `/specs/002-calc-bhaskara/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `lib/`, `test/` at repository root

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

There are no shared infrastructure setup tasks required for this feature, as it utilizes the existing calculator application foundation.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T001 Setup `bhaskara_operation.dart` scaffold in `lib/src/calculator/domain/operations/bhaskara_operation.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Standard Bhaskara Calculation (Priority: P1) 🎯 MVP

**Goal**: Calculate the roots of a quadratic equation using the Bhaskara formula so that the user can quickly find the values of x.

**Independent Test**: Can be fully tested by inputting valid values for variables $a$, $b$, and $c$, and verifying that the correct roots are displayed.

### Tests for User Story 1 ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T002 [P] [US1] Create unit test for `BhaskaraOperation` standard calculation in `test/domain/operations/bhaskara_operation_test.dart`
- [ ] T003 [P] [US1] Create unit test for `CalculatorEngine` sequence input state in `test/logic/calculator_engine_test.dart`
- [x] T015 [P] [US1] Create widget/integration test for standard Bhaskara calculation UI flow in `test/presentation/bhaskara_integration_test.dart`

### Implementation for User Story 1

- [x] T004 [US1] Implement standard root calculation logic in `lib/src/calculator/domain/operations/bhaskara_operation.dart`
- [x] T005 [US1] Register `BhaskaraOperation` in `lib/src/calculator/domain/operations_registry.dart`
  - [x] T006 [P] [US1] Update `CalculatorState` properties for Bhaskara sequencing in `lib/src/calculator/logic/calculator_state.dart`
- [x] T007 [US1] Implement input sequencing logic (capturing A, B, C) in `lib/src/calculator/logic/calculator_engine.dart`
- [x] T016 [US1] Implement state reset/cancellation logic when clearing or changing operations in `lib/src/calculator/logic/calculator_engine.dart`
- [x] T008 [US1] Format the `CalculatorScreen` output to display the results or active Bhaskara variable state in `lib/src/calculator/presentation/calculator_screen.dart`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Negative Determinant Error Handling (Priority: P1)

**Goal**: Inform the user when the calculation cannot be completed due to a negative determinant (delta < 0).

**Independent Test**: Can be tested by providing values that result in a negative delta and ensuring a user-friendly error message is displayed.

### Tests for User Story 2 ⚠️

- [x] T009 [P] [US2] Update unit tests to expect negative determinant error in `test/domain/operations/bhaskara_operation_test.dart`
- [x] T010 [P] [US2] Update engine tests for negative determinant UI formatting in `test/logic/calculator_engine_test.dart`
- [x] T017 [P] [US2] Update widget/integration test for negative determinant path in `test/presentation/bhaskara_integration_test.dart`

### Implementation for User Story 2

- [x] T011 [P] [US2] Implement negative determinant and zero-$a$ validation checks in `lib/src/calculator/domain/operations/bhaskara_operation.dart`
- [x] T012 [US2] Update `CalculatorEngine` to catch validation exceptions and set the display to an error message in `lib/src/calculator/logic/calculator_engine.dart`

**Checkpoint**: User Stories 1 AND 2 should both work independently.

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T013 Verify that existing calculator tests pass without regression
- [x] T014 Run formatting and linting (`dart format lib test` and `flutter analyze`)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Can start immediately
- **Foundational (Phase 2)**: BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - US2 builds closely upon US1's engine modifications, so US1 should ideally be completed before US2.

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2).
- **User Story 2 (P1)**: Extends US1, should be done alongside or immediately after US1.

### Parallel Opportunities

- Tests within the same User Story can be implemented in parallel.
- Foundational scaffolding (T001) can be done while tests are being written.
- Unit testing and State definitions (T006) can decouple from the calculation logic (T004).
