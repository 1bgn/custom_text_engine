// elements/layout_blocks/line_break_inline_element.dart
import 'dart:ui';
import 'inline_element.dart';

class LineBreakInlineElement extends InlineElement {
  @override
  double width = 0;
  @override
  double height = 0;
  @override
  double baseline = 0;

  @override
  void performLayout(double maxWidth) { /* no-op */ }

  @override
  void paint(Canvas canvas, Offset offset) { /* no-op */ }
}
