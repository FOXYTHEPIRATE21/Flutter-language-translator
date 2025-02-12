# Flutter Language Translator Master
A modern Flutter application that enables users to translate text between multiple languages with a beautiful design. This project demonstrates how to implement translation functionality in Flutter, making it perfect for learning or integrating into your own applications.

## Features
- **Multi-Language Support**: Translate between 10 major world languages.
- **Modern UI Design**: Clean and intuitive Material 3 interface.
- **Real-Time Translation**: Instant translation with loading feedback.
- **Language Swapping**: Quick swap between source and target languages.
- **Copy Functionality**: Easy copy-to-clipboard for translated text.
- **Custom App Icons**: Professionally designed app icons using `flutter_launcher_icons`.

## Dependencies
This project uses the following dependencies:
- `flutter`: The core framework for building the app.
- `translator`: A plugin for text translation functionality.
- `flutter_launcher_icons`: A package to generate custom launcher icons.
- `cupertino_icons`: iOS-style icons for the application.

## Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/FOXYTHEPIRATE21/Flutter-language-translator
   ```
2. **Navigate to the project directory**:
   ```bash
   cd translator_master
   ```
3. **Install dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the app**:
   ```bash
   flutter run
   ```

## Usage
### Translating Text
1. Select the source language from the left dropdown.
2. Select the target language from the right dropdown.
3. Enter the text you want to translate in the input field.
4. Click the "Translate" button to see the translation.
5. Use the copy button to copy the translated text.

### Language Swapping
1. Use the swap button between languages to quickly switch between source and target languages.
2. The app will automatically handle the input/output swap if text is present.

### Customizing App Icons
1. Place your icon image in the assets folder as `languages.png`.
2. The `flutter_launcher_icons` configuration is already set up in `pubspec.yaml`.
3. Generate icons by running:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

## Contributing
Contributions are welcome! If you have any suggestions, bug reports, or feature requests, please open an issue or submit a pull request.

## Acknowledgments
- [translator](https://pub.dev/packages/translator) for the translation functionality.
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) for app icon generation.
- Material Design 3 for the modern UI components.

## Support
If you find this project useful, consider giving it a star on GitHub. Your support is greatly appreciated!