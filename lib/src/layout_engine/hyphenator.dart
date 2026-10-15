class Hyphenator {
  final String x = "йьъ";
  // Гласные/согласные: русские, латинские и частые латинские диакритики (немецкие умляуты
  // и ß, французские, испанские, скандинавские и др.). Без них буквы вроде ä/ö/ü/ß
  // оказывались «посторонними» символами и рвали шаблоны переноса.
  final String g = "аеёиоуыэюяaeiouyàáâãäåæèéêëìíîïòóôõöøùúûüýÿœ";
  final String s = "бвгджзклмнпрстфхцчшщbcdfghjklmnpqrstvwxzçñßšžčřćńśźżłđð";

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

  /// Основной метод для вставки мягких переносов (Unicode ­) в текст
  /// на основании правил в [rules].
  ///
  /// Возвращает строку с вставленными ­, которые Flutter
  /// интерпретирует как "дефис при переносе".
  String hyphenate(String text, {String hyphenateSymbol = "­"}) {
    final int n = text.length;

    // 1) Построим маску x/g/s по нижнему регистру, чтобы заглавные буквы
    //    попадали в те же классы, что и строчные (индексы/длина не меняются).
    final sb = StringBuffer();
    for (int i = 0; i < n; i++) {
      final String c = text[i].toLowerCase();
      if (x.contains(c)) {
        sb.write("x");
      } else if (g.contains(c)) {
        sb.write("g");
      } else if (s.contains(c)) {
        sb.write("s");
      } else {
        sb.write(text[i]);
      }
    }
    final String mask = sb.toString();

    // 2) Ищем точки переноса по неизменяемой маске и копим их как индексы
    //    в исходном тексте. Раньше правила искали совпадения в строке,
    //    которую уже мутировали предыдущие правила — из-за этого повторное
    //    правило с тем же паттерном (например, две записи "gsssg" с разной
    //    позицией переноса) могло не найти совпадение, потому что символ-
    //    разделитель от первого правила разрывал непрерывность паттерна.
    final breakPoints = <int>{};
    for (final hp in rules) {
      int index = mask.indexOf(hp.pattern);
      while (index != -1) {
        final actualIndex = index + hp.position;
        if (actualIndex > 0 && actualIndex < n) {
          breakPoints.add(actualIndex);
        }
        index = mask.indexOf(hp.pattern, index + 1);
      }
    }

    if (breakPoints.isEmpty) return text;

    // 3) Вставляем ­ один раз, за один проход по исходному тексту.
    final sortedBreaks = breakPoints.toList()..sort();
    final result = StringBuffer();
    int cursor = 0;
    for (final bp in sortedBreaks) {
      result
        ..write(text.substring(cursor, bp))
        ..write(hyphenateSymbol);
      cursor = bp;
    }
    result.write(text.substring(cursor));

    return result.toString();
  }
}

class HyphenPair {
  final String pattern;
  final int position;

  HyphenPair(this.pattern, this.position);
}
