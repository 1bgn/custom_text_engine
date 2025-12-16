import 'dart:ui' as ui;

abstract class InlineElement {
  double width = 0.0;
  double height = 0.0;
  double baseline = 0.0;

  /// Прямоугольники (для выделения, интерактивности).
  List<ui.Rect> selectionRects = const [];

  /// Вычисляет размеры элемента при заданной максимальной ширине.
  void performLayout(double maxWidth);

  /// Рисует элемент на [canvas] по указанным координатам.
  void paint(ui.Canvas canvas, ui.Offset offset);

  /// Возвращает зоны интерактивности (например, для ссылок).
  List<ui.Rect> getInteractiveRects(ui.Offset offset) => const [];
}

abstract class HasSourceTag {
  int get sourceNodeId;
  int get startOffset;
  int get endOffset;
}
