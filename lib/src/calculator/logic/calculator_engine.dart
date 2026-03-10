import 'package:flutter/foundation.dart';
import '../domain/operation.dart';
import '../domain/operations/bhaskara_operation.dart';
import 'calculator_state.dart';

class CalculatorEngine extends ChangeNotifier {
  CalculatorState _state = CalculatorState.initial();

  CalculatorState get state => _state;

  void addDigit(int digit) {
    String newDisplay;
    if (_state.isNewNumber || _state.display == '0') {
      newDisplay = _state.pendingNegative ? '-$digit' : digit.toString();
    } else {
      newDisplay = _state.display + digit.toString();
    }

    _state = _state.copyWith(
      display: newDisplay,
      isNewNumber: false,
      pendingNegative: false,
    );
    notifyListeners();
  }

  void addComma() {
    if (_state.display == 'Error') return;

    if (_state.isNewNumber ||
        _state.display.isEmpty ||
        _state.display == '0' ||
        _state.display == '-0') {
      String newDisplay = _state.pendingNegative ? '-0,' : '0,';
      _state = _state.copyWith(
        display: newDisplay,
        isNewNumber: false,
        pendingNegative: false,
      );
      notifyListeners();
      return;
    }

    if (_state.display.contains(',')) {
      return;
    }

    _state = _state.copyWith(display: _state.display + ',', isNewNumber: false);
    notifyListeners();
  }

  void onOperationPressed(Operation operation) {
    if (operation is BhaskaraOperation) {
      _handleBhaskaraSequencing(operation);
      return;
    }

    // Existing operations reset Bhaskara mode if active
    if (_state.isBhaskaraMode) {
      _cancelBhaskaraMode();
    }

    if (operation.argCount == 0) {
      // Unary operation like sqrt or square
      final current = _parseDouble(_state.display);
      final result = operation.execute(current);
      _state = _state.copyWith(
        display: _formatResult(result),
        isNewNumber: true,
      );
    } else {
      // Binary operation
      if (operation.symbol == '-' &&
          _state.isNewNumber &&
          (_state.pendingOperation != null || _state.display == '0')) {
        _state = _state.copyWith(pendingNegative: true);
        notifyListeners();
        return;
      }

      if (_state.pendingOperation != null && !_state.isNewNumber) {
        _calculate();
      }

      _state = _state.copyWith(
        accumulator: _parseDouble(_state.display),
        pendingOperation: operation,
        isNewNumber: true,
        pendingNegative: false,
      );
    }
    notifyListeners();
  }

  void onEqualsPressed() {
    _calculate();
    _state = _state.copyWith(
      clearOperation: true,
      clearAccumulator: true,
      clearBhaskara: true,
      isNewNumber: true,
    );
    notifyListeners();
  }

  void onClearPressed() {
    _state = CalculatorState.initial();
    notifyListeners();
  }

  void toggleSign() {
    if (_state.display == 'Error' || _state.display.isEmpty) return;

    if (_state.display == '0') {
      _state = _state.copyWith(pendingNegative: !_state.pendingNegative);
      notifyListeners();
      return;
    }

    String newDisplay;
    if (_state.display.startsWith('-')) {
      newDisplay = _state.display.substring(1);
      if (newDisplay.isEmpty) newDisplay = '0';
    } else {
      newDisplay = '-' + _state.display;
    }

    _state = _state.copyWith(display: newDisplay, isNewNumber: false);
    notifyListeners();
  }

  void _handleBhaskaraSequencing(BhaskaraOperation operation) {
    if (!_state.isBhaskaraMode) {
      // Start Bhaskara Mode: capture A
      final current = _parseDouble(_state.display);
      _state = _state.copyWith(
        bhaskaraA: current,
        pendingOperation: operation,
        isNewNumber: true,
      );
    } else if (_state.bhaskaraA != null && _state.bhaskaraB == null) {
      // Capture B
      final current = _parseDouble(_state.display);
      _state = _state.copyWith(bhaskaraB: current, isNewNumber: true);
    } else if (_state.bhaskaraA != null && _state.bhaskaraB != null) {
      // Capture C and calculate
      _calculate();
    }
    notifyListeners();
  }

  void _cancelBhaskaraMode() {
    _state = _state.copyWith(clearOperation: true, clearBhaskara: true);
  }

  void _calculate() {
    if (_state.pendingOperation == null) return;

    if (_state.isBhaskaraMode) {
      if (_state.bhaskaraA == null || _state.bhaskaraB == null) return;
      final a = _state.bhaskaraA!;
      final b = _state.bhaskaraB!;
      final c = _parseDouble(_state.display);
      try {
        final bhaskara = _state.pendingOperation as BhaskaraOperation;
        final roots = bhaskara.calculate(a, b, c);
        _state = _state.copyWith(
          display:
              'x1=${_formatResult(roots[0])}, x2=${_formatResult(roots[1])}',
          clearBhaskara: true,
          clearOperation: true,
          isNewNumber: true,
        );
      } catch (e) {
        _state = _state.copyWith(
          display: 'Error',
          clearBhaskara: true,
          clearOperation: true,
          isNewNumber: true,
        );
      }
      return;
    }

    if (_state.accumulator == null) return;

    final current = _parseDouble(_state.display);
    try {
      final result = _state.pendingOperation!.execute(
        _state.accumulator!,
        current,
      );
      _state = _state.copyWith(display: _formatResult(result));
    } catch (e) {
      _state = _state.copyWith(display: 'Error');
    }
  }

  String _formatResult(double result) {
    if (result.isInfinite || result.isNaN) return 'Error';
    if (result == result.toInt()) {
      return result.toInt().toString();
    }
    return result.toString().replaceAll('.', ',');
  }

  double _parseDouble(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  }
}
