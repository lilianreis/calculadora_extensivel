# Tasks: Support for Negative Numbers

**Input**: Design documents from `/specs/003-negative-numbers/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Verify project structure aligns with implementation plan requirements

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T002 Identify optimal placement for the `+/-` toggle button within `lib/src/calculator/presentation/widgets/calculator_grid.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Enter Negative Values (Priority: P1) 🎯 MVP

**Goal**: Allow users to input a negative number indicator to start a calculation or toggle an existing input's sign.

**Independent Test**: Attempt to input a negative number at the start of a calculation and verify the display reflects the negative value.

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T003 [P] [US1] Write unit test for `toggleSign` behavior in `test/logic/calculator_engine_test.dart`
- [x] T004 [US1] Write widget test verifying `+/-` button toggles display sign in `test/widget/calculator_grid_test.dart`

### Implementation for User Story 1

- [x] T005 [P] [US1] Implement `toggleSign()` logic in `lib/src/calculator/logic/calculator_engine.dart` (ensure handling of "0" and "Error" scenarios)
- [x] T006 [US1] Add `+/-` `OperationButton` to UI in `lib/src/calculator/presentation/widgets/calculator_grid.dart`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Operations with Negative Numbers (Priority: P1)

**Goal**: Perform arithmetic operations (addition, subtraction, multiplication, division) using negative numbers and get mathematical results.

**Independent Test**: Perform a basic operation like `5 + -3` and verify the result is `2`.

### Tests for User Story 2

- [x] T007 [US2] Write unit tests for operations involving negative operands in `test/logic/calculator_engine_test.dart`

### Implementation for User Story 2

- [x] T008 [P] [US2] Verify and adjust natively correct Dart string parsing for negative results handling inside `lib/src/calculator/logic/calculator_engine.dart` `_calculate()` method if needed (per research.md, it should require no logic change beyond verification)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T009 Refactor `toggleSign()` error-prevention redundancy if necessary
- [x] T010 Perform manual comprehensive testing of sequential negative operations

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User Story 1 (P1) and User Story 2 (P1) should execute sequentially relative to engine logic testing.
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2).
- **User Story 2 (P1)**: Integrates heavily with User Story 1 state changes.

### Within Each User Story

- Tests (if included) MUST be written and FAIL before implementation
- Logic before presentation 
- Core implementation before integration

### Parallel Opportunities

- Tests (T003) and T005 logic can be developed conceptually in parallel before integration.
