# Feature Specification: Decimal Numbers Support

**Feature Branch**: `004-decimal-support`  
**Created**: 2026-03-09  
**Status**: Draft  
**Input**: User description: "implemente suporte para numero decimais com virgula"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Enter Decimal Numbers (Priority: P1)

As a user, I want to be able to enter decimal numbers using a comma as a separator, so that I can perform calculations with precise values.

**Why this priority**: Entering decimal numbers is a core functionality of a calculator, allowing for operations beyond integers. The use of comma is required by the user (common in many locales like Brazil).

**Independent Test**: Can be fully tested by entering "1,5" and verifying the display shows exactly "1,5".

**Acceptance Scenarios**:

1. **Given** the calculator display shows "0", **When** the "," button is pressed, **Then** the display changes to "0,".
2. **Given** the calculator display shows "5", **When** the "," button is pressed, **Then** the display changes to "5,".
3. **Given** the calculator display shows "5,", **When** the "2" button is pressed, **Then** the display changes to "5,2".
4. **Given** the calculator display shows "5,2", **When** the "," button is pressed again, **Then** the display remains "5,2" (ignores the second comma).

---

### User Story 2 - Calculations with Decimal Numbers (Priority: P1)

As a user, I want to perform basic operations (+, -, *, /) using decimal numbers, so that I can get accurate results.

**Why this priority**: Without calculations, entering decimal numbers has no value. Operations must correctly parse and compute the decimal values.

**Independent Test**: Can be fully tested by performing "1,5 + 2,5" and getting "4" (or "4,0").

**Acceptance Scenarios**:

1. **Given** the user entered "1,5", **When** they add "2,5" and press equals, **Then** the result shown is "4" (or "4,0").
2. **Given** the user entered "5,2", **When** they multiply by "2" and press equals, **Then** the result shown is "10,4".

---

### Edge Cases

- What happens when a user presses "," immediately after an operation button (e.g., "5 + ,")? It should behave as "0,".
- How does system handle very long decimal numbers? It should respect the maximum display length.
- What happens when the result of a calculation has too many decimal places? It should be reasonably truncated or rounded to fit the display.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a dedicated button in the user interface for inputting the decimal separator (`,`).
- **FR-002**: System MUST allow users to input a decimal separator using the comma (`,`) character.
- **FR-003**: System MUST display the decimal separator as a comma (`,`) in the user interface.
- **FR-004**: System MUST prevent the input of more than one comma in a single operand.
- **FR-005**: System MUST automatically prefix a comma with "0" if it is the first character entered in a new operand (resulting in "0,").
- **FR-006**: System MUST correctly perform mathematical operations on numbers containing commas.
- **FR-007**: System MUST format calculated results to use a comma (`,`) as the decimal separator.
- **FR-008**: System MUST handle cases where a user appends a comma to a negative number (e.g., "-0,").

### Key Entities

This feature does not introduce new entities, but modifies the state of the Calculator display string to include commas.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can successfully enter decimal numbers up to the maximum display length limitation.
- **SC-002**: 100% of mathematical operations involving valid decimal inputs yield mathematically correct results (within expected precision limits).
- **SC-003**: All numbers displayed on the screen use the comma (`,`) as the decimal separator, never a period (`.`).
