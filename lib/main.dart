import 'package:flutter/material.dart';

void main() {
  runApp(const SehatKuApp());
}

class SehatKuApp extends StatefulWidget {
  const SehatKuApp({super.key});

  @override
  State<SehatKuApp> createState() => _SehatKuAppState();
}

class _SehatKuAppState extends State<SehatKuApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme(bool dark) {
    setState(() => _themeMode = dark ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF2E7D5B);
    return MaterialApp(
      title: 'SehatKu',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
        scaffoldBackgroundColor: const Color(0xFFF7FAF8),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: MainShell(onToggleTheme: _toggleTheme, isDark: _themeMode == ThemeMode.dark),
    );
  }
}

class MainShell extends StatefulWidget {
  final void Function(bool) onToggleTheme;
  final bool isDark;
  const MainShell({super.key, required this.onToggleTheme, required this.isDark});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  final List<String> _titles = const ['Beranda', 'Statistik', 'Jurnal Mood', 'Edukasi', 'Profil'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(onOpenTracker: () => setState(() => _index = 1)),
      const StatisticsPage(),
      const MoodPage(),
      const EducationPage(),
      ProfilePage(isDark: widget.isDark, onToggleTheme: widget.onToggleTheme),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index], style: const TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => _showSnack(context, 'Pengingat sehat hari ini aktif.'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(child: IndexedStack(index: _index, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Statistik'),
          NavigationDestination(icon: Icon(Icons.mood_outlined), selectedIcon: Icon(Icons.mood), label: 'Jurnal'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Edukasi'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final VoidCallback onOpenTracker;
  const DashboardPage({super.key, required this.onOpenTracker});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<bool> _done = [true, true, false, true];
  final List<_Habit> _habits = const [
    _Habit('Minum air', '8 gelas', Icons.water_drop_outlined),
    _Habit('Tidur', '7–8 jam', Icons.bedtime_outlined),
    _Habit('Olahraga', '30 menit', Icons.directions_run_rounded),
    _Habit('Sayur/buah', '5 porsi', Icons.eco_outlined),
  ];

  int get completed => _done.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final progress = completed / _done.length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Text('Halo! Sudah sehat hari ini?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text('Langkah kecil setiap hari, hidup lebih sehat.', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 18),
        Row(children: [
          Expanded(child: _MetricCard(label: 'Target', value: '$completed/4', icon: Icons.flag_outlined)),
          const SizedBox(width: 12),
          Expanded(child: _MetricCard(label: 'Progres', value: '${(progress * 100).round()}%', icon: Icons.trending_up_rounded)),
          const SizedBox(width: 12),
          Expanded(child: _MetricCard(label: 'Streak', value: '5 hari', icon: Icons.local_fire_department_outlined)),
        ]),
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
          child: _HabitTile(
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

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const values = [0.55, 0.72, 0.62, 0.85, 0.68, 0.78, 0.68];
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Rata-rata progres', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            Text('68%', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
            Text('Minggu ini • 7 hari'),
          ])),
          SizedBox(width: 90, height: 90, child: Stack(alignment: Alignment.center, children: [
            CircularProgressIndicator(value: .68, strokeWidth: 9),
            Text('68%', style: TextStyle(fontWeight: FontWeight.w800)),
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
        const _SummaryRow(icon: Icons.water_drop_outlined, title: 'Air', value: '6,8 / 8 gelas'),
        const _SummaryRow(icon: Icons.bedtime_outlined, title: 'Tidur', value: '7,1 / 8 jam'),
        const _SummaryRow(icon: Icons.directions_run_rounded, title: 'Olahraga', value: '24 / 30 menit'),
        const _SummaryRow(icon: Icons.eco_outlined, title: 'Sayur/buah', value: '4 / 5 porsi'),
      ],
    );
  }
}

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  int _mood = 2;
  final _note = TextEditingController();
  final List<String> _moods = ['Sangat sedih', 'Kurang baik', 'Biasa saja', 'Baik', 'Sangat baik'];
  final List<IconData> _icons = [Icons.sentiment_very_dissatisfied, Icons.sentiment_dissatisfied, Icons.sentiment_neutral, Icons.sentiment_satisfied, Icons.sentiment_very_satisfied];

  @override
  void dispose() { _note.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
      Text('Bagaimana harimu?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Text('Pilih suasana hati dan tambahkan catatan singkat.'),
      const SizedBox(height: 18),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        Wrap(spacing: 12, runSpacing: 12, alignment: WrapAlignment.center, children: List.generate(_moods.length, (i) => ChoiceChip(
          label: Column(mainAxisSize: MainAxisSize.min, children: [Icon(_icons[i]), const SizedBox(height: 4), Text(_moods[i], style: const TextStyle(fontSize: 11))]),
          selected: _mood == i,
          onSelected: (_) => setState(() => _mood = i),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ))),
        const SizedBox(height: 18),
        TextField(controller: _note, maxLines: 4, decoration: const InputDecoration(hintText: 'Catatan singkat…', labelText: 'Catatan')),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: () => _save(context), icon: const Icon(Icons.save_outlined), label: const Text('Simpan'))),
      ]))),
      const SizedBox(height: 18),
      Text('Riwayat', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      const _HistoryTile(day: 'Kemarin', mood: 'Biasa saja', note: 'Cukup produktif hari ini.'),
      const _HistoryTile(day: '2 hari lalu', mood: 'Baik', note: 'Sempat olahraga sore.'),
    ]);
  }

  void _save(BuildContext context) {
    _note.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mood "${_moods[_mood]}" berhasil disimpan.')));
  }
}

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final _search = TextEditingController();
  final List<_Article> _articles = const [
    _Article('Pentingnya hidrasi', 'Kenali kebutuhan cairan dan kebiasaan minum yang lebih konsisten.', Icons.water_drop_outlined),
    _Article('Tidur berkualitas', 'Rutinitas tidur membantu menjaga energi, fokus, dan suasana hati.', Icons.bedtime_outlined),
    _Article('Aktif bergerak', 'Sisihkan waktu untuk bergerak di sela belajar atau bekerja.', Icons.directions_run_rounded),
    _Article('Gizi seimbang', 'Lengkapi piring dengan sumber karbohidrat, protein, sayur, dan buah.', Icons.restaurant_outlined),
  ];

  @override
  void dispose() { _search.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final q = _search.text.toLowerCase();
    final visible = _articles.where((a) => a.title.toLowerCase().contains(q) || a.body.toLowerCase().contains(q)).toList();
    return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
      Text('Edukasi kesehatan', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 12),
      TextField(controller: _search, onChanged: (_) => setState(() {}), decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Cari artikel')),
      const SizedBox(height: 16),
      ...visible.map((a) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Card(child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(child: Icon(a.icon)),
        title: Text(a.title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Padding(padding: const EdgeInsets.only(top: 6), child: Text(a.body)),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () => showDialog(context: context, builder: (_) => AlertDialog(title: Text(a.title), content: Text(a.body), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tutup'))])),
      )))),
      if (visible.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('Artikel tidak ditemukan.'))),
    ]);
  }
}

