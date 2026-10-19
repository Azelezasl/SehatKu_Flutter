import 'package:flutter/material.dart';
import '../models/article.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final _search = TextEditingController();
  final List<Article> _articles = const [
    Article('Pentingnya hidrasi', 'Kenali kebutuhan cairan dan kebiasaan minum yang lebih konsisten.', Icons.water_drop_outlined),
    Article('Tidur berkualitas', 'Rutinitas tidur membantu menjaga energi, fokus, dan suasana hati.', Icons.bedtime_outlined),
    Article('Aktif bergerak', 'Sisihkan waktu untuk bergerak di sela belajar atau bekerja.', Icons.directions_run_rounded),
    Article('Gizi seimbang', 'Lengkapi piring dengan sumber karbohidrat, protein, sayur, dan buah.', Icons.restaurant_outlined),
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
