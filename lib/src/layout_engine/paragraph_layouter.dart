import 'dart:math' as math;
import 'dart:ui' as ui;

import '../model/indent_inline_element.dart';
import '../model/inline_element.dart';
import '../model/line_break_inline_element.dart';
import '../model/line_layout.dart';
import '../model/paragraph_block.dart';
import '../model/text_inline_element.dart';
import 'click_inline_element.dart';
import 'hyphenation_service.dart';
import 'inline_tokenizer.dart';
import 'layout_caches.dart';
import 'line_paragraph_builder.dart';

typedef BaseLineHeightComputer = double Function(ParagraphBlock pb);

class ParagraphLayouter {
  final double globalMaxWidth;
  final ui.TextAlign globalTextAlign;

  final InlineTokenizer tokenizer;
  final LayoutCaches caches;
  final HyphenationService hyphenation;
  final LineParagraphBuilder paragraphBuilder;
  final bool allowSoftHyphens;
  final BaseLineHeightComputer computeBaseLineHeight;

  const ParagraphLayouter({
    required this.globalMaxWidth,
    required this.globalTextAlign,
    required this.tokenizer,
    required this.caches,
    required this.hyphenation,
    required this.paragraphBuilder,
    required this.allowSoftHyphens,
    required this.computeBaseLineHeight,
  });