class ProfilePage extends StatefulWidget {
  final bool isDark;
  final void Function(bool) onToggleTheme;
  const ProfilePage({super.key, required this.isDark, required this.onToggleTheme});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _name = TextEditingController(text: 'Pengguna');
  final _height = TextEditingController(text: '170');
  final _weight = TextEditingController(text: '65');
  TimeOfDay _reminder = const TimeOfDay(hour: 8, minute: 0);
  double? _bmi;

  @override
  void dispose() { _name.dispose(); _height.dispose(); _weight.dispose(); super.dispose(); }

  String get _bmiCategory {
    final bmi = _bmi;
    if (bmi == null) return '-';
    if (bmi < 18.5) return 'Berat badan kurang';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Berat badan berlebih';
    return 'Obesitas';
  }

  void _calculateBmi() {
    final h = double.tryParse(_height.text.replaceAll(',', '.'));
    final w = double.tryParse(_weight.text.replaceAll(',', '.'));
    if (h == null || w == null || h <= 0 || w <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan tinggi dan berat yang valid.')));
      return;
    }
    setState(() => _bmi = w / ((h / 100) * (h / 100)));
  }

  @override
  Widget build(BuildContext context) {
    final time = _reminder.format(context);
    return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [
        const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
        const SizedBox(width: 14),
        Expanded(child: TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nama'))),
      ]))),
      const SizedBox(height: 14),
      Card(child: Column(children: [
        SwitchListTile(title: const Text('Mode gelap'), subtitle: const Text('Gunakan tema Material Design 3'), value: widget.isDark, onChanged: widget.onToggleTheme),
        ListTile(leading: const Icon(Icons.alarm_outlined), title: const Text('Pengingat harian'), subtitle: Text('Jam pengingat: $time'), trailing: const Icon(Icons.chevron_right_rounded), onTap: _pickTime),
      ])),
      const SizedBox(height: 20),
      Text('Kalkulator BMI', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
        Row(children: [Expanded(child: TextField(controller: _height, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Tinggi (cm)'))), const SizedBox(width: 12), Expanded(child: TextField(controller: _weight, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Berat (kg)')))]),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: _calculateBmi, icon: const Icon(Icons.calculate_outlined), label: const Text('Hitung'))),
        if (_bmi != null) Padding(padding: const EdgeInsets.only(top: 14), child: Row(children: [const Icon(Icons.monitor_weight_outlined), const SizedBox(width: 10), Text('BMI ${_bmi!.toStringAsFixed(1)} · $_bmiCategory', style: const TextStyle(fontWeight: FontWeight.w800))])),
      ]))),
      const SizedBox(height: 14),
      FilledButton.tonalIcon(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil tersimpan.'))), icon: const Icon(Icons.save_outlined), label: const Text('Simpan pengaturan')),
    ]);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _reminder);
    if (picked != null) setState(() => _reminder = picked);
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _MetricCard({required this.label, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, size: 22), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(fontSize: 12))])));
}

class _Habit {
  final String title, target;
  final IconData icon;
  const _Habit(this.title, this.target, this.icon);
}

class _HabitTile extends StatelessWidget {
  final _Habit habit;
  final bool checked;
  final VoidCallback onTap;
  const _HabitTile({required this.habit, required this.checked, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7), leading: CircleAvatar(child: Icon(habit.icon)), title: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(habit.target), trailing: IconButton.filledTonal(onPressed: onTap, icon: Icon(checked ? Icons.check : Icons.add))));
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String title, value;
  const _SummaryRow({required this.icon, required this.title, required this.value});
  @override
  Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(leading: CircleAvatar(child: Icon(icon)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), trailing: Text(value)));
}

class _HistoryTile extends StatelessWidget {
  final String day, mood, note;
  const _HistoryTile({required this.day, required this.mood, required this.note});
  @override
  Widget build(BuildContext context) => Card(margin: const EdgeInsets.only(bottom: 10), child: ListTile(leading: const CircleAvatar(child: Icon(Icons.mood)), title: Text('$day · $mood', style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(note)));
}

class _Article {
  final String title, body;
  final IconData icon;
  const _Article(this.title, this.body, this.icon);
}

void _showSnack(BuildContext context, String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
