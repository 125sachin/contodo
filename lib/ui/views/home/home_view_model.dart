part of 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  final log = getLogger("HomeViewModel");
  final _navigationService = locator<NavigationService>();
}
