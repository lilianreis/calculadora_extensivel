# Feature Specification: Support for Negative Numbers

**Feature Branch**: `003-negative-numbers`  
**Created**: 2026-03-09  
**Status**: Draft  
**Input**: User description: "implemente suporte para numero negativo"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Enter Negative Values (Priority: P1)

As a calculator user, I want to be able to input negative numbers so that I can perform mathematical operations involving values less than zero.

**Why this priority**: Fundamental requirement for any standard calculator to support a full range of real numbers.

**Independent Test**: Can be fully tested by attempting to input a negative number at the start of a calculation and verifying the display reflects the negative value.

**Acceptance Scenarios**:

1. **Given** an empty or starting calculator display, **When** the user inputs the negative sign indicator followed by a number (e.g., '5'), **Then** the display should show '-5'.
2. **Given** an existing positive number on the display (e.g., '5'), **When** the user triggers the sign toggle, **Then** the display should change to '-5'.
3. **Given** an existing negative number on the display (e.g., '-5'), **When** the user triggers the sign toggle, **Then** the display should change to '5'.

---

### User Story 2 - Operations with Negative Numbers (Priority: P1)

As a user, I want to perform arithmetic operations (addition, subtraction, multiplication, division) using negative numbers so that I get correct mathematical results.

**Why this priority**: Entering a negative number is useless if it cannot be used in calculations.

**Independent Test**: Can be fully tested by performing a basic operation like `5 + -3` and checking if the result is `2`.

**Acceptance Scenarios**:

1. **Given** a calculation involving a negative number (e.g., '-5 + 3'), **When** the calculation is executed, **Then** the correct mathematical result should be returned ('-2').
2. **Given** a calculation involving two negative numbers (e.g., '-5 * -2'), **When** the calculation is executed, **Then** the correct mathematical result should be returned ('10').

---

### Edge Cases

- What happens when the user tries to toggle the sign of '0'? (Should remain '0')
- How does the system handle toggling the sign in the middle of typing a decimal number (e.g., '5.5')?
- How is the negative sign represented during continuous operations?

### Assumptions & Dependencies

- **Assumption**: The underlying calculation engine is capable of handling negative and floating-point math accurately without precision loss.
- **Assumption**: The calculator's display has sufficient character width to accommodate the additional negative sign indicator.
- **Dependency**: Existing arithmetic operations must not fail or produce unexpected errors when parsing negative string inputs.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST allow users to designate a number as negative.
- **FR-002**: System MUST visually clearly indicate when a entered number is negative on the display.
- **FR-003**: System MUST correctly calculate arithmetic operations when one or more operands are negative.
- **FR-004**: System MUST allow users to toggle the sign of the currently inputted number between positive and negative.
- **FR-005**: System MUST retain the negative sign appropriately when chaining operations.

### Key Entities

- **Operand**: Represents the number being inputted or used in calculation, which now must support a negative state.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can successfully input negative numbers and perform calculations yielding correct mathematical results 100% of the time.
- **SC-002**: The sign toggle functionality applies instantaneously with no noticeable performance degradation.
- **SC-003**: The display correctly and unambiguously formats negative numbers, preventing user confusion.
