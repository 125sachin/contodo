part of 'app_buttons.dart';

class _IconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color? bgColor;
  final Color? iconColor;
  const _IconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.bgColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 23.w,
        backgroundColor: bgColor ?? context.colorScheme.bgOverlay,
        child: Icon(
          icon,
          color: iconColor ?? context.colorScheme.ogWhite,
          size: 20.h,
        ),
      ),
    );
  }
}
