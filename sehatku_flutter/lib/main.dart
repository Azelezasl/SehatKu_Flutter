import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/main_shell.dart';

void main() {
  runApp(const SehatKuApp());
}

class SehatKuApp extends StatefulWidget {
  const SehatKuApp({super.key});

  @override
  State<SehatKuApp> createState() => _SehatKuAppState();
}

class _SehatKuAppState extends State<SehatKuApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool dark) {
    setState(() => _themeMode = dark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SehatKu',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: MainShell(onToggleTheme: _toggleTheme, isDark: _themeMode == ThemeMode.dark),
    );
  }
}
