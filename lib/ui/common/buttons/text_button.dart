part of 'app_buttons.dart';

class _TextButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? textColor;
  final double? fontSize;
  final bool? underLine;

  const _TextButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.textColor,
    this.fontSize,
    this.underLine,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AppText(
        title,
        context,
        color: textColor ?? context.colorScheme.ogWhite,
        fontSize: fontSize ?? 12.sp,
        underline: underLine ?? false,
      ).bodySmall,
    );
  }
}
