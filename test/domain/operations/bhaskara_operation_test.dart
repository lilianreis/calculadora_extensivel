import 'package:flutter_test/flutter_test.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/bhaskara_operation.dart';

void main() {
  group('BhaskaraOperation Standard Calculation', () {
    final operation = const BhaskaraOperation();

    test(
      'should calculate valid roots for a=1, b=-3, c=2 (roots should be 2.0 and 1.0)',
      () {
        final roots = operation.calculate(1.0, -3.0, 2.0);
        expect(roots, containsAll([2.0, 1.0]));
        expect(roots.length, 2);
      },
    );

    test(
      'should calculate valid roots for a=1, b=-2, c=1 (roots should be 1.0 and 1.0)',
      () {
        final roots = operation.calculate(1.0, -2.0, 1.0);
        expect(roots, containsAll([1.0, 1.0]));
        expect(roots.length, 2);
      },
    );
  });
}
