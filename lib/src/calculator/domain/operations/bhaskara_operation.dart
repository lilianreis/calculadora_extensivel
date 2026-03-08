import '../operation.dart';
import 'dart:math';

class BhaskaraOperation implements Operation {
  const BhaskaraOperation();

  @override
  String get symbol => 'Δ';

  @override
  String get name => 'Bhaskara';

  @override
  int get argCount => 0; // handled outside standard execute flow

  @override
  double execute(double accumulator, [double? operand]) {
    throw UnsupportedError('Use calculate() for Bhaskara.');
  }

  /// Calculates the roots of a quadratic equation.
  List<double> calculate(double a, double b, double c) {
    if (a == 0) {
      throw ArgumentError('The value of A cannot be zero.');
    }

    final delta = (b * b) - (4 * a * c);

    if (delta < 0) {
      throw StateError('Negative determinant.');
    }

    final root1 = (-b + sqrt(delta)) / (2 * a);
    final root2 = (-b - sqrt(delta)) / (2 * a);

    return [root1, root2];
  }
}
