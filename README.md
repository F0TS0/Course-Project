# Translator App

A Flutter translator app with cloud-synced translation history using Firebase Firestore.

## Features

- Translate text between English, French, Spanish, and German (MyMemory API, free)
- Translation history synced with Firebase Firestore
- Connectivity check with meaningful error messages
- Material Design 3 theme
- MVC-like structure: UI, logic, and data layers separated

## Requirements

- Flutter 3.11+
- Firebase project (for cloud sync)

## Setup

1. Install Flutter: [flutter.dev](https://docs.flutter.dev/get-started/install)

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Configure Firebase for cloud sync (see [FIREBASE_SETUP.md](FIREBASE_SETUP.md)):
   ```bash
   dart run flutterfire configure
   ```

## Run

```bash
flutter run
```

## Test

```bash
flutter test
```

## Project structure

```
lib/
  main.dart              # App entry, providers
  theme/
    app_theme.dart       # Material Design theme
  models/
    translation.dart     # Translation model
  services/
    translation_service.dart  # MyMemory API
    history_service.dart     # Firestore
    connectivity_service.dart
  controllers/
    translator_controller.dart
  screens/
    translator_screen.dart
    history_screen.dart
```
