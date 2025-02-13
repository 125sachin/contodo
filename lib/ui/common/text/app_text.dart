import 'package:contodo/file_exporter.dart';

class AppText {
  final String text;
  final BuildContext context;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final String? fontFamily;
  final double? height;
  final bool? softwrap;
  final bool? underline;
  AppText(this.text, this.context,
      {this.color,
      this.fontSize,
      this.fontWeight,
      this.overflow,
      this.textAlign,
      this.maxLines,
      this.fontFamily,
      this.height,
      this.softwrap,
      this.underline});

  Widget _buildText(
    String text, {
    required double fontSize,
    required Color color,
    FontWeight? weight,
    TextOverflow? overflow,
    TextAlign? textAlign,
    bool underline = false,
    String? fontFamily,
  }) =>
      Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily ?? "Gilroy",
          fontSize: fontSize.sp,
          color: color,
          fontWeight: weight,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
          height: height,
          decorationStyle: TextDecorationStyle.dotted,
          decorationColor: color,
        ),
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
        softWrap: softwrap,
      );

  /// Heading1 with Size 38 and Weight 700
  Widget get heading1 => _buildText(
        text,
        fontSize: fontSize ?? 38.sp,
        color: color ?? context.colorScheme.appText,
        weight: fontWeight ?? FontWeight.w700,
        overflow: overflow,
        textAlign: textAlign,
        underline: underline ?? false,
      );

  /// Heading2 with Size 34 and Weight 700
  Widget get heading2 => _buildText(
        text,
        fontSize: fontSize ?? 34.sp,
        color: color ?? context.colorScheme.appText,
        weight: fontWeight ?? FontWeight.w700,
        overflow: overflow,
        textAlign: textAlign,
        fontFamily: fontFamily,
        underline: underline ?? false,
      );

  /// Heading1 with Size 20 and Weight 600
  Widget get heading3 => _buildText(
        text,
        fontSize: fontSize ?? 20.sp,
        color: color ?? context.colorScheme.appText,
        weight: fontWeight ?? FontWeight.w600,
        overflow: overflow,
        textAlign: textAlign,
        underline: underline ?? false,
      );

  /// Heading1 with Size 16 and Weight 600
  Widget get heading4 => _buildText(
        text,
        fontSize: fontSize ?? 16.sp,
        color: color ?? context.colorScheme.appText,
        weight: fontWeight ?? FontWeight.w600,
        overflow: overflow,
        textAlign: textAlign,
        underline: underline ?? false,
      );

  /// Heading1 with Size 14 and Weight 400
  Widget get bodyMedium => _buildText(
        text,
        fontSize: fontSize ?? 14.sp,
        color: color ?? context.colorScheme.appText,
        weight: fontWeight ?? FontWeight.w400,
        overflow: overflow,
        textAlign: textAlign,
        underline: underline ?? false,
      );

  /// Heading1 with Size 12 and Weight 400
  Widget get bodySmall => _buildText(
        text,
        fontSize: fontSize ?? 11.sp,
        color: color ?? context.colorScheme.appText,
        weight: fontWeight ?? FontWeight.w400,
        overflow: overflow,
        textAlign: textAlign,
        fontFamily: fontFamily,
        underline: underline ?? false,
      );
}
