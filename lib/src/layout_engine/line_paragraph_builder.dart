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
        // Выключка: добавка одинакова у всех кусков строки (на слово без пробела wordSpacing не
        // влияет). Разный wordSpacing у соседних кусков одного начертания разрывал прогон текста,
        // и у курсива второй глиф слова сдвигался на предыдущий («Путь» → буквы налезали).
        // Куски с неразрывным пробелом без обычных пробелов не трогаем: они не растягиваются.
        if (canJustify && (spacesHere > 0 || !text.contains('\u00A0'))) {
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
        // Картинки и прочие нетекстовые элементы: резервируем в строке место под них, иначе текст
        // после них «налезает» (placeholder положен на базовую линию, el.baseline — расстояние
        // от верха элемента до его базовой линии; сдвиг sup/sub — это и есть el.baseline).
        builder.addPlaceholder(
          el.width,
          el.height,
          ui.PlaceholderAlignment.baseline,
          baseline: ui.TextBaseline.alphabetic,
          baselineOffset: el.baseline,
        );
      }
    }

    final para = builder.build();

    final double layoutWidth = canJustify ? effectiveWidth : math.max(1.0, line.width);
    para.layout(ui.ParagraphConstraints(width: layoutWidth));

    // Selection-rects: сохраняем в КАЖДЫЙ TextInlineElement строки, не только
    // в первый — иначе в многостилевых строках (например, обычный текст +
    // цитата/выделение в одном абзаце) rects будут отсутствовать у всех
    // прогонов кроме первого.
    int cursor = 0;

    for (int i = 0; i < line.elements.length; i++) {
      final el = line.elements[i];
      if (el is! TextInlineElement) {
        // отступ красной строки и нетекстовые элементы — плейсхолдеры: в тексте параграфа это
        // один символ (U+FFFC). Без него все диапазоны за ними (и прямоугольники ссылок)
        // сдвигались на символ влево.
        cursor += 1;
        continue;
      }

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

      el.adoptPaintParagraph(para, rects);
    }

    return para;
  }
}
