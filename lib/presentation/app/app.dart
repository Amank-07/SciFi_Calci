import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/app_themes.dart';
import '../screens/splash_screen.dart';
import '../state/theme_notifier.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SciFi Calci',
      themeMode: themeNotifier.themeMode,
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      home: const SplashScreen(),
    );
  }
}

