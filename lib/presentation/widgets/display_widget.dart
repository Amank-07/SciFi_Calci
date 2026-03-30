import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final String expression;
  final String result;

  const DisplayWidget({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isError = result.toLowerCase() == 'error' ||
        result.toLowerCase().contains('invalid');
    final resultColor = isError
        ? Colors.redAccent
        : theme.colorScheme.primary.withOpacity(0.95);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.06),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 26,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                expression.isEmpty ? '0' : expression,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.72),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            result.isEmpty ? '' : result,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: resultColor,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

