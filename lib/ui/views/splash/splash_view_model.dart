part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final log = getLogger('SplashViewModel');
  final _navigationService = locator<NavigationService>();
  final _firebaseService = locator<FirebaseService>();
  final _localStorageService = locator<LocalStorageService>();
  String? token;
  SplashViewModel() {
    token = _localStorageService.read('token');
  }

  Future<void> init() async {
    try {
      // Step 1: Check if a token exists in local storage
      log.i(token);
      if (token != null) {
        //  Check if the user is valid in Firestore
        final userData = await _firebaseService.getUserData(token!);

        if (userData != null) {
          // User is valid, navigate to Home View
          log.i('Valid user found. Navigating to Home View...');
          _navigationService.clearStackAndShow(Routes.homeView);
        } else {
          // Token exists but user not found in Firestore, navigate to Signup View
          log.i(
              'Token exists but user not found in database. Navigating to Signup View...');
          _navigationService.clearStackAndShow(Routes.signupView);
        }
      } else {
// No token exists, navigate to Login View
        log.i('No token found. Navigating to Login View...');
        await Future.delayed(Duration(seconds: 2));
        _navigationService.clearStackAndShow(Routes.loginView);
      }
    } catch (e) {
      log.e('Error during initialization: $e');
    }
  }
}