  List<LineLayout> layoutSingleParagraph(
      ParagraphBlock paragraph, {
        required int startOffset,
      })
  {
    final double padL = paragraph.paddingLeft is num
        ? paragraph.paddingLeft as double
        : (paragraph.paddingLeft ?? 0.0);
    final double padR = paragraph.paddingRight is num
        ? paragraph.paddingRight as double
        : (paragraph.paddingRight ?? 0.0);

    final splitted = tokenizer.splitTokens(paragraph.inlineElements);
    final result = <LineLayout>[];

    final double baseWidth = paragraph.maxWidth != null
        ? paragraph.maxWidth! * globalMaxWidth
        : globalMaxWidth;
    final double effectiveWidth = math.max(0.0, baseWidth - padL - padR);

    var currentLine = LineLayout();
    double currentX = 0.0;
    double maxAscent = 0.0;
    double maxDescent = 0.0;
    bool isFirstLine = true;
    int runningOffset = startOffset;
    int currentSpacesCount = 0;

    final ui.TextAlign paraAlign = paragraph.textAlign ?? globalTextAlign;
    final ui.TextDirection textDir = paragraph.textDirection;
    final ui.TextAlign? containerAlign = paragraph.containerAlignment;

    final double baseLineHeight = computeBaseLineHeight(paragraph);

    void addElementToLine(InlineElement e) {
      if (currentLine.elements.isEmpty) {
        currentLine.startTextOffset = runningOffset;
      }
      currentLine.elements.add(e);
      currentX += e.width;
      maxAscent = math.max(maxAscent, e.baseline);
      maxDescent = math.max(maxDescent, e.height - e.baseline);

      if (e is TextInlineElement) {
        currentSpacesCount += tokenizer.countAsciiSpaces(e.text);
        runningOffset += e.text.length;
      }
    }

    void applyIndentIfNeeded() {
      if (isFirstLine &&
          textDir != ui.TextDirection.rtl &&
          paragraph.enableRedLine &&
          paragraph.firstLineIndent > 0) {
        final indentElem =
        IndentInlineElement(indentWidth: paragraph.firstLineIndent);
        caches.performLayoutWithCache(indentElem, paragraph.firstLineIndent, textDir);

        if (currentLine.elements.isEmpty) {
          currentLine.startTextOffset = runningOffset;
        }
        currentLine.elements.add(indentElem);
        currentX += paragraph.firstLineIndent;
      }
    }

    void commitLine({bool hardBreak = false}) {
      // Для пустой строки (например, когда LineBreak идёт на старте)
      if (currentLine.elements.isEmpty) {
        currentLine.startTextOffset = runningOffset;
      }

      InlineElement _cloneTextPreserveType(TextInlineElement src, String text) {
        if (src is ClickInlineElement) {
          return ClickInlineElement(text: text, style: src.style, attrs: src.attrs);
        }

        return TextInlineElement(text: text, style: src.style);
      }

      bool _isSpaceOrTab(int cu) => cu == 0x20 /*space*/ || cu == 0x09 /*tab*/;

      // --- 1) Срезаем trailing whitespace ВНУТРИ последнего TextInlineElement ---
      while (currentLine.elements.isNotEmpty) {
        final last = currentLine.elements.last;
        if (last is! TextInlineElement) break;

        final t = last.text;
        if (t.isEmpty) break;

        int cut = t.length;
        while (cut > 0 && _isSpaceOrTab(t.codeUnitAt(cut - 1))) {
          cut--;
        }

        // хвоста нет
        if (cut == t.length) break;

        final removedLen = t.length - cut;

        // откатываем global offset за отрезанные символы
        runningOffset -= removedLen;

        // убираем исходный элемент
        currentLine.elements.removeLast();

        final trimmedText = t.substring(0, cut);
        if (trimmedText.isNotEmpty) {
          final newEl = _cloneTextPreserveType(last, trimmedText);
          caches.performLayoutWithCache(newEl, effectiveWidth, textDir);
          currentLine.elements.add(newEl);
        }
        // если trimmedText пустой — элемент исчез полностью
      }

      // --- 2) Удаляем trailing элементы, которые целиком whitespace ---
      while (currentLine.elements.isNotEmpty) {
        final last = currentLine.elements.last;
        if (last is TextInlineElement && tokenizer.isAllSpaceOrTab(last.text)) {
          runningOffset -= last.text.length;
          currentLine.elements.removeLast();
          continue;
        }
        break;
      }

      // --- 3) Пересчёт метрик строки с нуля ---
      double widthSum = 0.0;
      double ascentMax = 0.0;
      double descentMax = 0.0;
      int spacesSum = 0;

      for (final el in currentLine.elements) {
        widthSum += el.width;
        ascentMax = math.max(ascentMax, el.baseline);
        descentMax = math.max(descentMax, el.height - el.baseline);

        if (el is TextInlineElement) {
          spacesSum += tokenizer.countAsciiSpaces(el.text);
        }
      }

      currentLine.width = widthSum;
      currentLine.maxAscent = ascentMax;
      currentLine.maxDescent = descentMax;

      if (ascentMax == 0.0 && descentMax == 0.0) {
        currentLine.height = baseLineHeight;
      } else {
        currentLine.height = ascentMax + descentMax;
      }

      currentLine.textAlign = paraAlign;
      currentLine.textDirection = textDir;

      if (containerAlign != null) {
        switch (containerAlign) {
          case ui.TextAlign.right:
            currentLine.containerOffset = (globalMaxWidth - baseWidth) + padL;
            break;
          case ui.TextAlign.center:
            currentLine.containerOffset = ((globalMaxWidth - baseWidth) / 2) + padL;
            break;
          default:
            currentLine.containerOffset = padL;
            break;
        }
      } else {
        currentLine.containerOffset = padL;
      }

      currentLine.containerOffsetFactor = effectiveWidth / globalMaxWidth;
      currentLine.endsWithHardBreak = hardBreak;
      currentLine.spacesCount = spacesSum;

      result.add(currentLine);

      // --- 4) reset под следующую строку ---
      currentLine = LineLayout();
      currentX = 0.0;
      maxAscent = 0.0;
      maxDescent = 0.0;
      currentSpacesCount = 0;
      isFirstLine = false;
    }



    applyIndentIfNeeded();

    for (final elem in splitted) {
      if (elem is LineBreakInlineElement) {
        commitLine(hardBreak: true);
        applyIndentIfNeeded();
        continue;
      }

      final double availableWidth = math.max(0.0, effectiveWidth - currentX);
      caches.performLayoutWithCache(elem, availableWidth, textDir);

      final bool overflow = currentX + elem.width > effectiveWidth;
      if (overflow) {
        if (elem is TextInlineElement) {
          final hyphSplit = allowSoftHyphens
              ? hyphenation.trySplitBySoftHyphen(elem, availableWidth, textDir)
              : null;

          if (hyphSplit != null) {
            final left = hyphSplit.$1;
            final right = hyphSplit.$2;

            caches.performLayoutWithCache(left, availableWidth, textDir);
            addElementToLine(left);
            commitLine();

            caches.performLayoutWithCache(right, effectiveWidth, textDir);
            addElementToLine(right);
            continue;
          }

          if (currentLine.elements.isEmpty) {
            final forceSplit = hyphenation.forceSplitByWidth(elem, effectiveWidth, textDir);
            if (forceSplit != null) {
              final left = forceSplit.$1;
              final right = forceSplit.$2;

              caches.performLayoutWithCache(left, effectiveWidth, textDir);
              addElementToLine(left);
              commitLine();

              caches.performLayoutWithCache(right, effectiveWidth, textDir);
              addElementToLine(right);
              continue;
            }
          }
        }

        commitLine();
        caches.performLayoutWithCache(elem, effectiveWidth, textDir);
        addElementToLine(elem);
      } else {
        addElementToLine(elem);
      }
    }

    if (currentLine.elements.isNotEmpty) {
      commitLine();
    }

    if (textDir == ui.TextDirection.rtl) {
      for (final line in result) {
        tokenizer.reverseInPlace(line.elements);
      }
    }

    if (result.isNotEmpty) {
      result.last.isSectionEnd = true;
    }

    for (int i = 0; i < result.length; i++) {
      final line = result[i];
      final bool isLastLine = (i == result.length - 1);
      final bool paraIsJustify = (paraAlign == ui.TextAlign.justify);
      final bool allowJustify = paraIsJustify && !isLastLine && !line.endsWithHardBreak;

      line.paragraph = paragraphBuilder.buildParagraphForLine(
        line: line,
        pb: paragraph,
        effectiveWidth: effectiveWidth,
        allowJustify: allowJustify,
      );
    }

    return result;
  }
}
