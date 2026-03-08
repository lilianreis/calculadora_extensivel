import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:first_app_ueg_20261/main.dart'; // import MyApp
import 'package:first_app_ueg_20261/src/calculator/logic/calculator_engine.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations_registry.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/addition.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/subtraction.dart';
import 'package:first_app_ueg_20261/src/calculator/domain/operations/bhaskara_operation.dart';
import 'package:first_app_ueg_20261/src/calculator/presentation/widgets/operation_button.dart';

void main() {
  Widget buildTestableApp() {
    final registry = OperationsRegistry()
      ..register(AdditionOperation())
      ..register(SubtractionOperation())
      ..register(const BhaskaraOperation());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: registry),
        ChangeNotifierProvider(create: (_) => CalculatorEngine()),
      ],
      child: const MyApp(),
    );
  }

  testWidgets('Bhaskara calculation flow', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableApp());
    await tester.pumpAndSettle();

    // Finders
    final btn1 = find.widgetWithText(OperationButton, '1');
    final btn5 = find.widgetWithText(OperationButton, '5');
    final btn6 = find.widgetWithText(OperationButton, '6');
    final btnBhaskara = find.widgetWithText(OperationButton, 'Δ');
    final btnEquals = find.widgetWithText(OperationButton, '=');

    // 1. Enter A
    await tester.tap(btn1);
    await tester.pump();
    await tester.tap(btnBhaskara);
    await tester.pump();
    expect(find.text('A = 1.0 | Enter B'), findsOneWidget);

    // 2. Enter B
    await tester.tap(btn5);
    await tester.pump();
    await tester.tap(btnBhaskara);
    await tester.pump();
    expect(find.text('A = 1.0, B = 5.0 | Enter C'), findsOneWidget);

    // 3. Enter C and calculate
    await tester.tap(btn6);
    await tester.pump();
    await tester.tap(btnEquals);
    await tester.pump();

    // Check result
    expect(find.text('x1=-2, x2=-3'), findsOneWidget);
    // The Bhaskara prompt should be hidden now
    expect(
      find.textContaining('Δ'),
      findsOneWidget,
    ); // The button is still there, but prompt removed
  });

  testWidgets('Bhaskara negative determinant flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildTestableApp());
    await tester.pumpAndSettle();

    final btn1 = find.widgetWithText(OperationButton, '1');
    final btnBhaskara = find.widgetWithText(OperationButton, 'Δ');
    final btnEquals = find.widgetWithText(OperationButton, '=');

    // Enter A, B, C = 1, 1, 1
    await tester.tap(btn1);
    await tester.pump();
    await tester.tap(btnBhaskara);
    await tester.pump();

    await tester.tap(btn1);
    await tester.pump();
    await tester.tap(btnBhaskara);
    await tester.pump();

    await tester.tap(btn1);
    await tester.pump();
    await tester.tap(btnEquals);
    await tester.pump();

    // Check result is Error
    expect(find.text('Error'), findsOneWidget);
  });
}
