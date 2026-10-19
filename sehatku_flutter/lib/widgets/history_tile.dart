import 'package:flutter/material.dart';

/// Reusable widget: satu baris riwayat suasana hati di halaman Jurnal Mood.
class HistoryTile extends StatelessWidget {
  final String day;
  final String mood;
  final String note;
  const HistoryTile({super.key, required this.day, required this.mood, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.mood)),
        title: Text('$day · $mood', style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(note),
      ),
    );
  }
}
