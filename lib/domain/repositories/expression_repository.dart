abstract class ExpressionRepository {
  /// Evaluates a `math_expressions`-compatible expression.
  ///
  /// Implementations may throw for parsing/evaluation errors.
  double evaluate(String mathExpression);
}

