import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/calculator_controller.dart';
import '../button_grid.dart';

class ScientificCalculatorView extends StatelessWidget {
  const ScientificCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<CalculatorController>();

    final Color funcBg = theme.colorScheme.secondary.withOpacity(0.9);
    final Color funcFg = theme.colorScheme.onSecondary;
    final Color keyBg = theme.colorScheme.surface.withOpacity(0.08);
    final Color keyFg = theme.colorScheme.onSurface.withOpacity(0.92);

    final rows = <List<CalculatorButtonConfig>>[
      [
        CalculatorButtonConfig(
          text: 'sin',
          onTap: () => controller.wrapFunction('sin('),
          backgroundColor: funcBg,
          foregroundColor: funcFg,
        ),
        CalculatorButtonConfig(
          text: 'cos',
          onTap: () => controller.wrapFunction('cos('),
          backgroundColor: funcBg,
          foregroundColor: funcFg,
        ),
        CalculatorButtonConfig(
          text: 'tan',
          onTap: () => controller.wrapFunction('tan('),
          backgroundColor: funcBg,
          foregroundColor: funcFg,
        ),
        CalculatorButtonConfig(
          text: 'π',
          onTap: () => controller.inputConstant('π'),
          backgroundColor: keyBg,
          foregroundColor: keyFg,
        ),
      ],
      [
        CalculatorButtonConfig(
          text: 'log',
          onTap: () => controller.wrapFunction('log('),
          backgroundColor: funcBg,
          foregroundColor: funcFg,
          fontSize: 16,
        ),
        CalculatorButtonConfig(
          text: 'ln',
          onTap: () => controller.wrapFunction('ln('),
          backgroundColor: funcBg,
          foregroundColor: funcFg,
        ),
        CalculatorButtonConfig(
          text: '√',
          onTap: controller.applySqrt,
          backgroundColor: funcBg,
          foregroundColor: funcFg,
          fontSize: 18,
        ),
        CalculatorButtonConfig(
          text: '∛',
          onTap: controller.applyCubeRoot,
          backgroundColor: funcBg,
          foregroundColor: funcFg,
        ),
      ],
    ];

    return ButtonGrid(rows: rows);
  }
}

