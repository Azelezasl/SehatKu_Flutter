import 'package:flutter/material.dart';
import '../models/highlight_item.dart';

/// Reusable widget: carousel horizontal memakai [CarouselView] (Material 3).
/// Lebar tiap slide responsif: 78% lebar area di layar sempit, tetap 320 di layar lebar.
class HighlightCarousel extends StatelessWidget {
  final List<HighlightItem> items;
  final double height;
  const HighlightCarousel({super.key, required this.items, this.height = 170});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = <(Color, Color)>[
      (scheme.primaryContainer, scheme.onPrimaryContainer),
      (scheme.secondaryContainer, scheme.onSecondaryContainer),
      (scheme.tertiaryContainer, scheme.onTertiaryContainer),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemExtent = constraints.maxWidth >= 600 ? 320.0 : constraints.maxWidth * 0.78;
        return SizedBox(
          height: height,
          child: CarouselView(
            itemExtent: itemExtent,
            shrinkExtent: itemExtent * 0.6,
            itemSnapping: true,
            children: [
              for (var i = 0; i < items.length; i++)
                _Slide(
                  item: items[i],
                  extent: itemExtent,
                  background: palette[i % palette.length].$1,
                  foreground: palette[i % palette.length].$2,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Slide extends StatelessWidget {
  final HighlightItem item;
  final double extent;
  final Color background;
  final Color foreground;
  const _Slide({required this.item, required this.extent, required this.background, required this.foreground});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background,
      // OverflowBox: isi slide tetap selebar [extent] saat slide menyusut di tepi carousel,
      // sehingga teks tidak overflow (bagian berlebih dipotong oleh CarouselView).
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        minWidth: extent,
        maxWidth: extent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.icon, size: 30, color: foreground),
              const SizedBox(height: 10),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: foreground),
              ),
              const SizedBox(height: 4),
              Text(
                item.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
