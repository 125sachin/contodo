import 'package:contodo/file_exporter.dart';
part 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.appScaffold,
          body: Center(
            child: LottieBuilder.asset(
              AssetConstants.logoAnimation,
              height: 130.h,
              width: 130.w,
            ),
          ),
        );
      },
    );
  }
}
