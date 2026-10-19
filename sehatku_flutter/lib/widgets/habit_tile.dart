import 'package:flutter/material.dart';
import '../models/habit.dart';

/// Reusable widget: satu baris kebiasaan, dipakai berulang di daftar pelacak.
class HabitTile extends StatelessWidget {
  final Habit habit;
  final bool checked;
  final VoidCallback onTap;
  const HabitTile({super.key, required this.habit, required this.checked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        leading: CircleAvatar(child: Icon(habit.icon)),
        title: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(habit.target),
        trailing: IconButton.filledTonal(onPressed: onTap, icon: Icon(checked ? Icons.check : Icons.add)),
      ),
    );
  }
}
