import 'dart:ui' as ui;


import 'package:custom_text_engine/src/layout_engine/inline_tokenizer.dart';
import 'package:custom_text_engine/src/layout_engine/paragraph_layouter.dart';
import 'package:custom_text_engine/src/model/line_layout.dart';
import 'package:custom_text_engine/src/model/paragraph_block.dart';
import 'package:custom_text_engine/src/model/text_inline_element.dart';

import 'layout_engine/hyphenator.dart';
import 'model/custom_text_layout.dart';

import 'layout_engine/hyphenation_service.dart';
import 'layout_engine/layout_caches.dart';
import 'layout_engine/line_paragraph_builder.dart';
typedef HyphenateCallback = String Function(String input);
class AdvancedLayoutEngine {
  final List<ParagraphBlock> paragraphs;
  final double globalMaxWidth;
  final ui.TextAlign globalTextAlign;
  final Hyphenator hyphenator = Hyphenator();
  final bool allowSoftHyphens;
  final HyphenateCallback? hyphenateOverride;
  static const double kIntrinsicMeasureWidth = 1e9;

  late final InlineTokenizer _tokenizer;
  late final LayoutCaches _caches;
  late final HyphenationService _hyphenation;
  late final LineParagraphBuilder _lineParagraphBuilder;
  late final ParagraphLayouter _paragraphLayouter;

  AdvancedLayoutEngine({
    required this.paragraphs,
    required this.globalMaxWidth,
    required this.globalTextAlign,
    this.allowSoftHyphens = true,
    this.hyphenateOverride,
  }) {
    _tokenizer = const InlineTokenizer();
    _caches = LayoutCaches(intrinsicMeasureWidth: kIntrinsicMeasureWidth);
    _hyphenation = HyphenationService(hyphenator: hyphenator, caches: _caches,   hyphenateOverride: hyphenateOverride,);
    _lineParagraphBuilder = LineParagraphBuilder(tokenizer: _tokenizer);
    _paragraphLayouter = ParagraphLayouter(
      globalMaxWidth: globalMaxWidth,
      globalTextAlign: globalTextAlign,
      tokenizer: _tokenizer,
      caches: _caches,
      hyphenation: _hyphenation,
      paragraphBuilder: _lineParagraphBuilder,
      allowSoftHyphens: allowSoftHyphens,
      computeBaseLineHeight: _computeBaseLineHeight,
    );
  }

  double _computeBaseLineHeight(ParagraphBlock pb) {
    // Берём первый текстовый элемент абзаца как эталон.
    TextInlineElement? firstText;
    for (final el in pb.inlineElements) {
      if (el is TextInlineElement && el.text.isNotEmpty) {
        firstText = el;
        break;
      }
    }
    if (firstText == null) return 14.0;

    final style = firstText.style;
    final double fontSize = style.fontSize ?? 14.0;
    final double heightMul = style.height ?? 1.0;
    return fontSize * heightMul;
  }

  CustomTextLayout layoutAllParagraphs() {
    final allLines = <LineLayout>[];
    final paragraphIndexOfLine = <int>[];
    double totalHeight = 0.0;
    int currentGlobalOffset = 0;

    for (int index = 0; index < paragraphs.length; index++) {
      final paragraph = paragraphs[index];

      final double padT = paragraph.paddingTop is num
          ? paragraph.paddingTop as double
          : (paragraph.paddingTop ?? 0.0);
      final double padB = paragraph.paddingBottom is num
          ? paragraph.paddingBottom as double
          : (paragraph.paddingBottom ?? 0.0);

      // Случайный перенос «направо» как был
      if (paragraph.textAlign == ui.TextAlign.right && allLines.isNotEmpty) {
        final breakLine = LineLayout();
        breakLine.startTextOffset = currentGlobalOffset;
        allLines.add(breakLine);
        paragraphIndexOfLine.add(index);
      }

      // Верхний паддинг — отдельная «пустая» линия
      if (padT > 0) {
        final padTopLine = LineLayout()
          ..width = 0
          ..height = padT
          ..textAlign = paragraph.textAlign ?? globalTextAlign
          ..textDirection = paragraph.textDirection
          ..startTextOffset = currentGlobalOffset;
        allLines.add(padTopLine);
        paragraphIndexOfLine.add(index);
        totalHeight += padT;
      }

      final lines = _paragraphLayouter.layoutSingleParagraph(
        paragraph,
        startOffset: currentGlobalOffset,
      );

      for (int i = 0; i < lines.length; i++) {
        paragraphIndexOfLine.add(index);
      }
      allLines.addAll(lines);

      // Нижний паддинг — отдельная «пустая» линия
      if (padB > 0) {
        final padBottomLine = LineLayout()
          ..width = 0
          ..height = padB
          ..textAlign = paragraph.textAlign ?? globalTextAlign
          ..textDirection = paragraph.textDirection
          ..startTextOffset = currentGlobalOffset;
        allLines.add(padBottomLine);
        paragraphIndexOfLine.add(index);
        totalHeight += padB;
      }

      // Межабзацный spacing
      if (index < paragraphs.length - 1 && paragraph.paragraphSpacing > 0) {
        final spacingLine = LineLayout()
          ..width = 0
          ..height = paragraph.paragraphSpacing
          ..textAlign = paragraph.textAlign ?? globalTextAlign
          ..textDirection = paragraph.textDirection
          ..startTextOffset = currentGlobalOffset;
        allLines.add(spacingLine);
        paragraphIndexOfLine.add(index);
      }

      // Сдвиг глобального смещения
      currentGlobalOffset += _tokenizer.countTextLength(paragraph.inlineElements);

      // Подсчёт высоты параграфа (без паддингов — они уже добавлены)
      double paragraphHeight = 0.0;
      for (int i = 0; i < lines.length; i++) {
        paragraphHeight += lines[i].height;
        if (i < lines.length - 1) {
          paragraphHeight += paragraph.paragraphSpacing;
        }
      }
      totalHeight += paragraphHeight;

      if (index < paragraphs.length - 1) {
        totalHeight += paragraph.paragraphSpacing;
      }
    }

    return CustomTextLayout(
      lines: allLines,
      totalHeight: totalHeight,
      paragraphIndexOfLine: paragraphIndexOfLine,
    );
  }
}
