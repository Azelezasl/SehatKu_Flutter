import 'package:flutter/material.dart';
import '../utils/breakpoints.dart';
import '../widgets/section_title.dart';
import '../widgets/summary_row.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  static const EdgeInsets _padding = EdgeInsets.fromLTRB(20, 8, 20, 28);
  static const List<double> _values = [0.55, 0.72, 0.62, 0.85, 0.68, 0.78, 0.68];
  static const List<String> _days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final main = [..._average(), const SizedBox(height: 16), ..._chart(context)];
        final side = _summary();

        if (constraints.maxWidth >= kTwoPaneMinWidth) {
          // Layar lebar: grafik di kiri, ringkasan di kanan.
          return SingleChildScrollView(
            padding: _padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: main)),
                const SizedBox(width: 24),
                Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: side)),
              ],
            ),
          );
        }
        return ListView(padding: _padding, children: [...main, const SizedBox(height: 16), ...side]);
      },
    );
  }

  List<Widget> _average() {
    return [
      const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Rata-rata progres', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Text('68%', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
                Text('Minggu ini • 7 hari'),
              ]),
            ),
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(alignment: Alignment.center, children: [
                CircularProgressIndicator(value: .68, strokeWidth: 9),
                Text('68%', style: TextStyle(fontWeight: FontWeight.w800)),
              ]),
            ),
          ]),
        ),
      ),
    ];
  }

  List<Widget> _chart(BuildContext context) {
    return [
      const SectionTitle('Tren kebiasaan'),
      const SizedBox(height: 12),
      Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 16),
          child: SizedBox(
            height: 230,
            // Setiap kolom batang memakai Expanded, jadi lebar batang ikut menyesuaikan layar.
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                _values.length,
                (i) => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${(_values[i] * 100).round()}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Container(
                          height: 160 * _values[i],
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(_days[i], style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _summary() {
    return const [
      SectionTitle('Ringkasan'),
      SizedBox(height: 10),
      SummaryRow(icon: Icons.water_drop_outlined, title: 'Air', value: '6,8 / 8 gelas'),
      SummaryRow(icon: Icons.bedtime_outlined, title: 'Tidur', value: '7,1 / 8 jam'),
      SummaryRow(icon: Icons.directions_run_rounded, title: 'Olahraga', value: '24 / 30 menit'),
      SummaryRow(icon: Icons.eco_outlined, title: 'Sayur/buah', value: '4 / 5 porsi'),
    ];
  }
}
