import 'package:flutter_test/flutter_test.dart';
import 'package:scifi_calci/core/utils/expression_formatter.dart';
import 'package:scifi_calci/data/repositories/math_expressions_repository.dart';
import 'package:scifi_calci/domain/entities/evaluation_outcome.dart';
import 'package:scifi_calci/domain/usecases/evaluate_expression_usecase.dart';

void main() {
  final formatter = ExpressionFormatter();
  final usecase = EvaluateExpressionUseCase(const MathExpressionsRepository());

  test('operator precedence with ×', () {
    final ui = '2+3×4';
    final math = formatter.toMathExpression(ui);
    final outcome = usecase(math);

    expect(outcome, isA<EvaluationSuccess>());
    final value = (outcome as EvaluationSuccess).value;
    expect(value, closeTo(14, 1e-10));
  });

  test('sqrt conversion with √', () {
    final ui = '√(9)';
    final outcome = usecase(formatter.toMathExpression(ui));

    expect(outcome, isA<EvaluationSuccess>());
    final value = (outcome as EvaluationSuccess).value;
    expect(value, closeTo(3, 1e-10));
  });

  test('trig + pi constant: sin(pi/2)', () {
    final ui = 'sin(π/2)';
    final outcome = usecase(formatter.toMathExpression(ui));

    expect(outcome, isA<EvaluationSuccess>());
    final value = (outcome as EvaluationSuccess).value;
    expect(value, closeTo(1, 1e-10));
  });

  test('factorial operator !', () {
    final ui = '(5)!';
    final outcome = usecase(formatter.toMathExpression(ui));

    expect(outcome, isA<EvaluationSuccess>());
    final value = (outcome as EvaluationSuccess).value;
    expect(value, closeTo(120, 1e-10));
  });

  test('absolute value conversion with |x|', () {
    final ui = '|(-3)|';
    final outcome = usecase(formatter.toMathExpression(ui));

    expect(outcome, isA<EvaluationSuccess>());
    final value = (outcome as EvaluationSuccess).value;
    expect(value, closeTo(3, 1e-10));
  });

  test('divide by zero yields failure', () {
    final ui = '1÷0';
    final outcome = usecase(formatter.toMathExpression(ui));
    expect(outcome, isA<EvaluationFailure>());
  });
}

