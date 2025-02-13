part of 'login_view.dart';

class LoginViewModel extends BaseViewModel {
  final log = getLogger("LoginViewModel");
  final FirebaseService _firebaseService = FirebaseService();
  final NavigationService _navigationService = locator<NavigationService>();
  final ToastService _toastService = locator<ToastService>();

  String _email = '';
  String _password = '';

  // Setters for email and password
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  // Getter for email and password (if needed for debugging or display)
  String get email => _email;
  String get password => _password;

  Future<void> login() async {
    setBusy(true);
    try {
      await _firebaseService.login(_email, _password);
      _navigationService.clearStackAndShow(Routes.homeView);
    } catch (e) {
      _toastService.showToastMessage("Error", e.toString(),
          type: ToastificationType.error);
    } finally {
      setBusy(false);
    }
  }

  Future<void> onForgetPassword(String email) async {
    await _firebaseService.forgetPassword(email);
  }

  void goToSignUpPage() {
    _navigationService.clearStackAndShow(Routes.signupView);
  }

  void showForgotPasswordDialog(BuildContext context) {
    final TextEditingController forgotEmailController = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Forgot Password'),
          content: Column(
            children: [
              SizedBox(height: 8), // Add spacing
              CupertinoTextField(
                controller: forgotEmailController,
                placeholder: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              )
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                // Dismiss the dialog
                Navigator.of(context).pop();
              },
              child: AppText('Cancel', context).bodyMedium,
            ),
            CupertinoDialogAction(
              onPressed: () async {
                final email = forgotEmailController.text.trim();
                if (email.isNotEmpty) {
                  // Submit email logic
                  await onForgetPassword(email);
                  _toastService.showToastMessage(
                      "Request Send", "Check your email for reset link",
                      type: ToastificationType.info);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                }
                // Dismiss the dialog
              },
              child: AppText('Submit', context).bodyMedium,
            ),
          ],
        );
      },
    );
  }
}
