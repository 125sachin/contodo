part of 'app_buttons.dart';

class _PrimaryElevated extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color? bgColor;
  final Color? borderColor;

  const _PrimaryElevated({
    super.key,
    required this.onPressed,
    required this.title,
    this.bgColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 20.w),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: bgColor ?? context.colorScheme.ogWhite,
            )),
        child: Center(
          widthFactor: 1.w,
          child: AppText(
            title,
            context,
            color: context.colorScheme.ogWhite,
          ).bodySmall,
        ),
      ),
    );
  }
}
