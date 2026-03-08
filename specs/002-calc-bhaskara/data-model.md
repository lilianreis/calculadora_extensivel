# Data Model & Contracts: Bhaskara

## 1. Domain Entities

### `BhaskaraOperation` (Implements `Operation`)
- **Attributes**: None required internally, state is managed by Engine.
- **Methods**: 
  - `calculate(double a, double b, double c)`: Returns a `List<double>` containing `[x1, x2]`.
- **Validation**:
  - `if (a == 0)` -> Throw "A cannot be zero" error.
  - `delta = b*b - 4*a*c`
  - `if (delta < 0)` -> Throw "Negative delta" error.

## 2. State & Engine Modifications

### `CalculatorEngine`
- **New State Concept**: Needs to handle a 3-step sequence.
- **Properties**:
  - `double? _bhaskaraA`
  - `double? _bhaskaraB`
  - `bool _isBhaskaraMode`
- **Transitions**:
  - When Bhaskara is selected:
    - If `_isBhaskaraMode` is false: Set `_bhaskaraA` = current display, set mode to true, clear display to wait for B.
    - If `_bhaskaraA` is set, but `_bhaskaraB` is null: Set `_bhaskaraB` = current display, clear display to wait for C.
    - If `_bhaskaraB` is set: Use current display as C, call `BhaskaraOperation`, format the result into the display, and reset mode.

## 3. Contracts (N/A)
No external web APIs or GraphQL schemas are needed for this local device calculator feature.
