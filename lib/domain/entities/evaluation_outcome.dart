sealed class EvaluationOutcome {
  const EvaluationOutcome();
}

class EvaluationSuccess extends EvaluationOutcome {
  final double value;
  const EvaluationSuccess(this.value);
}

class EvaluationFailure extends EvaluationOutcome {
  final String message;
  const EvaluationFailure(this.message);
}

