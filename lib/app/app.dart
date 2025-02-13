import 'package:contodo/core/services/local_storage_services.dart';
import 'package:contodo/ui/theme/theme_service.dart';
import 'package:contodo/ui/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:contodo/ui/views/splash/splash_view.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: SplashView, initial: true),
    CupertinoRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: ThemeService),
  ],
  logger: StackedLogger(),
)
class $AppRouter {}

// dart run build_runner build --delete-conflicting-outputs
