import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/calculator_controller.dart';
import '../button_grid.dart';

class AdvancedCalculatorView extends StatelessWidget {
  const AdvancedCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<CalculatorController>();

    final Color keyBg = theme.colorScheme.surface.withOpacity(0.08);
    final Color keyFg = theme.colorScheme.onSurface.withOpacity(0.92);
    final Color opBg = theme.colorScheme.primary.withOpacity(0.95);
    final Color opFg = theme.colorScheme.onPrimary;

    final rows = <List<CalculatorButtonConfig>>[
      [
        CalculatorButtonConfig(
          text: 'x²',
          onTap: controller.applyPower2,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: 'x³',
          onTap: controller.applyPower3,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
        CalculatorButtonConfig(
          text: 'xʸ',
          onTap: () => controller.inputOperator('^'),
          backgroundColor: opBg,
          foregroundColor: opFg,
        ),
        CalculatorButtonConfig(
          text: 'e',
          onTap: () => controller.inputConstant('e'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
      ],
      [
        CalculatorButtonConfig(
          text: '!',
          onTap: controller.applyFactorial,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
          fontSize: 20,
          isDense: true,
        ),
        CalculatorButtonConfig(
          text: '|x|',
          onTap: controller.applyAbsolute,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
          fontSize: 16,
        ),
        CalculatorButtonConfig(
          text: '1/x',
          onTap: controller.applyInverse,
          backgroundColor: keyBg,
          foregroundColor: keyFg,
          fontSize: 16,
        ),
        // leave last cell blank to keep layout balanced
        CalculatorButtonConfig(
          text: '',
          onTap: () {},
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          isDense: true,
        ),
      ],
    ];

    return ButtonGrid(rows: rows);
  }
}

