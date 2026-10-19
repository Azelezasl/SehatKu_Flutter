import 'package:flutter/material.dart';
import '../widgets/summary_row.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const values = [0.55, 0.72, 0.62, 0.85, 0.68, 0.78, 0.68];
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        const Card(child: Padding(padding: EdgeInsets.all(20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rata-rata progres', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text('68%', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
            Text('Minggu ini • 7 hari'),
          ])),
          const SizedBox(width: 90, height: 90, child: const Stack(alignment: Alignment.center, children: const [
            CircularProgressIndicator(value: .68, strokeWidth: 9),
            Text('68%', style: const TextStyle(fontWeight: FontWeight.w800)),
          ])),
        ]))),
        const SizedBox(height: 16),
        Text('Tren kebiasaan', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Card(child: Padding(padding: const EdgeInsets.fromLTRB(16, 22, 16, 16), child: SizedBox(
          height: 230,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(values.length, (i) => Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('${(values[i] * 100).round()}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Container(width: 28, height: 160 * values[i], decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 8),
              Text(days[i], style: const TextStyle(fontSize: 11)),
            ])),
          ),
        ))),
        const SizedBox(height: 16),
        Text('Ringkasan', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        const SummaryRow(icon: Icons.water_drop_outlined, title: 'Air', value: '6,8 / 8 gelas'),
        const SummaryRow(icon: Icons.bedtime_outlined, title: 'Tidur', value: '7,1 / 8 jam'),
        const SummaryRow(icon: Icons.directions_run_rounded, title: 'Olahraga', value: '24 / 30 menit'),
        const SummaryRow(icon: Icons.eco_outlined, title: 'Sayur/buah', value: '4 / 5 porsi'),
      ],
    );
  }
}
