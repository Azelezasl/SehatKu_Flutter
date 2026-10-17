import 'package:flutter/material.dart';
import '../widgets/app_card.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  String _mood = 'Baik';
  final _noteController = TextEditingController();

  final moods = const [
    ('Sangat baik', '😄'),
    ('Baik', '🙂'),
    ('Biasa saja', '😐'),
    ('Kurang baik', '🙁'),
    ('Buruk', '😞'),
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jurnal mood berhasil disimpan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jurnal Suasana Hati')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Bagaimana harimu?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              children: moods.map((item) {
                final selected = _mood == item.$1;
                return ListTile(
                  leading: Text(item.$2, style: const TextStyle(fontSize: 28)),
                  title: Text(item.$1),
                  trailing: selected
                      ? Icon(Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                  onTap: () => setState(() => _mood = item.$1),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Catatan singkat',
              hintText: 'Tulis apa yang kamu rasakan hari ini...',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Simpan'),
          ),
          const SizedBox(height: 24),
          const Text(
            'Riwayat terakhir',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          const AppCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text('🙂', style: TextStyle(fontSize: 30)),
              title: Text('Kemarin'),
              subtitle: Text('Biasa saja'),
            ),
          ),
        ],
      ),
    );
  }
}
