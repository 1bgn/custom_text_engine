import 'dart:ui' as ui;

import 'package:quiver/collection.dart' show LruMap;

import '../model/text_inline_element.dart';
import 'hyphenator.dart';
import 'click_inline_element.dart';
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
          final leftSrc = hyphCore.substring(0, i);
          final rightSrc = hyphCore.substring(i + 1);
          final leftStr = leftSrc + '-';
          final rightStr = rightSrc + trailingWs;
          // Длины в исходном тексте: без добавленного '-' и без вставленных мягких переносов
          final leftLen = leftSrc.length - _shyCount(leftSrc);
          final rightLen = rightSrc.length - _shyCount(rightSrc) + trailingWs.length;

          final test = _like(elem, leftStr);
          caches.performLayoutWithCache(test, remainingWidth, dir);

          if (test.width <= remainingWidth) {
            return (
            _like(elem, leftStr, sourceLength: leftLen),
            _like(elem, rightStr, sourceLength: rightLen),
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

    // Разрыв внутри слова между двумя буквами показываем дефисом (как при обычном переносе)
    String leftFor(int cut) =>
        (cut < s.length && _isLetterAt(s, cut - 1) && _isLetterAt(s, cut)) ? '${s.substring(0, cut)}-' : s.substring(0, cut);

    int lo = 1, hi = s.length, best = 0;
    while (lo <= hi) {
      final mid = (lo + hi) >> 1;
      final test = _like(e, leftFor(mid));
      caches.performLayoutWithCache(test, maxWidth, dir);

      if (test.width <= maxWidth) {
        best = mid;
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }

    if (best == 0) return null;

    // Мягкие переносы внутри остатка слова вставил переносчик — в исходном тексте их нет
    final leftSrc = s.substring(0, best);
    final rightSrc = s.substring(best);
    return (
    _like(e, leftFor(best), sourceLength: leftSrc.length - _shyCount(leftSrc)),
    _like(e, rightSrc, sourceLength: rightSrc.length - _shyCount(rightSrc)),
    );
  }

  /// Новый элемент с другим текстом, но тем же типом: куски слова на ссылке остаются ссылкой.
  static TextInlineElement _like(TextInlineElement src, String text, {int? sourceLength}) {
    if (src is ClickInlineElement) {
      return ClickInlineElement(text: text, style: src.style, attrs: src.attrs, sourceLength: sourceLength);
    }
    return TextInlineElement(text: text, style: src.style, sourceLength: sourceLength);
  }

  static final RegExp _letter = RegExp(r'\p{L}', unicode: true);

  static bool _isLetterAt(String s, int i) => i >= 0 && i < s.length && _letter.hasMatch(s[i]);

  static int _shyCount(String s) {
    var n = 0;
    for (var i = 0; i < s.length; i++) {
      if (s.codeUnitAt(i) == 0x00AD) n++;
    }
    return n;
  }
}
