import '../domain/operation.dart';

class CalculatorState {
  final String display;
  final double? accumulator;
  final Operation? pendingOperation;
  final bool isNewNumber;
  final double? bhaskaraA;
  final double? bhaskaraB;
  final bool pendingNegative;

  CalculatorState({
    required this.display,
    this.accumulator,
    this.pendingOperation,
    this.isNewNumber = true,
    this.bhaskaraA,
    this.bhaskaraB,
    this.pendingNegative = false,
  });

  bool get isBhaskaraMode => pendingOperation?.symbol == 'Δ';

  CalculatorState copyWith({
    String? display,
    double? accumulator,
    Operation? pendingOperation,
    bool? isNewNumber,
    double? bhaskaraA,
    double? bhaskaraB,
    bool? pendingNegative,
    bool clearBhaskara = false,
    bool clearOperation = false,
    bool clearAccumulator = false,
  }) {
    return CalculatorState(
      display: display ?? this.display,
      accumulator: clearAccumulator ? null : (accumulator ?? this.accumulator),
      pendingOperation: clearOperation
          ? null
          : (pendingOperation ?? this.pendingOperation),
      isNewNumber: isNewNumber ?? this.isNewNumber,
      bhaskaraA: clearBhaskara ? null : (bhaskaraA ?? this.bhaskaraA),
      bhaskaraB: clearBhaskara ? null : (bhaskaraB ?? this.bhaskaraB),
      pendingNegative: pendingNegative ?? this.pendingNegative,
    );
  }

  factory CalculatorState.initial() {
    return CalculatorState(display: '0');
  }
}
