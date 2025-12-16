import 'package:custom_text_engine/src/layout_engine/click_inline_element.dart';


import '../model/inline_element.dart';
import '../model/line_break_inline_element.dart';
import '../model/text_inline_element.dart';

class InlineTokenizer {
  static final RegExp _tokenRe = RegExp(r'\S+|\s+');

  const InlineTokenizer();

  bool isAllSpaceOrTab(String s) {
    for (int i = 0; i < s.length; i++) {
      final c = s.codeUnitAt(i);
      if (c != 0x20 && c != 0x09) return false;
    }
    return s.isNotEmpty;
  }

  int countAsciiSpaces(String s) {
    int cnt = 0;
    for (int i = 0; i < s.length; i++) {
      if (s.codeUnitAt(i) == 0x20) cnt++;
    }
    return cnt;
  }

  void reverseInPlace<T>(List<T> list) {
    int i = 0, j = list.length - 1;
    while (i < j) {
      final tmp = list[i];
      list[i] = list[j];
      list[j] = tmp;
      i++;
      j--;
    }
  }

  /// Разбивает TextInlineElement на токены "слово/пробелы", а '\n' превращает в LineBreakInlineElement.
  List<InlineElement> splitTokens(List<InlineElement> elements) {
    final out = <InlineElement>[];

    for (final e in elements) {
      if (e is! TextInlineElement) {
        out.add(e);
        continue;
      }

      final lines = e.text.split('\n');
      for (int i = 0; i < lines.length; i++) {
        final chunk = lines[i];
        if (chunk.isNotEmpty) {
          final matches = _tokenRe.allMatches(chunk);

          String? bufferedWord;
          for (final m in matches) {
            final token = m.group(0)!;
            final isSpace = token.trim().isEmpty;

            if (isSpace) {
              if (bufferedWord != null) {
                out.add(_cloneTextLike(e, bufferedWord + token));
                bufferedWord = null;
              } else {
                out.add(_cloneTextLike(e, token));
              }
            } else {
              if (bufferedWord != null) {
                out.add(_cloneTextLike(e, bufferedWord));
              }
              bufferedWord = token;
            }
          }

          if (bufferedWord != null) {
            out.add(_cloneTextLike(e, bufferedWord));
            bufferedWord = null;
          }
        }

        if (i != lines.length - 1) {
          out.add(LineBreakInlineElement());
        }
      }
    }

    return out;
  }

  int countTextLength(List<InlineElement> elements) {
    int total = 0;
    for (final elem in elements) {
      if (elem is TextInlineElement) {
        total += elem.text.length;
      }
    }
    return total;
  }

  InlineElement _cloneTextLike(TextInlineElement src, String text) {
    if (src is ClickInlineElement) {
      return ClickInlineElement(text: text, style: src.style, attrs: src.attrs);
    }
    return TextInlineElement(text: text, style: src.style);
  }
}
