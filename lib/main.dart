import 'package:contodo/file_exporter.dart';

Future<void> servicesToInitialiseBeforeAppStart() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Contodo',
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          initialRoute: Routes.splashView,
        );
      },
    );
  }
}
