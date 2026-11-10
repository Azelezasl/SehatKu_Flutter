import 'package:flutter/material.dart';

/// Satu slide pada carousel: judul, isi singkat, dan ikon.
class HighlightItem {
  final String title;
  final String body;
  final IconData icon;
  const HighlightItem(this.title, this.body, this.icon);
}
