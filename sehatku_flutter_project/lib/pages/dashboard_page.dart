import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../models/highlight_item.dart';
import '../utils/breakpoints.dart';
import '../widgets/metric_card.dart';
import '../widgets/habit_tile.dart';
import '../widgets/highlight_carousel.dart';
import '../widgets/section_title.dart';

class DashboardPage extends StatefulWidget {
  final VoidCallback onOpenTracker;
  const DashboardPage({super.key, required this.onOpenTracker});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  static const EdgeInsets _padding = EdgeInsets.fromLTRB(20, 8, 20, 28);

  final List<bool> _done = [true, true, false, true];
  final List<Habit> _habits = const [
    Habit('Minum air', '8 gelas', Icons.water_drop_outlined),
    Habit('Tidur', '7–8 jam', Icons.bedtime_outlined),
    Habit('Olahraga', '30 menit', Icons.directions_run_rounded),
    Habit('Sayur/buah', '5 porsi', Icons.eco_outlined),
  ];

  static const List<HighlightItem> _tips = [
    HighlightItem('Minum air', 'Minum segelas air setelah bangun agar tubuh segera terhidrasi.', Icons.water_drop_outlined),
    HighlightItem('Tidur cukup', 'Usahakan tidur 7–8 jam dan bangun di jam yang sama setiap hari.', Icons.bedtime_outlined),
    HighlightItem('Tetap bergerak', 'Jalan kaki 10 menit di sela belajar atau bekerja sudah membantu.', Icons.directions_walk_rounded),
    HighlightItem('Makan sayur', 'Tambahkan sayur atau buah pada setiap makan utama.', Icons.eco_outlined),
  ];

  int get completed => _done.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder: tata letak mengikuti lebar area konten yang tersedia.
    return LayoutBuilder(
      builder: (context, constraints) {
        final overview = _overview(context);
        final tracker = _tracker(context);

        if (constraints.maxWidth >= kTwoPaneMinWidth) {
          // Layar lebar: dua panel berdampingan (Row + Expanded).
          return SingleChildScrollView(
            padding: _padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: overview)),
                const SizedBox(width: 24),
                Expanded(flex: 4, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: tracker)),
              ],
            ),
          );
        }

        // Layar sempit: satu kolom yang bisa di-scroll.
        return ListView(
          padding: _padding,
          children: [...overview, const SizedBox(height: 20), ...tracker],
        );
      },
    );
  }

  /// Panel kiri: banner, metrik, dan carousel tips.
  List<Widget> _overview(BuildContext context) {
    // MediaQuery: tinggi banner menyesuaikan orientasi dan tinggi layar.
    final landscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    final bannerHeight = landscape
        ? 110.0
        : (MediaQuery.sizeOf(context).height * 0.2).clamp(120.0, 180.0).toDouble();

    final progress = completed / _done.length;
    final metrics = [
      MetricCard(label: 'Target', value: '$completed/4', icon: Icons.flag_outlined),
      MetricCard(label: 'Progres', value: '${(progress * 100).round()}%', icon: Icons.trending_up_rounded),
      const MetricCard(label: 'Streak', value: '5 hari', icon: Icons.local_fire_department_outlined),
      const MetricCard(label: 'Mood', value: 'Baik', icon: Icons.sentiment_satisfied_alt_rounded),
    ];

    return [
      // Asset: gambar banner dari assets/images/, dideklarasikan di pubspec.yaml
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.asset('assets/images/banner.png', width: double.infinity, height: bannerHeight, fit: BoxFit.cover),
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
      // GridView.builder: jumlah kolom 2 atau 4 sesuai lebar panel.
      LayoutBuilder(
        builder: (context, c) {
          final columns = c.maxWidth >= 520 ? 4 : 2;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 112,
            ),
            itemCount: metrics.length,
            itemBuilder: (context, i) => metrics[i],
          );
        },
      ),
      const SizedBox(height: 20),
      const SectionTitle('Tips kesehatan'),
      const SizedBox(height: 10),
      // Carousel (CarouselView) berisi tips yang bisa digeser.
      const HighlightCarousel(items: _tips),
    ];
  }

  /// Panel kanan: mood hari ini dan daftar kebiasaan.
  List<Widget> _tracker(BuildContext context) {
    return [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(children: [
            CircleAvatar(radius: 24, child: Icon(Icons.sentiment_satisfied_alt_rounded, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Mood hari ini', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text('Baik • Jangan lupa dengarkan tubuhmu.'),
              ]),
            ),
          ]),
        ),
      ),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const SectionTitle('Pelacak kebiasaan'),
        TextButton.icon(onPressed: widget.onOpenTracker, icon: const Icon(Icons.bar_chart_rounded), label: const Text('Statistik')),
      ]),
      const SizedBox(height: 10),
      // ListView.builder: daftar kebiasaan dibangun per item.
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _habits.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: HabitTile(
            habit: _habits[i],
            checked: _done[i],
            onTap: () => setState(() => _done[i] = !_done[i]),
          ),
        ),
      ),
    ];
  }
}
