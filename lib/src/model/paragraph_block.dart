import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'inline_element.dart';

part 'paragraph_block.freezed.dart';

@freezed
abstract class ParagraphBlock with _$ParagraphBlock {
  const factory ParagraphBlock({
    required final List<InlineElement> inlineElements,
    final TextAlign? textAlign,
    @Default(TextDirection.ltr) final TextDirection textDirection,
    @Default(0.0)final double firstLineIndent,
    @Default(0.0) final double paragraphSpacing,
    @Default(1) final int minimumLines,
    final double? maxWidth,
    @Default(false) final bool isSectionEnd,
    @Default(false) final bool breakable,
    @Default(true) final bool enableRedLine,
    final TextAlign? containerAlignment,
    @Default(0.0) final double paddingLeft,
    @Default(0.0) final double paddingRight,
    @Default(0.0) final double paddingTop,
    @Default(0.0) final double paddingBottom,
  }) = _ParagraphBlock;
}
