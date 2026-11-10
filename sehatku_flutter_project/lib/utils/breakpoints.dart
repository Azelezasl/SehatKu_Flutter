import 'package:flutter/widgets.dart';

/// Kelas ukuran jendela mengikuti panduan Material 3:
/// compact < 600, medium 600–839, expanded >= 840 (dalam logical pixel).
enum WindowSize { compact, medium, expanded }

WindowSize windowSizeOf(double width) {
  if (width < 600) return WindowSize.compact;
  if (width < 840) return WindowSize.medium;
  return WindowSize.expanded;
}

/// Lebar area konten minimum agar halaman memakai tata letak dua panel
/// (Row + Expanded). Di bawah ini halaman jadi satu kolom (ListView).
const double kTwoPaneMinWidth = 720;

/// Batas lebar konten agar tidak terlalu melebar di layar besar.
const double kMaxContentWidth = 1200;

/// Contoh pemakaian MediaQuery: ambil kelas ukuran dari lebar layar saat ini.
extension WindowSizeContext on BuildContext {
  WindowSize get windowSize => windowSizeOf(MediaQuery.sizeOf(this).width);
}
