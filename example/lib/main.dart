import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:custom_text_engine/src/widget/advanced_text.dart';
import 'package:custom_text_engine/custom_text_engine.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = const TextStyle(fontSize: 16, height: 1.25, color: Colors.black);
    final bold = base.copyWith(fontWeight: FontWeight.w600);
    final small = base.copyWith(fontSize: 13, color: Colors.black87);

    final paragraphs = <ParagraphBlock>[
      ParagraphBlock(
        textAlign: ui.TextAlign.justify,
        paddingLeft: 12,
        paddingRight: 12,
        paddingTop: 12,
        paragraphSpacing: 10,
        enableRedLine: true,
        firstLineIndent: 18,
        inlineElements: [
          TextInlineElement(text: 'Демонстрация движка. ', style: bold),
          TextInlineElement(
            text:
            'Тап — каретка/подсветка символа. Long press и drag — выделение диапазона в пределах строки. ',
            style: base,
          ),
          TextInlineElement(
            text:
            'Проверка переносов: сверхдлиннющееСверхдли ннющееСверхдлиннющееСловоБезПробелов и ещё раз сверхдлиннющееСлово.',
            style: base,
          ),
        ],
      ),
      ParagraphBlock(
        textAlign: ui.TextAlign.justify,
        // paddingLeft: 12,
        // paddingRight: 12,
        paragraphSpacing: 10,
        enableRedLine: true,
        firstLineIndent: 18,
        inlineElements: [
          TextInlineElement(
            text:
            'Внутри строки есть разные куски текста разного стиля, а также последовательности пробелов     и табы\t(если они у тебя встречаются). ',
            style: base,
          ),
          TextInlineElement(
            text:
            'Ещё немного текста для “книжной” плотности: когда движок правильно считает ширины, justify выглядит ровнее.',
            style: small,
          ),
        ],
      ),
      ParagraphBlock(
        textAlign: ui.TextAlign.left,
        paddingLeft: 12,
        paddingRight: 12,
        paddingBottom: 20,
        paragraphSpacing: 10,
        inlineElements: [
          TextInlineElement(
            text:
            'Последний абзац слева. Можно добавить символы: (1) кавычки «ёлочки», (2) тире — и дефисы - -, (3) EnglishWordsForHyphenationCheck.',
            style: base,
          ),
        ],
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('AdvancedText demo')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: AdvancedText(
              paragraphs: paragraphs,
              debugPaint: true,
              // debugBackground: const Color(0x11FF0000),
              globalTextAlign: ui.TextAlign.left,

              // enableSelection: true,
            ),
          ),
        ),
      ),
    );
  }
}
