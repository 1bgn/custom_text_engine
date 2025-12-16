# custom_text_engine

Custom text layout engine for Flutter: paragraphs, inline elements, manual justify, and hyphenation-oriented line breaking.

> Status: active development. Public API may change until `0.x` stabilizes.

## Why this exists

Flutter `Text/RichText` is great for typical UI, but it’s hard to customize advanced layout behavior (custom line breaking, special inline elements, reader-style typography).
This package provides a small layout engine that builds `dart:ui Paragraph` per line and exposes `LineLayout` objects for custom painting, debugging, and interaction.

## Features

- Paragraph layout into lines with custom wrapping rules.
- Inline elements: text runs, hard line breaks, indents, and extensible custom elements.
- Manual justify support (space distribution).
- Hyphenation hooks (soft hyphen / forced split strategies, depending on your engine implementation).
- Caching of measured elements / paragraphs (implementation-dependent).

## Installation

Add dependency:

dependencies:
custom_text_engine: ^1.0.0

text

Then:

flutter pub get

text

## Quick start (engine)

import 'package:custom_text_engine/custom_text_engine.dart';

final engine = AdvancedLayoutEngine(
paragraphs: paragraphs,
globalMaxWidth: 420,
globalTextAlign: TextAlign.justify,
);

final layout = engine.layoutAllParagraphs();

// layout.lines -> List<LineLayout>, each may contain a built Paragraph.

text

## Demo widget

This repo includes (or can include) an example widget that paints the layout via `CustomPaint`.
Run:

cd example
flutter run

text

## Generated code (freezed)

This package uses `freezed` for model code generation.
Consumers of the published package do **not** need to run `build_runner` — generated files must be included in the published package. 

For contributors (when changing annotated models):

dart run build_runner build --delete-conflicting-outputs

text

## Public API rules

Do not import files from `lib/src/**`.
Only import:

import 'package:custom_text_engine/custom_text_engine.dart';

text

This keeps implementation private and allows internal refactors without breaking users. 

## Contributing

PRs and issues are welcome.
Please read `CONTRIBUTING.md` for local setup, formatting, and test guidance.

## License

Apache-2.0 (see `LICENSE`).  
Recommended release check before publishing:

dart pub publish --dry-run

text

## Author

1bgn <137element@gmail.com>