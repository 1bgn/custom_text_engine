import 'package:flutter/cupertino.dart';


// line_layout.dart
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

import 'inline_element.dart';

class LineLayout {
  // Новый обязательный носитель текста
   ui.Paragraph? paragraph;

  List<InlineElement> elements = [];
  double width = 0;
  double height = 0;
  double maxAscent = 0;
  double maxDescent = 0;
  bool isSectionEnd = false;
  bool endsWithHardBreak = false;
  int spacesCount = 0;
  TextAlign textAlign = TextAlign.left;
  TextDirection textDirection = TextDirection.ltr;
  double containerOffset = 0;
  double containerOffsetFactor = 1.0;
  int startTextOffset = 0;

  /// Ширина, доступная этой строке (меньше ширины абзаца, если строку сужает плавающая картинка).
  /// null — вся ширина абзаца.
  double? availableWidth;

  /// Сдвиг строки вправо от левого края контейнера из-за плавающей слева картинки.
  double leftInset = 0;

  @override
  String toString() {
    return 'LineLayout{paragraph: $paragraph, elements: $elements, width: $width, height: $height, maxAscent: $maxAscent, maxDescent: $maxDescent, isSectionEnd: $isSectionEnd, endsWithHardBreak: $endsWithHardBreak, spacesCount: $spacesCount, textAlign: $textAlign, textDirection: $textDirection, containerOffset: $containerOffset, containerOffsetFactor: $containerOffsetFactor, startTextOffset: $startTextOffset}';
  }

  double get baseline => maxAscent;
}
