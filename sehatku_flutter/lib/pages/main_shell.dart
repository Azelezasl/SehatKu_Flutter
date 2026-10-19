import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'statistics_page.dart';
import 'mood_page.dart';
import 'education_page.dart';
import 'profile_page.dart';

/// Kerangka utama aplikasi: AppBar + body halaman aktif + navigasi bawah.
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

void _showSnack(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
