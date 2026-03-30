import 'dart:math';

import 'package:math_expressions/math_expressions.dart';

import '../../domain/repositories/expression_repository.dart';

class MathExpressionsRepository implements ExpressionRepository {
  const MathExpressionsRepository();

  @override
  double evaluate(String mathExpression) {
    final parser = Parser();
    final expression = parser.parse(mathExpression);

    // Context is kept minimal; math_expressions provides common constants
    // like `pi` and functions like `sin`, `ln`, `sqrt`, etc.
    final contextModel = ContextModel();

    // Ensure common mathematical constants are available.
    // (Some versions require explicit bindings.)
    contextModel.bindVariable(Variable('pi'), Number(pi));
    contextModel.bindVariable(Variable('e'), Number(e));

    final value = expression.evaluate(EvaluationType.REAL, contextModel);
    return value;
  }
}

