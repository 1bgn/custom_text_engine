import 'package:freezed_annotation/freezed_annotation.dart';

import 'line_layout.dart';

part 'custom_text_layout.freezed.dart';
@freezed
abstract class CustomTextLayout with _$CustomTextLayout{
  const factory CustomTextLayout({
    required final List<LineLayout> lines,
    required final double totalHeight,
    required final List<int> paragraphIndexOfLine
}) = _CustomTextLayout;
}