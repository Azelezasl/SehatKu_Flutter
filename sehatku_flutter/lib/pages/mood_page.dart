import 'package:flutter/material.dart';
import '../widgets/history_tile.dart';

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
      const Text('Pilih suasana hati dan tambahkan catatan singkat.'),
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
      const HistoryTile(day: 'Kemarin', mood: 'Biasa saja', note: 'Cukup produktif hari ini.'),
      const HistoryTile(day: '2 hari lalu', mood: 'Baik', note: 'Sempat olahraga sore.'),
    ]);
  }

  void _save(BuildContext context) {
    _note.clear();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Mood "${_moods[_mood]}" berhasil disimpan.')));
  }
}
