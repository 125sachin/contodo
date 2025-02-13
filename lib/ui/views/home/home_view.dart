import 'package:contodo/file_exporter.dart';

part 'home_view_model.dart';
part 'home_view_components.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.appScaffold,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.verticalSpace,
                  const _AppHeader(),
                  const Spacer(),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
