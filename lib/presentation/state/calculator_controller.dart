import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/expression_formatter.dart';
import '../../core/utils/number_formatter.dart';
import '../../domain/entities/evaluation_outcome.dart';
import '../../domain/entities/history_entry.dart';
import '../../domain/usecases/evaluate_expression_usecase.dart';

class CalculatorController extends ChangeNotifier {
  final EvaluateExpressionUseCase evaluateExpression;
  final ExpressionFormatter expressionFormatter;
  final NumberFormatter numberFormatter;

  CalculatorController({
    required this.evaluateExpression,
    this.expressionFormatter = const ExpressionFormatter(),
    this.numberFormatter = const NumberFormatter(),
  });

  String _expression = '';
  String _result = '';
  bool _justEvaluated = false;

  final List<HistoryEntry> _history = [];

  String get expression => _expression;
  String get result => _result;
  List<HistoryEntry> get history => List.unmodifiable(_history);

  void _resetResultForNewInput() {
    _result = '';
    _justEvaluated = false;
  }

  bool _endsWithValueToken() {
    if (_expression.isEmpty) return false;
    final last = _expression[_expression.length - 1];
    return (last.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
            last.codeUnitAt(0) <= '9'.codeUnitAt(0)) ||
        last == '.' ||
        last == ')' ||
        last == '!' ||
        last == 'π' ||
        last == 'e' ||
        last == 'π';
  }

  void _notify() => notifyListeners();

  void clearAll() {
    _expression = '';
    _result = '';
    _justEvaluated = false;
    _notify();
  }

  void clearHistory() {
    _history.clear();
    _notify();
  }

  void backspace() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();

    const openPrefixes = <String>[
      'sin(',
      'cos(',
      'tan(',
      'ln(',
      'log(',
      '√(',
    ];

    for (final prefix in openPrefixes) {
      if (_expression.endsWith(prefix)) {
        _expression = _expression.substring(0, _expression.length - prefix.length);
        _notify();
        return;
      }
    }

