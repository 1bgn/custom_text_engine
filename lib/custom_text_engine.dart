library custom_text_engine;

// Публичные классы (то, что хочешь поддерживать как API)
export 'src/advanced_layout_engine.dart' show AdvancedLayoutEngine;

// Если хочешь отдавать пользователю модели/виджет демо — экспортируй явно:
export 'src/model/paragraph_block.dart' show ParagraphBlock;
export 'src/model/inline_element.dart' show InlineElement;
export 'src/model/text_inline_element.dart' show TextInlineElement;
export 'src/model/line_layout.dart' show LineLayout;
export 'src/widget/advanced_text.dart' show AdvancedText;
export 'src/model/custom_text_layout.dart' show CustomTextLayout;

// Демо-виджет можно оставить public или вынести в отдельный пакет example.
// export 'src/widget/advanced_text.dart' show AdvancedText;
