# Feature Specification: Bhaskara Calculation Operation

**Feature Branch**: `002-calc-bhaskara`  
**Created**: 2026-02-27  
**Status**: Draft  
**Input**: User description: "precisamos acrescentar a operação do cálculo de bhaskara na calculadora modificando o minimo possível do que já existe. Para isso a operação deve ser criada como operação extra. Considere que para essa operação será necessário 3 variáveis; trate os casos de erro, quando o valor da determinante for negativo"

## Clarifications

### Session 2026-02-27

- Q: How should the calculator prompt the user for the three variables? → A: Sequentially prompt using the operation button to cycle through 'a', 'b', and 'c'.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Standard Bhaskara Calculation (Priority: P1)

As a user, I want to calculate the roots of a quadratic equation using the Bhaskara formula so that I can quickly find the values of x.

**Why this priority**: Core functionality of the requested feature. Providing standard calculation handles the most common use case.

**Independent Test**: Can be fully tested by inputting valid values for variables $a$, $b$, and $c$, and verifying that the correct roots are displayed.

**Acceptance Scenarios**:

1. **Given** the calculator is open and "Bhaskara" operation is selected, **When** I input $a = 1$, $b = -3$, $c = 2$ and request the calculation, **Then** the results $x_1 = 2$ and $x_2 = 1$ should be displayed.
2. **Given** the calculator is open and "Bhaskara" operation is selected, **When** I input $a = 1$, $b = -2$, $c = 1$ and request the calculation, **Then** the results $x_1 = 1$ and $x_2 = 1$ should be displayed.

---

### User Story 2 - Negative Determinant Error Handling (Priority: P1)

As a user, I want to be informed when the calculation cannot be completed due to a negative determinant (delta < 0), so that I understand why there are no real roots.

**Why this priority**: Specific requirement from the user description to handle negative determinant cases properly.

**Independent Test**: Can be tested by providing values that result in a negative delta and ensuring a user-friendly error message is displayed.

**Acceptance Scenarios**:

1. **Given** the calculator is open and "Bhaskara" operation is selected, **When** I input $a = 1$, $b = 1$, $c = 1$ and request the calculation, **Then** the system should display an error indicating that the determinant is negative and no real roots exist.

---

### Edge Cases

- What happens when variable '$a$' is set to 0? (Validation should prevent this as it's not a quadratic equation).
- How does the system handle non-numeric inputs for the variables? (Should be prevented or handled gracefully by existing calculator logic).
- How is the new operation exposed in the UI? (It should be an "extra operation" modifying the existing UI as minimally as possible).
- **Cancellation/Reset**: What happens if the user presses "Clear" or selects another operation while in the middle of inputting the 3 variables? (State should be reset).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide an interface to select a "Bhaskara" operation as an extra operation in the calculator.
- **FR-002**: System MUST allow the input of 3 numeric variables ($a$, $b$, $c$) sequentially. The user inputs a value and presses the Bhaskara operation button to advance to the next variable.
- **FR-003**: System MUST calculate the determinant ($\Delta = b^2 - 4ac$).
- **FR-004**: System MUST calculate the roots ($x = \frac{-b \pm \sqrt{\Delta}}{2a}$) if the determinant is zero or positive.
- **FR-005**: System MUST validate that variable '$a$' is not zero and display an error otherwise.
- **FR-006**: System MUST display a clear error message when the determinant is negative, informing the user that the operation cannot be completed.
- **FR-007**: System MUST integrate the new operation with minimal changes to the existing calculator architecture and UI.

### Key Entities *(include if feature involves data)*

- **Bhaskara Input**: Represents the 3 variables ($a$, $b$, $c$) provided by the user.
- **Bhaskara Result**: Represents the calculated roots ($x_1$, $x_2$) or an error state.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can successfully calculate the roots of a valid quadratic equation without UI errors or crashes.
- **SC-002**: The existing calculator operations (addition, subtraction, etc.) continue to function without any regressions.
- **SC-003**: In cases of a negative determinant, the user is presented with a clear error rather than a system crash or incorrect calculation.
- **SC-004**: The addition of the Bhaskara operation requires modification of only the necessary files for "extra operations" without core architectural rewrites.
