import 'package:flutter/material.dart';
import '../utils/breakpoints.dart';
import 'dashboard_page.dart';
import 'statistics_page.dart';
import 'mood_page.dart';
import 'education_page.dart';
import 'profile_page.dart';

class _Destination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  const _Destination(this.label, this.icon, this.selectedIcon);
}

const List<_Destination> _destinations = [
  _Destination('Beranda', Icons.home_outlined, Icons.home),
  _Destination('Statistik', Icons.bar_chart_outlined, Icons.bar_chart),
  _Destination('Jurnal', Icons.mood_outlined, Icons.mood),
  _Destination('Edukasi', Icons.menu_book_outlined, Icons.menu_book),
  _Destination('Profil', Icons.person_outline, Icons.person),
];

/// Kerangka utama aplikasi dengan navigasi adaptif berdasarkan lebar layar:
/// - compact  (< 600)    : NavigationBar di bawah (HP portrait)
/// - medium   (600–839)  : NavigationRail ringkas di kiri (HP landscape / tablet kecil)
/// - expanded (>= 840)   : NavigationRail extended dengan label di kiri (tablet / desktop / web)
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

  void _select(int value) => setState(() => _index = value);

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(onOpenTracker: () => _select(1)),
      const StatisticsPage(),
      const MoodPage(),
      const EducationPage(),
      ProfilePage(isDark: widget.isDark, onToggleTheme: widget.onToggleTheme),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = windowSizeOf(constraints.maxWidth);
        final useRail = size != WindowSize.compact;
        final extended = size == WindowSize.expanded;

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
          body: SafeArea(
            child: Row(
              children: [
                if (useRail) ...[
                  NavigationRail(
                    selectedIndex: _index,
                    onDestinationSelected: _select,
                    extended: extended,
                    // Saat extended, label sudah tampil di samping ikon.
                    labelType: extended ? NavigationRailLabelType.none : NavigationRailLabelType.selected,
                    destinations: [
                      for (final d in _destinations)
                        NavigationRailDestination(
                          icon: Icon(d.icon),
                          selectedIcon: Icon(d.selectedIcon),
                          label: Text(d.label),
                        ),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                ],
                // Key menjaga state halaman saat navigasi berganti antara bar dan rail.
                Expanded(
                  key: const ValueKey('content'),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                      child: IndexedStack(index: _index, children: pages),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: useRail
              ? null
              : NavigationBar(
                  selectedIndex: _index,
                  onDestinationSelected: _select,
                  destinations: [
                    for (final d in _destinations)
                      NavigationDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: d.label,
                      ),
                  ],
                ),
        );
      },
    );
  }
}

void _showSnack(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
