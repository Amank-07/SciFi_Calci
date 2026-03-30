import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C4DFF),
      brightness: Brightness.dark,
    );

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: colorScheme.copyWith(
        primary: const Color(0xFF7C4DFF),
        secondary: const Color(0xFF00E5FF),
      ),
      scaffoldBackgroundColor: const Color(0xFF070A14),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF070A14),
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      useMaterial3: true,
      textTheme: ThemeData.dark().textTheme.copyWith(
            titleLarge: const TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
    );
  }

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C4DFF),
      brightness: Brightness.light,
    );

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme.copyWith(
        primary: const Color(0xFF5E35FF),
        secondary: const Color(0xFF008FA1),
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F7FF),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFF5F7FF),
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}

