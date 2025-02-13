// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../core/services/firebase_services.dart';
import '../core/services/local_storage_services.dart';
import '../core/services/toast_service.dart';
import '../ui/theme/theme_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LocalStorageService());
  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => ToastService());
}
