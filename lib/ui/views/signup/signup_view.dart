import 'package:contodo/file_exporter.dart';

part 'signup_view_model.dart';
part 'signup_view_components.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.appScaffold,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0.r),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    40.verticalSpace,
                    const _AppHeader(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Name'),
                            onChanged: (value) => viewModel.setName(value),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Email'),
                            onChanged: (value) => viewModel.setEmail(value),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            onChanged: (value) => viewModel.setPassword(value),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: viewModel.isBusy
                                ? null
                                : () => viewModel.signup(),
                            child: AppText(
                                    viewModel.isBusy
                                        ? 'Logging in...'
                                        : 'SignUp',
                                    context)
                                .bodyMedium,
                          ),
                          10.verticalSpace,
                          AppButton.primaryElevated(
                              bgColor: context.colorScheme.appScaffold,
                              onPressed: () {
                                viewModel.goToLoginPage();
                              },
                              title: "login",
                              textColor: context.colorScheme.ogBlack)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
