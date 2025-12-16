import 'dart:ui' as ui;
import 'package:flutter/painting.dart';

import 'inline_element.dart'; // вместо material.dart


class TextInlineElement extends InlineElement implements HasSourceTag {
  final String text;
  final TextStyle style;

  @override
  int sourceNodeId = 0;
  @override
  int startOffset = 0;
  @override
  int endOffset = 0;

  TextInlineElement({required this.text, required this.style});

  ui.Paragraph? _paragraphCache;
  ui.Paragraph? _paintParagraph;

  List<ui.Rect> _selectionRects = const [];

  ui.Paragraph get paragraph => _paragraphCache!;
  ui.Paragraph get effectiveParagraph => _paintParagraph ?? _paragraphCache!;

  @override
  List<ui.Rect> getInteractiveRects(ui.Offset offset) {
    if (_selectionRects.isEmpty) return const [];
    return _selectionRects.map((r) => r.shift(offset)).toList(growable: false);
  }

  @override
  String toString() => "TextInlineElement{text: $text}";

  @override
  void paint(ui.Canvas canvas, ui.Offset offset) {
    final p = _paintParagraph ?? _paragraphCache;
    if (p != null) canvas.drawParagraph(p, offset);
  }

  void adoptPaintParagraph(ui.Paragraph paragraph, List<ui.Rect> rects) {
    _paintParagraph = paragraph;
    // rects можно хранить отдельно, но достаточно и _selectionRects
    // если они используются для интерактивности/selection.
  }

  @override
  void performLayout(double maxWidth) {
    // если уже «гидрировали» извне — просто вычислим метрики из готового параграфа
    if (_paragraphCache != null) {
      final p = _paragraphCache!;
      width = (p.maxIntrinsicWidth <= maxWidth) ? p.maxIntrinsicWidth : maxWidth;
      height = p.height;
      final metrics = p.computeLineMetrics();
      baseline = metrics.isNotEmpty ? metrics.first.ascent : height;

      // selectionRects синхронизируем
      selectionRects = _selectionRects;
      return;
    }

    final builder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: style.fontFamily,
        fontSize: style.fontSize,
        fontWeight: style.fontWeight,
        fontStyle: style.fontStyle,
      ),
    )
      ..pushStyle(ui.TextStyle(
        color: style.color,
        fontSize: style.fontSize,
        fontFamily: style.fontFamily,
        fontWeight: style.fontWeight,
        fontStyle: style.fontStyle,
        letterSpacing: style.letterSpacing,
        wordSpacing: style.wordSpacing,
        height: style.height,
      ))
      ..addText(text);

    final p = builder.build();
    p.layout(ui.ParagraphConstraints(width: maxWidth));
    _paragraphCache = p;

    width = (p.maxIntrinsicWidth <= maxWidth) ? p.maxIntrinsicWidth : maxWidth;
    height = p.height;

    final metrics = p.computeLineMetrics();
    baseline = metrics.isNotEmpty ? metrics.first.ascent : height;

    _selectionRects = const [];
    if (text.isNotEmpty) {
      final boxes = p.getBoxesForRange(0, text.length);
      _selectionRects = boxes
          .map((b) => ui.Rect.fromLTWH(b.left, b.top, b.right - b.left, b.bottom - b.top))
          .toList(growable: false);
    }

    selectionRects = _selectionRects;
  }

  void adoptParagraph(ui.Paragraph paragraph, List<ui.Rect> rects) {
    _paragraphCache = paragraph;
    _selectionRects = rects;
    selectionRects = rects;
  }

  void clearPaintParagraph() {
    _paintParagraph = null;
  }

  List<ui.TextBox> selectionBoxes(int start, int end) {
    final p = _paragraphCache;
    if (p == null) return const [];
    final s = start.clamp(0, text.length);
    final e = end.clamp(0, text.length);
    if (e <= s) return const [];
    return p.getBoxesForRange(s, e);
  }

  int caretOffsetForX(double localX) {
    final p = _paragraphCache;
    if (p == null) return 0;
    final pos = p.getPositionForOffset(ui.Offset(localX, 0));
    var off = pos.offset;
    if (off < 0) off = 0;
    if (off > text.length) off = text.length;
    return off;
  }
}
