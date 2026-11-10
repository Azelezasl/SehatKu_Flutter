import 'package:flutter/material.dart';

/// Reusable widget: baris ringkasan satu kebiasaan di halaman Statistik.
class SummaryRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const SummaryRow({super.key, required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        trailing: Text(value),
      ),
    );
  }
}
