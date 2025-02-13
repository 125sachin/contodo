part of 'splash_view.dart';

class SplashViewModel extends BaseViewModel {
  final log = getLogger('SplashViewModel');
  final _navigationService = locator<NavigationService>();

  void init() async {
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        _navigationService.clearStackAndShow(Routes.homeView);
      });
    } catch (e) {
      log.e(e);
    }
  }
}
