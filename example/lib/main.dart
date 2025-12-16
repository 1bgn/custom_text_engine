import 'dart:ui' as ui;
import 'package:custom_text_engine/src/model/line_break_inline_element.dart';
import 'package:flutter/material.dart';
import 'package:custom_text_engine/custom_text_engine.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const _maxContentWidth = 420.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'custom_text_engine demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final base = const TextStyle(fontSize: 16, height: 1.35, color: Colors.black);
    final bold = base.copyWith(fontWeight: FontWeight.w600);
    final small = base.copyWith(fontSize: 13, color: Colors.black87);

    return Scaffold(
      appBar: AppBar(title: const Text('custom_text_engine – demo')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: MyApp._maxContentWidth),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: [
                _Section(
                  title: 'RU: Justify + indent + padding',
                  subtitle: 'Книжная верстка: красная строка, поля, выравнивание.',
                  child: AdvancedText(
                    debugPaint: false,
                    globalTextAlign: ui.TextAlign.left,
                    paragraphs: [
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
                            'Этот абзац показывает выравнивание по ширине (justify), красную строку и паддинги. ',
                            style: base,
                          ),
                          TextInlineElement(
                            text:
                            'Проверка длинных слов: сверхдлиннющееСверхдлиннющееСловоБезПробеловИБезДефисов плюс ещё одноСверхдлиннющееСлово.',
                            style: base,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                _Section(
                  title: 'EN: Mixed styles + spacing',
                  subtitle: 'Inline стили + последовательности пробелов/табы.',
                  child: AdvancedText(
                    debugPaint: false,
                    paragraphs: [
                      ParagraphBlock(
                        textAlign: ui.TextAlign.justify,
                        paddingLeft: 12,
                        paddingRight: 12,
                        paddingTop: 12,
                        paragraphSpacing: 10,
                        enableRedLine: true,
                        firstLineIndent: 18,
                        inlineElements: [
                          TextInlineElement(text: 'Custom layout engine. ', style: bold),
                          TextInlineElement(
                            text:
                            'This paragraph contains mixed styles and demonstrates spacing. ',
                            style: base,
                          ),
                          TextInlineElement(
                            text:
                            'Multiple spaces     and tabs\tcan appear in input and should not break layout. ',
                            style: base,
                          ),
                          TextInlineElement(
                            text:
                            'Small note: proper width accounting makes justify look cleaner.',
                            style: small,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                _Section(
                  title: 'RU + EN: Left align (technical text)',
                  subtitle: 'Технический текст часто лучше выглядит слева без justify.',
                  child: AdvancedText(
                    debugPaint: false,
                    paragraphs: [
                      ParagraphBlock(
                        textAlign: ui.TextAlign.left,
                        paddingLeft: 12,
                        paddingRight: 12,
                        paddingTop: 12,
                        paragraphSpacing: 10,
                        inlineElements: [
                          TextInlineElement(
                            text:
                            'RU: Слева — удобно для кода/логов/списков. ',
                            style: base,
                          ),
                          TextInlineElement(
                            text:
                            'EN: Left aligned paragraph. Useful for technical content and predictable scanning.',
                            style: base,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                _Section(
                  title: 'EN: Hard line breaks',
                  subtitle: 'Сценарий: принудительные переносы строк (поэзия/адреса).',
                  child: AdvancedText(
                    debugPaint: false,
                    paragraphs: [
                      ParagraphBlock(
                        textAlign: ui.TextAlign.left,
                        paddingLeft: 12,
                        paddingRight: 12,
                        paddingTop: 12,
                        paragraphSpacing: 10,
                        inlineElements: [
                          TextInlineElement(text: 'Line 1: 221B Baker Street', style: base),
                          LineBreakInlineElement(),
                          TextInlineElement(text: 'Line 2: London', style: base),
                          LineBreakInlineElement(),
                          TextInlineElement(text: 'Line 3: United Kingdom', style: base),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _Section({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0x22000000)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(title, style: titleStyle),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
              child: Text(subtitle, style: subtitleStyle),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
