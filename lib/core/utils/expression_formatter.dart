class ExpressionFormatter {
  const ExpressionFormatter();

  /// Converts a calculator UI expression (using symbols like `×`, `÷`, `π`, `√`, `|x|`)
  /// into a `math_expressions`-compatible string.
  String toMathExpression(String uiExpression) {
    if (uiExpression.trim().isEmpty) {
      throw FormatException('Empty expression');
    }

    // First: convert obvious single-character symbols.
    final step1 = uiExpression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', 'pi')
        .replaceAll('√', 'sqrt');

    // Next: convert absolute value bars to abs(...).
    // Supports nested abs wrappers by using a stack.
    final buffer = StringBuffer();
    final stack = <int>[];

    for (int i = 0; i < step1.length; i++) {
      final ch = step1[i];
      if (ch == '|') {
        if (stack.isEmpty) {
          stack.add(i);
          buffer.write('abs(');
        } else {
          stack.removeLast();
          buffer.write(')');
        }
      } else {
        buffer.write(ch);
      }
    }

    if (stack.isNotEmpty) {
      throw FormatException('Unbalanced absolute-value bars');
    }

    return buffer.toString();
  }
}

