import 'package:flutter/material.dart';
import '../widgets/app_card.dart';
import '../widgets/progress_card.dart';
import '../widgets/habit_card.dart';
import '../widgets/section_title.dart';
import 'mood_screen.dart';
import 'bmi_screen.dart';
import 'education_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 700;
          final habits = [
            ('Minum Air', '6 gelas', Icons.water_drop, .75, '6/8'),
            ('Tidur', '7 jam', Icons.bedtime, .88, '7/8'),
            ('Olahraga', '20 menit', Icons.directions_run, .65, '20m'),
            ('Sayur/Buah', '2 porsi', Icons.eco, .50, '2/4'),
          ];

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo! 👋',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Sudah sehat hari ini?'),
                const SizedBox(height: 20),
                const ProgressCard(completed: 3, total: 4, streak: 5),
                const SizedBox(height: 22),
                const SectionTitle(title: 'Kebiasaan hari ini'),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: habits.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: wide ? 2 : 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: wide ? 2.4 : 2.7,
                  ),
                  itemBuilder: (context, index) {
                    final h = habits[index];
                    return HabitCard(
                      title: h.$1,
                      subtitle: h.$2,
                      icon: h.$3,
                      progress: h.$4,
                      value: h.$5,
                      onAdd: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${h.$1} berhasil dicatat.')),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 22),
                const SectionTitle(title: 'Aksi cepat'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.mood,
                        title: 'Jurnal Mood',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MoodScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.monitor_weight,
                        title: 'BMI',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BmiScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _QuickAction(
                  icon: Icons.menu_book,
                  title: 'Edukasi kesehatan',
                  wide: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EducationScreen()),
                  ),
                ),
                const SizedBox(height: 22),
                AppCard(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.12),
                        child: Icon(
                          Icons.lightbulb_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tips hari ini',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 4),
                            Text('Minum air setelah bangun untuk memulai hari dengan baik.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool wide;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.onTap,
    this.wide = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(.12),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
