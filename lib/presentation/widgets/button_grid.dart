import 'package:flutter/material.dart';

import 'calculator_button.dart';

class CalculatorButtonConfig {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double fontSize;
  final bool isDense;

  const CalculatorButtonConfig({
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    this.fontSize = 18,
    this.isDense = false,
  });
}

class ButtonGrid extends StatelessWidget {
  final List<List<CalculatorButtonConfig>> rows;

  const ButtonGrid({
    super.key,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final row in rows)
          Expanded(
            child: Row(
              children: [
                for (final cell in row)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: CalculatorButton(
                        text: cell.text,
                        onTap: cell.onTap,
                        backgroundColor: cell.backgroundColor,
                        foregroundColor: cell.foregroundColor,
                        fontSize: cell.fontSize,
                        isDense: cell.isDense,
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

