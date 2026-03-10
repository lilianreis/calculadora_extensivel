import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:first_app_ueg_20261/src/calculator/logic/calculator_engine.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations_registry.dart';
import 'package:first_app_ueg_20261/src/calculator/presentation/widgets/calculator_grid.dart';

void main() {
  testWidgets('CalculatorGrid displays +/- button and toggles sign on engine', (
    WidgetTester tester,
  ) async {
    final engine = CalculatorEngine();
    final registry = OperationsRegistry();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: engine),
          ChangeNotifierProvider.value(value: registry),
        ],
        child: const MaterialApp(home: Scaffold(body: CalculatorGrid())),
      ),
    );

    expect(engine.state.display, '0');

    await tester.tap(find.text('5'));
    await tester.pump();
    expect(engine.state.display, '5');

    await tester.tap(find.text('+/-'));
    await tester.pump();
    expect(engine.state.display, '-5');

    await tester.tap(find.text('+/-'));
    await tester.pump();
    expect(engine.state.display, '5');
  });
}
