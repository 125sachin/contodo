part of 'signup_view.dart';

/// A widget that displays an App Header with a heading text.
class _AppHeader extends StatelessWidget {
  const _AppHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Signup',
          context,
          color: context.colorScheme.title,
        ).heading2,
      ],
    );
  }
}
