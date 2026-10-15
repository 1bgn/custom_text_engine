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

  /// true (по умолчанию) — прежнее поведение: у каждого текстового элемента остаётся
  /// ui.Paragraph и selectionRects (нужны для выделения/интерактивности).
  /// false — обычный текст измеряется «только числами»: параграф создаётся на время
  /// измерения и сразу освобождается, а размеры берутся из общего [textMetrics],
  /// если токен уже измерялся. Элементы [ClickInlineElement] (сноски) всегда идут прежним путём.
  final bool retainTextParagraphs;

  /// Кеш размеров для режима `retainTextParagraphs: false` (можно делить между движками).
  final TextMetricsCache textMetrics;

  LayoutCaches({
    required this.intrinsicMeasureWidth,
    int textCacheSize = 2000,
    int metricsCacheSize = 10000,
    this.retainTextParagraphs = true,
    TextMetricsCache? textMetrics,
  })  : textMetrics = textMetrics ?? TextMetricsCache(),
        textCache =
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

  // toString() у TextStyle длинный и вычисляется на каждый токен, а стиль у токенов одного
  // узла — один и тот же объект. Хеш считаем один раз на объект стиля.
  static final Expando<int> _styleHashes = Expando<int>('styleHash');

  int effectiveStyleHash(dynamic style) {
    if (style == null) return Object.hash(0, null);
    final cached = style is Object ? _styleHashes[style] : null;
    if (cached != null) return cached;
    final hash = Object.hash(style.hashCode, style.toString());
    if (style is Object) _styleHashes[style] = hash;
    return hash;
  }

  void performLayoutWithCache(
      InlineElement e,
      double availableWidth,
      ui.TextDirection dir,
      ) {
    if (e is TextInlineElement) {
      if (!retainTextParagraphs && e is! ClickInlineElement) {
        _measureTextMetricsOnly(e, dir);
        return;
      }

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

      final paragraph = _buildIntrinsicParagraph(e);

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

    // Нетекстовые элементы (картинки, sup/sub и т. п.): размер зависит от самого элемента, а ключ
    // кеша был «тип + ширина» — разные картинки получали размеры друг друга. Кешируем только отступы.
    if (e is! IndentInlineElement) {
      e.performLayout(availableWidth);
      return;
    }

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
  /// Параграф одного токена в «бесконечной» ширине (интринсик-измерение).
  ui.Paragraph _buildIntrinsicParagraph(TextInlineElement e) {
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

    return builder.build()
      ..layout(ui.ParagraphConstraints(width: intrinsicMeasureWidth));
  }

  /// Размеры токена только числами: при попадании в общий кеш параграф не создаётся,
  /// при промахе — создаётся, измеряется и сразу освобождается (элемент его не удерживает).
  void _measureTextMetricsOnly(TextInlineElement e, ui.TextDirection dir) {
    final key = makeKey(e, dir, 0.0);

    final hit = textMetrics[key];
    if (hit != null) {
      e
        ..width = hit.width
        ..height = hit.height
        ..baseline = hit.baseline;
      return;
    }

    final paragraph = _buildIntrinsicParagraph(e);
    final w = paragraph.maxIntrinsicWidth;
    final h = paragraph.height;
    final lines = paragraph.computeLineMetrics();
    final base = lines.isNotEmpty ? lines.first.ascent : h;
    paragraph.dispose();

    textMetrics[key] = TextMetrics(w, h, base);
    e
      ..width = w
      ..height = h
      ..baseline = base;
  }
}
