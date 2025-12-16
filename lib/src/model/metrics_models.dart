import 'dart:ui' as ui;

class TextMetrics {
  final double width;
  final double height;
  final double baseline;
  const TextMetrics(this.width, this.height, this.baseline);
}

class MetricsKey {
  final String kind;            // 'text', 'footnote', 'indent', ...
  final String? text;           // текст токена
  final int styleHash;          // хэш стиля
  final ui.TextDirection? dir;  // направление письма
  final double param;           // constraint или параметр элемента

  const MetricsKey({
    required this.kind,
    required this.text,
    required this.styleHash,
    required this.dir,
    required this.param,
  });

  @override
  bool operator ==(Object o) {
    return o is MetricsKey &&
        kind == o.kind &&
        text == o.text &&
        styleHash == o.styleHash &&
        dir == o.dir &&
        param == o.param;
  }

  @override
  int get hashCode => Object.hash(kind, text, styleHash, dir, param);
}
