import 'package:contodo/file_exporter.dart';

part 'icon_button.dart';
part 'text_button.dart';
part 'primary_elevated_button.dart';

/// Provides multiple styles of buttons using static factory methods.
class AppButton {
  /// Private constructor to prevent instantiation.
  const AppButton._();

  /// Returns an icon button with optional colors.
  static Widget iconButton({
    Key? key,
    required Function() onPressed,
    required IconData icon,
    Color? iconColor,
    Color? bgColor,
  }) =>
      _IconButton(
        key: key,
        onPressed: onPressed,
        icon: icon,
        iconColor: iconColor,
        bgColor: bgColor,
      );

  /// Returns a primary elevated button with a text label.
  static Widget primaryElevated({
    Key? key,
    required Function() onPressed,
    required String title,
    Color? borderColor,
    Color? bgColor,
    Color? textColor,
  }) =>
      _PrimaryElevated(
        key: key,
        onPressed: onPressed,
        title: title,
        bgColor: bgColor,
        borderColor: borderColor,
        textColor: textColor,
      );

  /// Returns a text button with optional styling.
  static Widget text({
    Key? key,
    required Function() onPressed,
    required String title,
    Color? textColor,
    double? fontSize,
    bool? underLine,
  }) =>
      _TextButton(
        key: key,
        onPressed: onPressed,
        title: title,
        textColor: textColor,
        fontSize: fontSize,
        underLine: underLine,
      );
}
