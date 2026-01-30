import 'package:get/get.dart';
import 'package:graphics_cycle/features/splash/screens/splash_screen.dart';
import 'package:graphics_cycle/features/home/screens/home_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String loginScreen = "/loginScreen";
  static String homeScreen = "/homeScreen";

  static String getSplashScreen() => splashScreen;

  static List<GetPage> routes = [
    GetPage(
      name: '/splashScreen',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/homeScreen',
      page: () => const HomeScreen(),
    ),
  ];
}
