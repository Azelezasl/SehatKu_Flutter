import 'package:flutter/material.dart';

/// Warna dasar (seed) tema aplikasi, dipakai untuk tema terang dan gelap
/// lewat [ColorScheme.fromSeed] (Material Design 3).
const Color seedColor = Color(0xFF2E7D5B);

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light),
    scaffoldBackgroundColor: const Color(0xFFF7FAF8),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
  );
}
