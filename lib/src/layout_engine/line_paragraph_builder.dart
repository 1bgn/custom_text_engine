import 'dart:math' as math;
import 'dart:ui' as ui;

import '../model/indent_inline_element.dart';
import '../model/line_layout.dart';
import '../model/paragraph_block.dart';
import '../model/text_inline_element.dart';
import 'inline_tokenizer.dart';

class LineParagraphBuilder {
  final InlineTokenizer tokenizer;

  const LineParagraphBuilder({required this.tokenizer});

  ui.Paragraph buildParagraphForLine({
    required LineLayout line,
    required ParagraphBlock pb,
    required double effectiveWidth, // baseWidth - padL - padR
    required bool allowJustify,
  }) {
    final int totalSpaces = line.spacesCount;
    final double rawExtra = effectiveWidth - line.width;
    final double extra = rawExtra > 1e-3 ? rawExtra : 0.0;

    final bool canJustify = allowJustify && totalSpaces > 0 && extra > 0.0;
    final double addPerSpace = canJustify ? (extra / totalSpaces) : 0.0;

    final ui.ParagraphBuilder builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textDirection: line.textDirection,
      textAlign: canJustify ? ui.TextAlign.left : line.textAlign,
    ));

    for (final el in line.elements) {
      if (el is TextInlineElement) {
        final text = el.text;
        final int spacesHere = tokenizer.countAsciiSpaces(text);

        double ws = el.style.wordSpacing ?? 0.0;
        if (canJustify && spacesHere > 0) {
          ws += addPerSpace;
        }

        builder.pushStyle(ui.TextStyle(
          color: el.style.color,
          fontFamily: el.style.fontFamily,
          fontSize: el.style.fontSize,
          fontWeight: el.style.fontWeight,
          fontStyle: el.style.fontStyle,
          letterSpacing: el.style.letterSpacing,
          wordSpacing: ws,
          height: el.style.height,
        ));
        builder.addText(text);
        builder.pop();
      } else if (el is IndentInlineElement) {
        builder.addPlaceholder(
          el.indentWidth,
          line.height > 0 ? line.height : (line.maxAscent + line.maxDescent),
          ui.PlaceholderAlignment.baseline,
          baseline: ui.TextBaseline.alphabetic,
          baselineOffset: line.maxAscent,
        );
      } else {
        // TODO: addPlaceholder для других inline (если нужно).
      }
    }

    final para = builder.build();

    final double layoutWidth = canJustify ? effectiveWidth : math.max(1.0, line.width);
    para.layout(ui.ParagraphConstraints(width: layoutWidth));

    // Selection-rects: сохраняем в первый TextInlineElement (как было).
    int cursor = 0;
    int firstTextIndex = -1;

    for (int i = 0; i < line.elements.length; i++) {
      final el = line.elements[i];
      if (el is! TextInlineElement) continue;

      final start = cursor;
      final end = cursor += el.text.length;

      final boxes = el.text.isEmpty
          ? const <ui.TextBox>[]
          : para.getBoxesForRange(start.clamp(0, end), end);

      final rects = boxes
          .map((b) => ui.Rect.fromLTWH(
        b.left,
        b.top,
        b.right - b.left,
        b.bottom - b.top,
      ))
          .toList(growable: false);

      if (firstTextIndex < 0) {
        firstTextIndex = i;
        el.adoptPaintParagraph(para, rects);
      }
    }

    return para;
  }
}
