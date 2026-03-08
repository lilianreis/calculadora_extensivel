# Quickstart: Bhaskara Operation

This feature adds the Bhaskara quadratic equation calculation ($x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$) to the existing Calculator.

## Key Changes
1. Added `BhaskaraOperation` to the domain layer.
2. Modified `CalculatorEngine` and `CalculatorState` to support sequential input of 3 variables ($a$, $b$, $c$) using the operation key to advance.
3. Added error handling for zero $a$ and negative determinant ($\Delta < 0$).

## Developer Setup
No new dependencies are required. Standard Flutter and Dart SDK are sufficient.

```bash
flutter pub get
```

## Running Tests
Run the unit tests to verify the Bhaskara logic and state transitions:

```bash
flutter test test/
```

## Manual Testing
1. Launch the application.
2. Select the "Bhaskara" operation.
3. Input the value for $a$ (e.g., 1), then press the Bhaskara key (or equivalent action key).
4. Input the value for $b$ (e.g., -3), then press the key.
5. Input the value for $c$ (e.g., 2), then press the key.
6. Verify the display shows the roots: `x1: 2.0, x2: 1.0` (for $x^2 - 3x + 2 = 0$).
7. Test the negative determinant scenario (e.g., $a=1, b=1, c=1$) and verify the error message is displayed and the app doesn't crash.
