// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:scifi_calci/domain/usecases/evaluate_expression_usecase.dart';
import 'package:scifi_calci/data/repositories/math_expressions_repository.dart';
import 'package:scifi_calci/presentation/app/app.dart';
import 'package:scifi_calci/presentation/state/calculator_controller.dart';
import 'package:scifi_calci/presentation/state/theme_notifier.dart';

void main() {
  testWidgets('App smoke test renders SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider(
            create: (_) => CalculatorController(
              evaluateExpression: EvaluateExpressionUseCase(
                const MathExpressionsRepository(),
              ),
            ),
          ),
        ],
        child: const App(),
      ),
    );

    expect(find.text('SciFi Calci'), findsOneWidget);
  });
}
