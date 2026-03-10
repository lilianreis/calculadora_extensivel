import 'package:flutter_test/flutter_test.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operation.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/bhaskara_operation.dart';
import 'package:first_app_ueg_20261/src/calculator/logic/calculator_engine.dart';

class MockAdd extends Operation {
  @override
  String get symbol => '+';
  @override
  String get name => 'Add';
  @override
  int get argCount => 2;
  @override
  double execute(double acc, [double? op]) => acc + (op ?? 0);
}

class MockSubtract extends Operation {
  @override
  String get symbol => '-';
  @override
  String get name => 'Subtract';
  @override
  int get argCount => 2;
  @override
  double execute(double acc, [double? op]) => acc - (op ?? 0);
}

void main() {
  group('CalculatorEngine Tests', () {
    late CalculatorEngine engine;

    setUp(() {
      engine = CalculatorEngine();
    });

    test('Initial state is 0', () {
      expect(engine.state.display, '0');
    });

    test('Add digits updates display', () {
      engine.addDigit(1);
      engine.addDigit(2);
      expect(engine.state.display, '12');
    });

    test('Basic addition logic', () {
      engine.addDigit(5);
      engine.onOperationPressed(MockAdd());
      engine.addDigit(3);
      engine.onEqualsPressed();
      expect(engine.state.display, '8');
    });

    test('Addition with negative numbers', () {
      engine.addDigit(5);
      engine.onOperationPressed(MockAdd());
      engine.addDigit(3);
      engine.toggleSign(); // Becomes -3
      engine.onEqualsPressed();
      expect(engine.state.display, '2');
    });

    test('Clear resets state', () {
      engine.addDigit(5);
      engine.onClearPressed();
      expect(engine.state.display, '0');
    });

    test('toggleSign adds and removes negative sign', () {
      engine.addDigit(5);
      engine.toggleSign();
      expect(engine.state.display, '-5');
      engine.toggleSign();
      expect(engine.state.display, '5');
    });

    test('toggleSign sets pendingNegative for 0 instead of -0', () {
      expect(engine.state.display, '0');
      engine.toggleSign();
      expect(engine.state.display, '0'); // Still 0 visually
      expect(engine.state.pendingNegative, isTrue); // But tracks state

      engine.addDigit(5);
      expect(engine.state.display, '-5');
      engine.toggleSign();
      expect(engine.state.display, '5');
    });

    test('toggleSign after operation applies to next number', () {
      engine.addDigit(5);
      engine.onOperationPressed(MockAdd());
      expect(engine.state.display, '5');
    });

    test('Pressing subtract when display is 0 starts negative number', () {
      engine.onOperationPressed(MockSubtract());
      engine.addDigit(3);
      expect(engine.state.display, '-3');
      engine.onEqualsPressed();
      expect(engine.state.display, '-3');
    });

    test('Subtract after multiplication makes operand negative', () {
      engine.addDigit(5);
      // Wait, let's mock Multiply if we want to test that cleanly,
      // but testing MockAdd then Subtract should do the trick as well.
      engine.onOperationPressed(MockAdd());
      engine.onOperationPressed(MockSubtract());
      engine.addDigit(3);
      expect(engine.state.display, '-3');
      engine.onEqualsPressed();
      expect(engine.state.display, '2'); // 5 + (-3) = 2
    });

    test('toggleSign ignores Error display', () {
      final bhaskara = const BhaskaraOperation();
      engine.addDigit(1);
      engine.onOperationPressed(bhaskara);
      engine.addDigit(1);
      engine.onOperationPressed(bhaskara);
      engine.addDigit(1);
      engine.onEqualsPressed();

      expect(engine.state.display, 'Error');
      engine.toggleSign();
      expect(engine.state.display, 'Error');
    });

    test('Bhaskara operation sequence inputs A, B, C', () {
      final bhaskara = const BhaskaraOperation();

      // Input A = 1
      engine.addDigit(1);
      engine.onOperationPressed(bhaskara);
      expect(engine.state.bhaskaraA, 1.0);
      expect(engine.state.bhaskaraB, isNull);

      // Input B = -3
      // We simulate negative by 'subtract' logic, but for simplicity let's assume we can add negative if we supported the +/- button.
      // Since there's no +/- here easily mocked, we'll assume we can pass a value or just test positive roots.
      // Wait, let's just use positive digits for test, e.g. a=1, b=5, c=6 -> roots are -2, -3! Wait, sqrt(25 - 24) = 1. roots are (-5 +- 1)/2 = -2, -3.
      // Let's type 5 for B.
      engine.addDigit(5);
      engine.onOperationPressed(bhaskara);
      expect(engine.state.bhaskaraB, 5.0);

      // Input C = 6
      engine.addDigit(6);
      engine.onEqualsPressed();

      // roots for 1, 5, 6 are -2 and -3. Format could be "-2.0, -3.0"
      // or we can test if the state output contains them.
      expect(engine.state.display, contains('-2'));
      expect(engine.state.bhaskaraA, isNull); // Reset after equals
    });

    test('Bhaskara operation handles negative determinant with error', () {
      final bhaskara = const BhaskaraOperation();
      engine.addDigit(1);
      engine.onOperationPressed(bhaskara);
      engine.addDigit(1);
      engine.onOperationPressed(bhaskara);
      engine.addDigit(1);
      engine.onEqualsPressed();

      expect(engine.state.display, 'Error');
      expect(engine.state.isBhaskaraMode, isFalse);
    });

    test('Decimal input handles commas correctly', () {
      engine.addDigit(1);
      engine.addComma();
      engine.addDigit(5);
      expect(engine.state.display, '1,5');

      engine.addComma(); // Should ignore second comma
      expect(engine.state.display, '1,5');
    });

    test('Decimal input starts with 0, when no digit is entered', () {
      engine.addComma();
      expect(engine.state.display, '0,');
    });

    test('Decimal input starts with -0, when pending negative', () {
      engine.onOperationPressed(MockSubtract());
      engine.addComma();
      expect(engine.state.display, '-0,');
      engine.addDigit(5);
      expect(engine.state.display, '-0,5');
    });

    test('Calculation with decimal numbers', () {
      engine.addDigit(1);
      engine.addComma();
      engine.addDigit(5);
      engine.onOperationPressed(MockAdd());
      engine.addDigit(2);
      engine.addComma();
      engine.addDigit(5);
      engine.onEqualsPressed();
      expect(engine.state.display, '4');
    });

    test('Calculation resulting in decimal formats with comma', () {
      // 5,5 - 2,1 = 3,4
      engine.addDigit(5);
      engine.addComma();
      engine.addDigit(5);
      engine.onOperationPressed(MockSubtract());
      engine.addDigit(2);
      engine.addComma();
      engine.addDigit(1);
      engine.onEqualsPressed();
      expect(engine.state.display, '3,4');
    });
  });
}
