import 'package:flutter/material.dart';
import '../widgets/habit_card.dart';
import '../widgets/section_title.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final Map<String, double> _progress = {
    'Minum Air': .75,
    'Tidur': .88,
    'Olahraga': .65,
    'Sayur/Buah': .50,
  };

  final Map<String, String> _values = {
    'Minum Air': '6/8',
    'Tidur': '7/8',
    'Olahraga': '20m',
    'Sayur/Buah': '2/4',
  };

  void _addHabit(String title) {
    setState(() {
      _progress[title] = ((_progress[title] ?? 0) + .125).clamp(0, 1);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title diperbarui.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Minum Air', 'Target 8 gelas', Icons.water_drop),
      ('Tidur', 'Target 8 jam', Icons.bedtime),
      ('Olahraga', 'Target 30 menit', Icons.directions_run),
      ('Sayur/Buah', 'Target 4 porsi', Icons.eco),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Pelacak Kebiasaan',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          const Text('Catat kebiasaan sehatmu dengan cepat.'),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Kebiasaan hari ini'),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: HabitCard(
                title: item.$1,
                subtitle: item.$2,
                icon: item.$3,
                progress: _progress[item.$1] ?? 0,
                value: _values[item.$1] ?? '-',
                onAdd: () => _addHabit(item.$1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
