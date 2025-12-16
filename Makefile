# ==========
# Flutter Monorepo Makefile
# ==========


# Основные команды
bootstrap:
	dart run melos bootstrap

get:
	melos exec -- flutter pub get

upgrade:
	melos exec -- flutter pub upgrade

clean:
	melos exec -- flutter clean
	melos exec -- rm -rf .dart_tool build pubspec.lock

# Тестирование
test:
	melos run test

# Анализ кода
analyze:
	melos run analyze

format:
	melos run format

# Генерация кода (Freezed, AutoRoute, Injectable)
build:
	 dart run build_runner build --delete-conflicting-outputs

watch:
	 dart run build_runner watch --delete-conflicting-outputs

# Запуск основного приложения
run:
	cd app && flutter run

# Запуск под iOS/Android/web
run-ios:
	cd app && flutter run -d ios

run-android:
	cd app && flutter run -d android

run-web:
	cd app && flutter run -d chrome

# Обновление зависимостей Melos
melos-get:
	cd . && dart pub get
clean-for-archive:
	@echo "🧹 Cleaning generated & temp files..."
	find . -type d -name '.dart_tool' -exec rm -rf {} + \
	  -o -type d -name 'build' -exec rm -rf {} + \
	  -o -name 'pubspec.lock' -exec rm -f {} + \
	  -o -name '.packages' -exec rm -f {} + \
	  -o -name '.DS_Store' -exec rm -f {} + \
	  -o -type f \( -name '*.g.dart' -o -name '*.gr.dart' -o -name '*.config.dart' \) -exec rm -f {} +
