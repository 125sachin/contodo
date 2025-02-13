part of 'signup_view.dart';

class SignupViewModel extends BaseViewModel {
  final log = getLogger("SignupViewModel");
  final FirebaseService _firebaseService = FirebaseService();
  final NavigationService _navigationService = locator<NavigationService>();
  final ToastService _toastService = locator<ToastService>();

  String _email = '';
  String _password = '';
  String _name = '';

  // Setters for email and password
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  // Getter for email and password (if needed for debugging or display)
  String get email => _email;
  String get password => _password;
  String get name => _name;

  Future<void> signup() async {
    setBusy(true);
    try {
      await _firebaseService.signup(
        _email,
        _password,
        _name,
      );
      _navigationService.clearStackAndShow(Routes.homeView);
    } catch (e) {
      _toastService.showToastMessage("Error", e.toString(),
          type: ToastificationType.error);
    } finally {
      setBusy(false);
    }
  }

  void goToLoginPage() {
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}
