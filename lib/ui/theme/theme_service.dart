import 'package:contodo/file_exporter.dart';

@lazySingleton
class ThemeService {
  static const String _key = 'isDark';
  static final _localStorageService = locator<LocalStorageService>();

  final ValueNotifier<bool> brightnessListenable =
      ValueNotifier<bool>(_localStorageService.read<bool>(_key) ?? false);

  Brightness get brightness =>
      brightnessListenable.value ? Brightness.dark : Brightness.light;

  void updateTheme() {
    brightnessListenable.value = !brightnessListenable.value;
    _localStorageService.write(_key, brightnessListenable.value);
  }
}
