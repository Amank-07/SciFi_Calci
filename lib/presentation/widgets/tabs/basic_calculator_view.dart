import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/calculator_controller.dart';
import '../button_grid.dart';

class BasicCalculatorView extends StatelessWidget {
  const BasicCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<CalculatorController>();

    final Color keyBg = theme.colorScheme.surface.withOpacity(0.08);
    final Color keyFg = theme.colorScheme.onSurface.withOpacity(0.92);
    final Color opBg = theme.colorScheme.primary.withOpacity(0.95);
    final Color opFg = theme.colorScheme.onPrimary;
    final Color dangerBg = Colors.redAccent.withOpacity(0.95);
    const Color dangerFg = Colors.white;

    final rows = <List<CalculatorButtonConfig>>[
      // Clear / parentheses / multiply
      [
        CalculatorButtonConfig(
          text: 'C',
          onTap: controller.clearAll,
          backgroundColor: dangerBg,
          foregroundColor: dangerFg,
          fontSize: 20,
          isDense: true,
        ),
        CalculatorButtonConfig(
          text: '(',
          onTap: controller.inputParenthesisOpen,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: ')',
          onTap: controller.inputParenthesisClose,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '÷',
          onTap: () => controller.inputOperator('÷'),
          backgroundColor: opBg,
          foregroundColor: opFg,
        ),
      ],
      // 7 8 9 -
      [
        CalculatorButtonConfig(
          text: '7',
          onTap: () => controller.inputDigit('7'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '8',
          onTap: () => controller.inputDigit('8'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '9',
          onTap: () => controller.inputDigit('9'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '×',
          onTap: () => controller.inputOperator('×'),
          backgroundColor: opBg,
          foregroundColor: opFg,
        ),
      ],
      // 4 5 6 +
      [
        CalculatorButtonConfig(
          text: '4',
          onTap: () => controller.inputDigit('4'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '5',
          onTap: () => controller.inputDigit('5'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '6',
          onTap: () => controller.inputDigit('6'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '-',
          onTap: () => controller.inputOperator('-'),
          backgroundColor: opBg,
          foregroundColor: opFg,
        ),
      ],
      // 1 2 3 %
      [
        CalculatorButtonConfig(
          text: '1',
          onTap: () => controller.inputDigit('1'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '2',
          onTap: () => controller.inputDigit('2'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '3',
          onTap: () => controller.inputDigit('3'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '%',
          onTap: controller.applyPercent,
          backgroundColor: opBg,
          foregroundColor: opFg,
        ),
      ],
      // 0 . backspace =
      [
        CalculatorButtonConfig(
          text: '0',
          onTap: () => controller.inputDigit('0'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '.',
          onTap: controller.inputDot,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: '⌫',
          onTap: controller.backspace,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
          fontSize: 16,
          isDense: true,
        ),
        CalculatorButtonConfig(
          text: '=',
          onTap: controller.evaluate,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          fontSize: 22,
          isDense: true,
        ),
      ],
    ];

    return ButtonGrid(rows: rows);
  }
}

