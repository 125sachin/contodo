import 'package:contodo/file_exporter.dart';

extension ColorSchemeExtension on ColorScheme {
  Color get appPrimary => const Color(0xFF121212);
  Color get appSuccess => const Color(0xFF1FC87F);
  Color get appFailure => const Color(0xFFF05E4B);

  Color get ogWhite => const Color(0xFFFFFFFF);
  Color get ogBlack => const Color(0xFF000000);

  Color get appScaffold => Brightness.dark == brightness
      ? Color(0xFFE2E2E2)
      : const Color(0xFF121212);

  Color get bgOverlay => const Color(0xFF3D3D3D);

  // Text
  Color get appText => const Color(0xFFE2E2E2);
  Color get title => const Color(0xFFFBFBFB);
  Color get subTitle => const Color(0xFFEFEFEF);
  Color get greenText => const Color(0xFF29B379);

  // View
  Color get baseView => const Color(0xFF1a1c29);
}
