import 'package:contodo/file_exporter.dart';

part 'login_view_model.dart';
part 'login_view_components.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: context.colorScheme.appScaffold,
          body: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20.0.h, left: 20.0.w, right: 20.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    40.verticalSpace,
                    const _AppHeader(),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Email'),
                            onChanged: (value) => viewModel.setEmail(value),
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: false,
                            onChanged: (value) => viewModel.setPassword(value),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  viewModel.showForgotPasswordDialog(context);
                                },
                                child: AppText(
                                  'Forgot Password?',
                                  context,
                                ).bodyMedium,
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          ElevatedButton(
                            onPressed: viewModel.isBusy
                                ? null
                                : () => viewModel.login(),
                            child: AppText(
                                    viewModel.isBusy
                                        ? 'Logging in...'
                                        : 'Login',
                                    context)
                                .bodyMedium,
                          ),
                          10.verticalSpace,
                          AppButton.primaryElevated(
                              bgColor: context.colorScheme.appScaffold,
                              onPressed: () {
                                viewModel.goToSignUpPage();
                              },
                              title: "Signup",
                              textColor: context.colorScheme.ogBlack)
                        ],
                      ),
                    ),
                    40.verticalSpace,
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
