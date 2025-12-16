import 'dart:ui' as ui;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_layout_entry.freezed.dart';

@freezed
abstract class TextLayoutEntry with _$TextLayoutEntry {
  const factory TextLayoutEntry({
    required ui.Paragraph paragraph,
    required double width,
    required double height,
    required double baseline,
    required List<ui.Rect> rects,
  }) = _TextLayoutEntry;
}
