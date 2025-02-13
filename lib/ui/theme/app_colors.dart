import 'package:contodo/file_exporter.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get appPrimary => const Color(0xFF121212);
  Color get appSuccess => const Color(0xFF1FC87F);
  Color get appFailure => const Color(0xFFF05E4B);

  Color get ogWhite => Brightness.dark == brightness
      ? const Color.fromARGB(255, 56, 56, 56)
      : const Color(0xFFFFFFFF);
  Color get ogBlack => Brightness.dark == brightness
      ? const Color(0xFFFFFFFF)
      : const Color.fromARGB(255, 56, 56, 56);

  Color get appScaffold => Brightness.dark == brightness
      ? const Color(0xFF121212)
      : Color.fromARGB(255, 243, 238, 238);

  Color get bgOverlay => const Color(0xFF3D3D3D);

  // Text
  Color get appText => Brightness.dark == brightness
      ? const Color(0xFFE2E2E2)
      : const Color(0xFF121212);
  Color get title => Brightness.dark == brightness
      ? const Color(0xFFE2E2E2)
      : const Color(0xFF121212);
  Color get subTitle => Brightness.dark == brightness
      ? const Color(0xFFE2E2E2)
      : const Color(0xFF121212);
  Color get greenText => const Color(0xFF29B379);

  // View
  Color get baseView => const Color(0xFF1a1c29);
}
