import 'package:contodo/core/services/firebase_services.dart';
import 'package:contodo/core/services/local_storage_services.dart';
import 'package:contodo/core/services/toast_service.dart';
import 'package:contodo/ui/theme/theme_service.dart';
import 'package:contodo/ui/views/completed_task/completed_task_view.dart';
import 'package:contodo/ui/views/home/home_view.dart';
import 'package:contodo/ui/views/login/login_view.dart';
import 'package:contodo/ui/views/signup/signup_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:contodo/ui/views/splash/splash_view.dart';

@StackedApp(
  routes: [
    CupertinoRoute(page: SplashView, initial: true),
    CupertinoRoute(page: HomeView),
    CupertinoRoute(page: LoginView),
    CupertinoRoute(page: SignupView),
    CupertinoRoute(page: CompletedTaskView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: FirebaseService),
    LazySingleton(classType: ToastService),
  ],
  logger: StackedLogger(),
)
class $AppRouter {}

// dart run build_runner build --delete-conflicting-outputs
