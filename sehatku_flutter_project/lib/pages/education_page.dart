import 'package:flutter/material.dart';
import '../models/article.dart';
import '../models/highlight_item.dart';
import '../widgets/highlight_carousel.dart';
import '../widgets/section_title.dart';

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
    Article('Kelola stres', 'Latihan napas dan jeda singkat membantu menenangkan pikiran.', Icons.self_improvement_outlined),
    Article('Cuci tangan', 'Cuci tangan dengan sabun selama 20 detik membantu mencegah penyebaran kuman.', Icons.clean_hands_outlined),
  ];

  @override
  void dispose() { _search.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final q = _search.text.toLowerCase();
    final visible = _articles.where((a) => a.title.toLowerCase().contains(q) || a.body.toLowerCase().contains(q)).toList();
    final featured = _articles.take(4).map((a) => HighlightItem(a.title, a.body, a.icon)).toList();

    return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 28), children: [
      Text('Edukasi kesehatan', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 12),
      TextField(controller: _search, onChanged: (_) => setState(() {}), decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Cari artikel')),
      const SizedBox(height: 16),
      // Carousel artikel pilihan, disembunyikan saat pengguna sedang mencari.
      if (q.isEmpty) ...[
        const SectionTitle('Artikel pilihan'),
        const SizedBox(height: 10),
        HighlightCarousel(items: featured),
        const SizedBox(height: 20),
        const SectionTitle('Semua artikel'),
        const SizedBox(height: 10),
      ],
      // GridView.builder adaptif: 1 kolom di layar sempit, 2–3 kolom di layar lebar.
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 520,
          mainAxisExtent: 148,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: visible.length,
        itemBuilder: (context, i) => _ArticleCard(article: visible[i]),
      ),
      if (visible.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('Artikel tidak ditemukan.'))),
    ]);
  }
}

class _ArticleCard extends StatelessWidget {
  final Article article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(child: Icon(article.icon)),
        title: Text(article.title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(article.body, maxLines: 3, overflow: TextOverflow.ellipsis),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        // Adaptive: dialog tampil sesuai platform (Material di Android/web, Cupertino di iOS/macOS).
        onTap: () => showAdaptiveDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog.adaptive(
            title: Text(article.title),
            content: Text(article.body),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Tutup')),
            ],
          ),
        ),
      ),
    );
  }
}
