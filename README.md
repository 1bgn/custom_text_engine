# custom_text_engine

A custom text layout engine for Flutter with paragraph-level layout, inline elements, manual
justify, and hyphenation-oriented line breaking.

> Status: active development. Public API may change until `0.x` stabilizes.

## What you get

This package can be used in two ways:

1) **Ready-to-use widget**: `AdvancedText`  
   Quickly render your `ParagraphBlock`s using `CustomPaint`.

2) **Low-level engine API**: `AdvancedLayoutEngine`  
   Build a `CustomTextLayout` (list of `LineLayout`s) and paint/measure/interact with it however you
   want.

## Features

- Paragraph layout into lines with custom wrapping rules.
- Inline elements: text runs, hard line breaks, indents, extensible custom elements.
- Manual justify support (space distribution).
- Hyphenation hooks (soft hyphen / forced split strategies).
- (Optional) caching of measured elements / paragraphs (implementation-dependent).

## Installation

Add dependency:

dependencies:
custom_text_engine: ^0.1.0

Then:

flutter pub get

## Quick start (widget)

If you just want to render text with this engine, use `AdvancedText`.

```
import 'package:flutter/material.dart';
import 'package:custom_text_engine/custom_text_engine.dart';

class DemoPage extends StatelessWidget {
const DemoPage({super.key});

@override
Widget build(BuildContext context) {
final paragraphs = <ParagraphBlock>[
ParagraphBlock(
inlineElements: [
TextInlineElement(
text: 'Hello custom text engine! ',
style: const TextStyle(fontSize: 16),
),
TextInlineElement(
text: 'Justify + hyphenation demo.',
style: const TextStyle(fontSize: 16),
),
],
textAlign: TextAlign.justify,
),
];

return Scaffold(
appBar: AppBar(title: const Text('custom_text_engine')),
body: Padding(
padding: const EdgeInsets.all(16),
child: AdvancedText(
paragraphs: paragraphs,
debugPaint: false,
),
),
);
}
}
```

## Quick start (engine)

Use `AdvancedLayoutEngine` when you want custom rendering, hit-testing, selection, annotations, etc.

```import 'package:custom_text_engine/custom_text_engine.dart';

final engine = AdvancedLayoutEngine(
paragraphs: paragraphs,
globalMaxWidth: 420,
globalTextAlign: TextAlign.justify,
);

final layout = engine.layoutAllParagraphs();

```

## Example app

A runnable Flutter example app is included in `example/`.

cd example
flutter run

## Public API

Do not import files from `lib/src/**`.

Use only:

import 'package:custom_text_engine/custom_text_engine.dart';

This keeps implementation private and allows internal refactors without breaking users. [web:69]

## Contributing

PRs and issues are welcome — see `CONTRIBUTING.md`.

## License

Apache-2.0 (see `LICENSE`).

## Author

1bgn <137element@gmail.com>