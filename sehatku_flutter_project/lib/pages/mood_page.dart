import 'package:flutter/material.dart';
import '../utils/breakpoints.dart';
import '../widgets/history_tile.dart';
import '../widgets/mood_option.dart';
import '../widgets/section_title.dart';

/// Satu catatan riwayat: hari, indeks mood, dan catatan.
class _MoodEntry {
  final String day;
  final int mood;
  final String note;
  const _MoodEntry(this.day, this.mood, this.note);
}

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  static const EdgeInsets _padding = EdgeInsets.fromLTRB(20, 8, 20, 28);
  static const List<String> _moods = ['Sangat sedih', 'Kurang baik', 'Biasa saja', 'Baik', 'Sangat baik'];
  static const List<IconData> _icons = [
    Icons.sentiment_very_dissatisfied,
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied,
  ];

  int _mood = 2;
  final _note = TextEditingController();
  final List<_MoodEntry> _history = [
    const _MoodEntry('Kemarin', 2, 'Cukup produktif hari ini.'),
    const _MoodEntry('2 hari lalu', 3, 'Sempat olahraga sore.'),
  ];

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery: orientasi perangkat menentukan tinggi kolom catatan (landscape lebih pendek).
    final landscape = MediaQuery.orientationOf(context) == Orientation.landscape;

    // LayoutBuilder: tata letak ditentukan lebar area konten, bukan orientasi kotaknya.
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoPane = constraints.maxWidth >= kTwoPaneMinWidth;
        final picker = _picker(context);
        final form = _form(landscape);

        return ListView(
          padding: _padding,
          children: [
            Text('Bagaimana harimu?', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Pilih suasana hati dan tambahkan catatan singkat.'),
            const SizedBox(height: 18),
            if (twoPane)
              // Layar lebar: pilihan mood dan form catatan berdampingan.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: picker),
                  const SizedBox(width: 16),
                  Expanded(child: form),
                ],
              )
            else ...[
              // Layar sempit: ditumpuk ke bawah.
              picker,
              const SizedBox(height: 8),
              form,
            ],
            const SizedBox(height: 20),
            const SectionTitle('Riwayat'),
            const SizedBox(height: 10),
            for (final e in _history)
              HistoryTile(day: e.day, mood: _moods[e.mood], note: e.note, icon: _icons[e.mood]),
          ],
        );
      },
    );
  }

  /// Kartu pilihan mood: lima pilihan sama lebar dalam satu baris.
  Widget _picker(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle('Suasana hati'),
            const SizedBox(height: 12),
            // IntrinsicHeight + stretch: kelima pilihan selalu sama tinggi,
            // walau ada label satu baris dan dua baris.
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < _moods.length; i++)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: i == 0 ? 0 : 6),
                        child: MoodOption(
                          icon: _icons[i],
                          label: _moods[i],
                          selected: _mood == i,
                          onTap: () => setState(() => _mood = i),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('Dipilih: ${_moods[_mood]}', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  /// Kartu catatan dan tombol simpan.
  Widget _form(bool landscape) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _note,
              minLines: landscape ? 2 : 4,
              maxLines: landscape ? 3 : 5,
              decoration: const InputDecoration(
                labelText: 'Catatan',
                hintText: 'Catatan singkat…',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    final text = _note.text.trim();
    final entry = _MoodEntry('Hari ini', _mood, text.isEmpty ? 'Tanpa catatan.' : text);
    setState(() {
      // Satu catatan per hari: simpan ulang menimpa catatan "Hari ini".
      if (_history.isNotEmpty && _history.first.day == 'Hari ini') {
        _history[0] = entry;
      } else {
        _history.insert(0, entry);
      }
      _note.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood "${_moods[_mood]}" berhasil disimpan.')),
    );
  }
}
