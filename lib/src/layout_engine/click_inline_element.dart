import 'dart:ui';


import '../model/text_inline_element.dart';

class ClickInlineElement extends TextInlineElement{
  ClickInlineElement({required super.text, required super.style,
    this.attrs = const {},});
  final Map<String, String> attrs;
  @override
  List<Rect> getInteractiveRects(Offset offset) {
    return selectionRects.map((r) => r.shift(offset)).toList();
  }
}