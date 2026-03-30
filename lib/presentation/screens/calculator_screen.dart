import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../state/calculator_controller.dart';
import '../state/theme_notifier.dart';
import '../widgets/display_widget.dart';
import '../widgets/history_panel.dart';
import '../widgets/tabs/advanced_calculator_view.dart';
import '../widgets/tabs/basic_calculator_view.dart';
import '../widgets/tabs/scientific_calculator_view.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  bool _showHistory = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<CalculatorController>();
    final themeNotifier = context.watch<ThemeNotifier>();

    // Scale layout to typical phone proportions while staying interview-friendly on desktop.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.appTitle),
          actions: [
            IconButton(
              tooltip:
                  themeNotifier.isDark ? 'Switch to light' : 'Switch to dark',
              icon: Icon(
                themeNotifier.isDark ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: themeNotifier.toggleTheme,
            ),
            IconButton(
              tooltip: _showHistory ? 'Hide history' : 'Show history',
              icon: Icon(
                _showHistory ? Icons.history : Icons.history_outlined,
              ),
              onPressed: () => setState(() => _showHistory = !_showHistory),
            ),
          ],
          bottom: TabBar(
            labelStyle: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
            tabs: const [
              Tab(text: 'Basic'),
              Tab(text: 'Scientific'),
              Tab(text: 'Advanced'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                DisplayWidget(
                  expression: controller.expression,
                  result: controller.result,
                ),
                const SizedBox(height: 14),
                HistoryPanel(
                  entries: controller.history,
                  visible: _showHistory && controller.history.isNotEmpty,
                  onClear: controller.clearHistory,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: theme.colorScheme.surface.withOpacity(0.03),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withOpacity(0.08),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: TabBarView(
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          BasicCalculatorView(),
                          ScientificCalculatorView(),
                          AdvancedCalculatorView(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

