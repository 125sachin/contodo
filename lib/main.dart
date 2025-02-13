import 'package:contodo/file_exporter.dart';
import 'package:contodo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> servicesToInitialiseBeforeAppStart() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await setupLocator();
    await Future.wait([
      locator<LocalStorageService>().initStorage(),
    ]);
  } catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> main() async {
  await servicesToInitialiseBeforeAppStart();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = locator<ThemeService>();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder(
            valueListenable: themeService.brightnessListenable,
            builder: ((context, value, child) {
              return ToastificationWrapper(
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Contodo',
                  theme: ThemeData(
                    brightness: themeService.brightness,
                  ),
                  onGenerateRoute: StackedRouter().onGenerateRoute,
                  navigatorKey: StackedService.navigatorKey,
                  initialRoute: Routes.splashView,
                ),
              );
            }));
      },
    );
  }
}
