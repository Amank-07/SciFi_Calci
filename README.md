# SciFi Calci

SciFi Calci is a Flutter-based **Scientific Calculator** built with **Clean Architecture** and **Provider** state management.  
It is designed to be interview-ready, scalable, and easy to extend.

## Features

- Basic operations: `+`, `-`, `×`, `÷`, `%`
- Scientific operations: `sin`, `cos`, `tan`, `log`, `ln`, `√`, `∛`
- Advanced operations: `x²`, `x³`, `xʸ`, `!`, `1/x`, `|x|`
- Constants: `π`, `e`
- Expression evaluation using [`math_expressions`](https://pub.dev/packages/math_expressions)
- Splash screen with timed navigation
- Dark/light theme toggle
- In-memory calculation history
- Tab-based calculator layout (`Basic`, `Scientific`, `Advanced`) for better small-screen usability

## Architecture

Project follows Clean Architecture with clear separation of concerns:

```text
lib/
  core/          # constants, utilities
  data/          # repositories, models
  domain/        # entities, repository contracts, use cases
  presentation/  # app UI, state/controller, reusable widgets, screens
```

## Tech Stack

- Flutter
- Dart
- Provider
- math_expressions

## Getting Started

### Prerequisites

- Flutter SDK (stable)
- Dart SDK (comes with Flutter)
- Android Studio / VS Code
- Android emulator or physical device

### Installation

```bash
git clone <your-repo-url>
cd SciFi_Calci
flutter pub get
```

### Run

```bash
flutter run
```

## Testing

```bash
flutter test
flutter analyze
```

## Notes for Publishing

Before publishing, update:

- `pubspec.yaml`:
  - `description`
  - `version`
  - `homepage` / `repository` (if applicable)
- App name, icons, and screenshots
- Platform-specific signing/release configs

## License

This project is open-source. Add a `LICENSE` file (MIT/Apache-2.0 recommended) before public release.
