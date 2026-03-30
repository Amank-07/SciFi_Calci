import '../entities/evaluation_outcome.dart';
import '../repositories/expression_repository.dart';

class EvaluateExpressionUseCase {
  final ExpressionRepository repository;
  final String defaultErrorMessage;

  const EvaluateExpressionUseCase(
    this.repository, {
    this.defaultErrorMessage = 'Invalid input',
  });

  EvaluationOutcome call(String mathExpression) {
    try {
      final value = repository.evaluate(mathExpression);

      if (!value.isFinite) {
        return const EvaluationFailure('Math error');
      }

      return EvaluationSuccess(value);
    } catch (_) {
      return const EvaluationFailure('Invalid input');
    }
  }
}

