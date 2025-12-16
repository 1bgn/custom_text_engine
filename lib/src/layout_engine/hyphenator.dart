class Hyphenator {
  final String x = "йьъ";
  final String g = "аеёиоуыэюяaeiouy";
  final String s = "бвгджзклмнпрстфхцчшщbcdfghjklmnpqrstvwxz";

  final List<HyphenPair> rules = [];

  Hyphenator() {
    // Пример ваших правил:
    rules.add(HyphenPair("xgg", 1));
    rules.add(HyphenPair("xgs", 1));
    rules.add(HyphenPair("xsg", 1));
    rules.add(HyphenPair("xss", 1));
    rules.add(HyphenPair("gssssg", 3));
    rules.add(HyphenPair("gsssg", 3));
    rules.add(HyphenPair("gsssg", 2));
    rules.add(HyphenPair("sgsg", 2));
    rules.add(HyphenPair("gssg", 2));
    rules.add(HyphenPair("sggg", 2));
    rules.add(HyphenPair("sggs", 2));
  }

  /// Основной метод для вставки мягких переносов (Unicode \u00AD) в текст
  /// на основании правил в [rules].
  ///
  /// Возвращает строку с вставленными \u00AD, которые Flutter
  /// интерпретирует как "дефис при переносе".
  String hyphenate(String text, {String hyphenateSymbol = "\u00AD"}) {
    // 1) Построим промежуточную строку, заменяя символы:
    //    x, g, s – как в вашем коде
    final sb = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String c = text[i];
      if (x.contains(c)) {
        sb.write("x");
      } else if (g.contains(c)) {
        sb.write("g");
      } else if (s.contains(c)) {
        sb.write("s");
      } else {
        sb.write(c);
      }
    }
    String hyphenatedText = sb.toString();

    // Допустим, splitter = "┼" – маркер, который мы временно вставляем
    const splitter = "┼";

    // 2) Применяем правила, вставляя splitter
    for (int i = 0; i < rules.length; i++) {
      final hp = rules[i];
      // Ищем все вхождения шаблона
      int index = hyphenatedText.indexOf(hp.pattern);
      while (index != -1) {
        int actualIndex = index + hp.position;
        // Вставляем splitter в промежуточную строку "hyphenatedText"
        hyphenatedText = hyphenatedText.substring(0, actualIndex)
            + splitter
            + hyphenatedText.substring(actualIndex);

        // Параллельно вставляем splitter и в исходный text
        text = text.substring(0, actualIndex)
            + splitter
            + text.substring(actualIndex);

        // Ищем следующее вхождение
        index = hyphenatedText.indexOf(hp.pattern, index + splitter.length + 1);
      }
    }

    // 3) Теперь text содержит splitter в местах переноса
    // Разобьём его и в каждом фрагменте проставим hyphenateSymbol (\u00AD)
    final parts = text.split(splitter);
    final result = StringBuffer();
    for (int i = 0; i < parts.length; i++) {
      final value = parts[i];
      result.write(hyphenateSymbol + value);
    }

    // Удалим первый \u00AD, т.к. в начале строки он не нужен
    String res = result.toString();
    if (res.startsWith(hyphenateSymbol)) {
      res = res.substring(hyphenateSymbol.length);
    }

    return res;
  }
}

class HyphenPair {
  final String pattern;
  final int position;

  HyphenPair(this.pattern, this.position);
}