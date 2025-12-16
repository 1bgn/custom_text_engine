import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:custom_text_engine/src/advanced_layout_engine.dart';
import 'package:custom_text_engine/src/model/custom_text_layout.dart';

import '../model/line_layout.dart';
import '../model/paragraph_block.dart';

class AdvancedText extends StatefulWidget {
  final List<ParagraphBlock> paragraphs;
  final bool debugPaint;
  final Color? debugBackground;

  final ui.TextAlign globalTextAlign;

  /// Хук “на будущее” (например, под ссылки/интерактивные элементы).
  final void Function(Offset localPosition)? onTap;

  const AdvancedText({
    super.key,
    required this.paragraphs,
    this.debugPaint = false,
    this.debugBackground,
    this.globalTextAlign = ui.TextAlign.left,
    this.onTap,
  });

  @override
  State<AdvancedText> createState() => _AdvancedTextState();
}

class _AdvancedTextState extends State<AdvancedText> {
  CustomTextLayout? _layout;
  double _width = 0;

  void _rebuildLayoutIfNeeded(double width) {
    if (_layout != null && _width == width) return;
    _width = width;

    final engine = AdvancedLayoutEngine(
      paragraphs: widget.paragraphs,
      globalMaxWidth: width,
      globalTextAlign: widget.globalTextAlign,
    );

    _layout = engine.layoutAllParagraphs();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 0.0;
        if (width <= 0) return const SizedBox.shrink();

        _rebuildLayoutIfNeeded(width);
        final layout = _layout!;

        Widget painted = CustomPaint(
          size: Size(width, layout.totalHeight),
          painter: _AdvancedTextPainter(
            layout: layout,
            debugPaint: widget.debugPaint,
            debugBackground: widget.debugBackground,
          ),
        );

        if (widget.onTap != null) {
          painted = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) => widget.onTap!(d.localPosition),
            child: painted,
          );
        }

        return painted;
      },
    );
  }
}

class _AdvancedTextPainter extends CustomPainter {
  final CustomTextLayout layout;
  final bool debugPaint;
  final Color? debugBackground;

  const _AdvancedTextPainter({
    required this.layout,
    required this.debugPaint,
    required this.debugBackground,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (debugBackground != null) {
      canvas.drawRect(Offset.zero & size, Paint()..color = debugBackground!);
    }

    double y = 0.0;

    for (final LineLayout line in layout.lines) {
      final double lineH = line.height;
      final double dx = line.containerOffset;

      if (debugPaint) {
        canvas.drawRect(
          Rect.fromLTWH(0, y, size.width, lineH),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = const Color(0x2200FF00),
        );
      }

      final ui.Paragraph? para = line.paragraph;
      if (para != null) {
        canvas.drawParagraph(para, Offset(dx, y));
      }

      y += lineH;
    }
  }

  @override
  bool shouldRepaint(covariant _AdvancedTextPainter oldDelegate) {
    return oldDelegate.layout != layout ||
        oldDelegate.debugPaint != debugPaint ||
        oldDelegate.debugBackground != debugBackground;
  }
}
