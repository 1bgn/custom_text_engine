import 'dart:ui' as ui;

import 'package:quiver/collection.dart' show LruMap;

class TextMetrics {
  final double width;
  final double height;
  final double baseline;
  const TextMetrics(this.width, this.height, this.baseline);
}

/// Общий кеш размеров текстовых токенов (ширина/высота/baseline по «текст + стиль»).
///
/// Размеры токена зависят только от текста и стиля, а слова в книге повторяются постоянно
/// (в типичной книге уникальных слов около 20%). Кеш хранит только числа — без ui.Paragraph —
/// поэтому его можно держать большим и делить между абзацами и главами:
/// `AdvancedLayoutEngine` создаётся на каждый абзац, и собственный кеш абзаца общих слов не видит.
class TextMetricsCache {
  final LruMap<MetricsKey, TextMetrics> _map;

  TextMetricsCache({int maximumSize = 50000})
      : _map = LruMap<MetricsKey, TextMetrics>(maximumSize: maximumSize);

  TextMetrics? operator [](MetricsKey key) => _map[key];
  void operator []=(MetricsKey key, TextMetrics value) => _map[key] = value;

  int get length => _map.length;
  void clear() => _map.clear();
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
