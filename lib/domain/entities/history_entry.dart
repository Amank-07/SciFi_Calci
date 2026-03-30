class HistoryEntry {
  final String expression;
  final String result;
  final DateTime createdAt;

  const HistoryEntry({
    required this.expression,
    required this.result,
    required this.createdAt,
  });
}

