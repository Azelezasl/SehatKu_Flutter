import 'package:flutter/material.dart';

/// Model data sederhana untuk satu artikel edukasi kesehatan.
class Article {
  final String title;
  final String body;
  final IconData icon;
  const Article(this.title, this.body, this.icon);
}
