import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/math_expressions_repository.dart';
import 'domain/usecases/evaluate_expression_usecase.dart';
import 'presentation/app/app.dart';
import 'presentation/state/calculator_controller.dart';
import 'presentation/state/theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Clean Architecture wiring:
  // Data repository -> Domain usecase -> Presentation controller (state).
  final repository = MathExpressionsRepository();
  final evaluateExpression = EvaluateExpressionUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(
          create: (_) => CalculatorController(
            evaluateExpression: evaluateExpression,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}

// Template widgets removed in favor of the scientific calculator app.
