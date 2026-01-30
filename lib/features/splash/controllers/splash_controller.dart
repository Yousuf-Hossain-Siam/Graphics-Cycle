import 'package:get/get.dart';
import '../../bottomNavBar/screens/bottom_nav_bar.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => const BottomNavBar());
  }
}
