import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/metric_card.dart';
import '../widgets/habit_tile.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback onOpenTracker;
  const DashboardPage({super.key, required this.onOpenTracker});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<bool> _done = [true, true, false, true];
  final List<Habit> _habits = const [
    Habit('Minum air', '8 gelas', Icons.water_drop_outlined),
    Habit('Tidur', '7–8 jam', Icons.bedtime_outlined),
    Habit('Olahraga', '30 menit', Icons.directions_run_rounded),
    Habit('Sayur/buah', '5 porsi', Icons.eco_outlined),
  ];

  int get completed => _done.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final progress = completed / _done.length;
    final metrics = [
      MetricCard(label: 'Target', value: '$completed/4', icon: Icons.flag_outlined),
      MetricCard(label: 'Progres', value: '${(progress * 100).round()}%', icon: Icons.trending_up_rounded),
      const MetricCard(label: 'Streak', value: '5 hari', icon: Icons.local_fire_department_outlined),
      const MetricCard(label: 'Mood', value: 'Baik', icon: Icons.sentiment_satisfied_alt_rounded),
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        // Asset: gambar banner dari assets/images/, dideklarasikan di pubspec.yaml
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset('assets/images/banner.png', width: double.infinity, height: 150, fit: BoxFit.cover),
              Positioned(
                left: 18,
                bottom: 16,
                right: 18,
                child: Text(
                  'Halo! Sudah sehat hari ini?',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text('Langkah kecil setiap hari, hidup lebih sehat.', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 18),
        // Layout responsif: jumlah kolom grid menyesuaikan lebar layar
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 600 ? 4 : 2;
            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: metrics,
            );
          },
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(children: [
              CircleAvatar(radius: 24, child: Icon(Icons.sentiment_satisfied_alt_rounded, color: Theme.of(context).colorScheme.primary)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Mood hari ini', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text('Baik • Jangan lupa dengarkan tubuhmu.'),
              ])),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Pelacak kebiasaan', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          TextButton.icon(onPressed: widget.onOpenTracker, icon: const Icon(Icons.bar_chart_rounded), label: const Text('Statistik')),
        ]),
        const SizedBox(height: 10),
        ...List.generate(_habits.length, (i) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: HabitTile(
            habit: _habits[i],
            checked: _done[i],
            onTap: () => setState(() => _done[i] = !_done[i]),
          ),
        )),
        const SizedBox(height: 8),
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Row(children: [
              Icon(Icons.lightbulb_outline_rounded),
              SizedBox(width: 12),
              Expanded(child: Text('Tips: minum air setelah bangun agar tubuh segera terhidrasi.', style: TextStyle(fontWeight: FontWeight.w600))),
            ]),
          ),
        ),
      ],
    );
  }
}
