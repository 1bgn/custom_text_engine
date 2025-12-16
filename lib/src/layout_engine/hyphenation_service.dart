import 'dart:ui' as ui;

import 'package:quiver/collection.dart' show LruMap;

import '../model/text_inline_element.dart';
import 'hyphenator.dart';
import 'layout_caches.dart';
typedef HyphenateCallback = String Function(String input);
class HyphenationService {
  final Hyphenator hyphenator;
  final LayoutCaches caches;
  final LruMap<String, String> hyphenCache;
  final HyphenateCallback? hyphenateOverride;
  HyphenationService({
    required this.hyphenator,
    required this.caches,
    int cacheSize = 10000,
    this.hyphenateOverride,
  }) : hyphenCache = LruMap<String, String>(maximumSize: cacheSize);

  String hyphenateCached(String core) {
    final cached = hyphenCache[core];
    if (cached != null) return cached;

    final String h = (hyphenateOverride != null)
        ? hyphenateOverride!(core)
        : hyphenator.hyphenate(core);
    hyphenCache[core] = h;
    return h;
  }

  (TextInlineElement, TextInlineElement)? trySplitBySoftHyphen(
      TextInlineElement elem,
      double remainingWidth,
      ui.TextDirection dir,
      ) {
    final full = elem.text;

    final trailingMatch = RegExp(r'\s+$').firstMatch(full);
    final trailingWs = trailingMatch?.group(0) ?? '';
    final core = trailingWs.isEmpty
        ? full
        : full.substring(0, full.length - trailingWs.length);

    final hyphCore = hyphenateCached(core);

    for (int i = hyphCore.length - 1; i >= 0; i--) {
      if (hyphCore.codeUnitAt(i) == 0x00AD /* SHY */) {
        if (i < hyphCore.length - 1) {
          final leftStr = hyphCore.substring(0, i) + '-';
          final rightStr = hyphCore.substring(i + 1) + trailingWs;

          final test = TextInlineElement(text: leftStr, style: elem.style);
          caches.performLayoutWithCache(test, remainingWidth, dir);

          if (test.width <= remainingWidth) {
            return (
            TextInlineElement(text: leftStr, style: elem.style),
            TextInlineElement(text: rightStr, style: elem.style),
            );
          }
        }
      }
    }

    return null;
  }

  (TextInlineElement, TextInlineElement)? forceSplitByWidth(
      TextInlineElement e,
      double maxWidth,
      ui.TextDirection dir,
      ) {
    final s = e.text;
    if (s.isEmpty) return null;

    int lo = 1, hi = s.length, best = 0;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      final test = TextInlineElement(text: s.substring(0, mid), style: e.style);
      caches.performLayoutWithCache(test, maxWidth, dir);

      if (test.width <= maxWidth) {
        best = mid;
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }

    if (best == 0) return null;

    return (
    TextInlineElement(text: s.substring(0, best), style: e.style),
    TextInlineElement(text: s.substring(best), style: e.style),
    );
  }
}
