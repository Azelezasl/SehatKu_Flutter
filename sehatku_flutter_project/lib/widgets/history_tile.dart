import 'package:flutter/material.dart';

/// Reusable widget: satu baris riwayat suasana hati di halaman Jurnal Mood.
class HistoryTile extends StatelessWidget {
  final String day;
  final String mood;
  final String note;
  final IconData icon;
  const HistoryTile({
    super.key,
    required this.day,
    required this.mood,
    required this.note,
    this.icon = Icons.mood,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text('$day · $mood', style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(note),
      ),
    );
  }
}
