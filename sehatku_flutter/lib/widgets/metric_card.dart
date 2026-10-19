import 'package:flutter/material.dart';

/// Reusable widget: kartu statistik kecil, dipakai berulang di grid metrik Dashboard.
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const MetricCard({super.key, required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 22),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