    // Backspace is intentionally character-based after the known open prefixes.
    _expression = _expression.substring(0, _expression.length - 1);
    _notify();
  }

  void inputDigit(String digit) {
    if (digit.length != 1) return;
    final isDigit = digit.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
        digit.codeUnitAt(0) <= '9'.codeUnitAt(0);
    if (!isDigit) return;

    if (_justEvaluated) {
      _expression = '';
      _result = '';
      _justEvaluated = false;
    } else {
      _resetResultForNewInput();
    }

    if (_expression.isEmpty) {
      _expression = digit;
      _notify();
      return;
    }

    final last = _expression[_expression.length - 1];
    final lastIsDigit = last.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
        last.codeUnitAt(0) <= '9'.codeUnitAt(0);
    if (lastIsDigit || last == '.') {
      _expression += digit;
      _notify();
      return;
    }

    // Implicit multiplication: `)2`, `!2`, `π2`, `e2`
    if (_endsWithValueToken()) {
      _expression += '×$digit';
    } else {
      _expression += digit;
    }

    _notify();
  }

  void inputDot() {
    if (_justEvaluated) {
      _expression = '';
      _result = '';
      _justEvaluated = false;
    } else {
      _resetResultForNewInput();
    }

    if (_expression.isEmpty) {
      _expression = '0.';
      _notify();
      return;
    }

    int i = _expression.length - 1;
    while (i >= 0) {
      final ch = _expression[i];
      final isDigit = ch.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
          ch.codeUnitAt(0) <= '9'.codeUnitAt(0);
      if (!isDigit && ch != '.') break;
      i--;
    }

    final segment = _expression.substring(i + 1);
    if (segment.contains('.')) return; // Prevent duplicate dots in a number.

    // If the previous token was a value ender (e.g. `)` or `π`) then `.` means
    // "start a new decimal number" with implicit multiplication.
    if (_endsWithValueToken() && segment.isEmpty) {
      _expression += '×0.';
      _notify();
      return;
    }

    if (_expression.endsWith('.') || _expression.endsWith('0.')) {
      _notify();
      return;
    }

    _expression += '.';
    _notify();
  }

  void inputConstant(String constant) {
    // constant is expected to be `π` or `e`
    if (_justEvaluated) {
      _expression = '';
      _result = '';
      _justEvaluated = false;
    } else {
      _resetResultForNewInput();
    }

    if (constant != 'π' && constant != 'e') return;
    if (_expression.isEmpty) {
      _expression = constant;
      _notify();
      return;
    }

    final last = _expression[_expression.length - 1];
    final lastIsDigit = last.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
        last.codeUnitAt(0) <= '9'.codeUnitAt(0);
    final needsMultiply = lastIsDigit || last == ')' || last == '!' || last == 'π' || last == 'e' || last == '.';

    if (needsMultiply) {
      _expression += '×$constant';
    } else {
      _expression += constant;
    }

    _notify();
  }

  void inputParenthesisOpen() {
    _resetResultForNewInput();
    if (_justEvaluated) {
      _expression = '';
      _justEvaluated = false;
    }

    if (_expression.isEmpty) {
      _expression = '(';
      _notify();
      return;
    }

    if (_endsWithValueToken()) {
      _expression += '×(';
    } else {
      _expression += '(';
    }
    _notify();
  }

  void inputParenthesisClose() {
    _resetResultForNewInput();
    if (_expression.isEmpty) return;

    final openCount = _expression.split('(').length - 1;
    final closeCount = _expression.split(')').length - 1;
    if (openCount <= closeCount) return;

    _expression += ')';
    _notify();
  }

  bool _endsWithBinaryOperator() {
    if (_expression.isEmpty) return false;
    final last = _expression[_expression.length - 1];
    return last == '+' || last == '-' || last == '×' || last == '÷' || last == '^';
  }

  void inputOperator(String operatorToken) {
    // Supported: +, -, ×, ÷, ^
    if (operatorToken != '+' &&
        operatorToken != '-' &&
        operatorToken != '×' &&
        operatorToken != '÷' &&
        operatorToken != '^') {
      return;
    }

    if (_justEvaluated) {
      _justEvaluated = false;
    }
    _resetResultForNewInput();

    if (_expression.isEmpty) {
      if (operatorToken == '-') {
        _expression = '-';
        _notify();
      }
      return;
    }

    if (_endsWithBinaryOperator()) {
      _expression = _expression.substring(0, _expression.length - 1) +
          operatorToken;
      _notify();
      return;
    }

    _expression += operatorToken;
    _notify();
  }

  void wrapFunction(String functionPrefixWithParen) {
    // Example: `sin(`, `cos(`, `ln(`
    _resetResultForNewInput();

    if (_expression.isEmpty) {
      _expression = functionPrefixWithParen;
      _notify();
      return;
    }

    _expression = '$functionPrefixWithParen$_expression)';
    _notify();
  }

  void applySqrt() {
    _resetResultForNewInput();
    if (_expression.isEmpty) {
      _expression = '√(';
      _notify();
      return;
    }
    _expression = '√($_expression)';
    _notify();
  }

  void applyPower2() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();
    _expression = '($_expression)^2';
    _notify();
  }

  void applyPower3() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();
    _expression = '($_expression)^3';
    _notify();
  }

  void applyCubeRoot() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();
    _expression = '($_expression)^(1/3)';
    _notify();
  }

  void applyPercent() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();
    _expression = '($_expression)÷100';
    _notify();
  }

  void applyFactorial() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();
    _expression = '($_expression)!';
    _notify();
  }

  void applyInverse() {
    if (_expression.isEmpty) return;
    _resetResultForNewInput();
    _expression = '1÷($_expression)';
    _notify();
  }

  void applyAbsolute() {
    _resetResultForNewInput();
    if (_expression.isEmpty) {
      // Allow entering |x| progressively by inserting the first bar.
      _expression = '|';
      _notify();
      return;
    }

    final barCount = _expression.split('|').length - 1;
    final isAbsOpen = barCount.isOdd;
    if (isAbsOpen) {
      // Close an open abs wrapper.
      _expression += '|';
      _notify();
      return;
    }

    _expression = '|($_expression)|';
    _notify();
  }

  void evaluate() {
    if (_expression.trim().isEmpty) return;

    final currentExpression = _expression;
    late final String mathExpression;
    try {
      mathExpression = expressionFormatter.toMathExpression(currentExpression);
    } catch (_) {
      _result = 'Error';
      _justEvaluated = false;
      _notify();
      return;
    }

    final outcome = evaluateExpression(mathExpression);

    if (outcome is EvaluationSuccess) {
      final formatted = numberFormatter.formatDouble(outcome.value);
      _result = formatted;
      _history.insert(
        0,
        HistoryEntry(
          expression: currentExpression,
          result: formatted,
          createdAt: DateTime.now(),
        ),
      );

      if (_history.length > AppConstants.maxHistoryEntries) {
        _history.removeRange(AppConstants.maxHistoryEntries, _history.length);
      }

      // Enable chaining: after `=`, start from the result value.
      _expression = formatted;
      _justEvaluated = true;
      _notify();
      return;
    }

    final message = outcome is EvaluationFailure ? outcome.message : 'Error';
    _result = message;
    _justEvaluated = false;
    _notify();
  }
}

