import 'dart:ui' as ui;

import 'package:quiver/collection.dart' show LruMap;
import 'package:custom_text_engine/src/layout_engine/click_inline_element.dart';

import '../model/indent_inline_element.dart';
import '../model/inline_element.dart';
import '../model/text_inline_element.dart';
import 'text_layout_entry.dart';
import '../model/metrics_models.dart';

class LayoutCaches {
  final double intrinsicMeasureWidth;

  /// Text token -> Paragraph + metrics + rects.
  final LruMap<MetricsKey, TextLayoutEntry> textCache;

  /// Other inline elements -> metrics only.
  final LruMap<MetricsKey, TextMetrics> metricsCache;

  LayoutCaches({
    required this.intrinsicMeasureWidth,
    int textCacheSize = 5,
    int metricsCacheSize = 10000,
  })  : textCache =
  LruMap<MetricsKey, TextLayoutEntry>(maximumSize: textCacheSize),
        metricsCache =
        LruMap<MetricsKey, TextMetrics>(maximumSize: metricsCacheSize);

  MetricsKey makeKey(InlineElement e, ui.TextDirection dir, double availableWidth) {
    if (e is TextInlineElement) {
      final kind = (e is ClickInlineElement) ? 'footnote' : 'text';
      return MetricsKey(
        kind: kind,
        text: e.text,
        styleHash: effectiveStyleHash(e.style),
        dir: dir,
        param: 0.0, // текст — интринсик, не зависит от constraint
      );
    }

    if (e is IndentInlineElement) {
      return MetricsKey(
        kind: 'indent',
        text: null,
        styleHash: 0,
        dir: dir,
        param: e.indentWidth,
      );
    }

    return MetricsKey(
      kind: e.runtimeType.toString(),
      text: null,
      styleHash: 0,
      dir: dir,
      param: availableWidth,
    );
  }

  int effectiveStyleHash(dynamic style) {
    final base = style?.hashCode ?? 0;
    return Object.hash(base, style?.toString());
  }

  void performLayoutWithCache(
      InlineElement e,
      double availableWidth,
      ui.TextDirection dir,
      ) {
    if (e is TextInlineElement) {
      final key = makeKey(e, dir, 0.0);

      final hit = textCache[key];
      if (hit != null) {
        e
          ..width = hit.width
          ..height = hit.height
          ..baseline = hit.baseline;
        e.adoptParagraph(hit.paragraph, hit.rects);
        return;
      }

      final builder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontFamily: e.style.fontFamily,
          fontSize: e.style.fontSize,
          fontWeight: e.style.fontWeight,
          fontStyle: e.style.fontStyle,
        ),
      )
        ..pushStyle(ui.TextStyle(
          color: e.style.color,
          fontSize: e.style.fontSize,
          fontFamily: e.style.fontFamily,
          fontWeight: e.style.fontWeight,
          fontStyle: e.style.fontStyle,
          letterSpacing: e.style.letterSpacing,
          wordSpacing: e.style.wordSpacing,
          height: e.style.height,
        ))
        ..addText(e.text);

      final paragraph = builder.build()
        ..layout(ui.ParagraphConstraints(width: intrinsicMeasureWidth));

      final w = paragraph.maxIntrinsicWidth;
      final h = paragraph.height;

      final lines = paragraph.computeLineMetrics();
      final base = lines.isNotEmpty ? lines.first.ascent : h;

      final rects = <ui.Rect>[];
      if (e.text.isNotEmpty) {
        final boxes = paragraph.getBoxesForRange(0, e.text.length);
        for (final b in boxes) {
          rects.add(ui.Rect.fromLTWH(
            b.left,
            b.top,
            b.right - b.left,
            b.bottom - b.top,
          ));
        }
      }

      final entry = TextLayoutEntry(
        paragraph: paragraph,
        width: w,
        height: h,
        baseline: base,
        rects: rects,
      );
      textCache[key] = entry;

      e
        ..width = w
        ..height = h
        ..baseline = base;
      e.adoptParagraph(paragraph, rects);
      return;
    }

    // Non-text inline elements: cache metrics by constraints.
    final key = makeKey(e, dir, availableWidth);

    final hit = metricsCache[key];
    if (hit != null) {
      e
        ..width = hit.width
        ..height = hit.height
        ..baseline = hit.baseline;
      return;
    }

    e.performLayout(availableWidth);
    metricsCache[key] = TextMetrics(e.width, e.height, e.baseline);
  }
}
