import 'package:flutter/material.dart';
import '../widgets/app_card.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  static const articles = [
    ('Pentingnya hidrasi', Icons.water_drop, 'Kenali pentingnya mencukupi kebutuhan cairan dalam aktivitas harian.'),
    ('Tidur berkualitas', Icons.bedtime, 'Kebiasaan tidur yang teratur dapat membantu menjaga rutinitas harian.'),
    ('Aktif bergerak', Icons.directions_run, 'Sisihkan waktu untuk bergerak di sela aktivitas duduk.'),
    ('Gizi seimbang', Icons.restaurant, 'Perhatikan variasi makanan dan biasakan memilih makanan yang lebih seimbang.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edukasi Kesehatan')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Cari artikel',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 20),
          ...articles.map(
            (article) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(article.$1),
                    content: Text(article.$3),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Icon(article.$2),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        article.$1,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
