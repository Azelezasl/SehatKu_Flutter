import 'package:flutter/material.dart';

/// Model data sederhana untuk satu kebiasaan sehat yang dipantau di Dashboard.
class Habit {
  final String title;
  final String target;
  final IconData icon;
  const Habit(this.title, this.target, this.icon);
}
