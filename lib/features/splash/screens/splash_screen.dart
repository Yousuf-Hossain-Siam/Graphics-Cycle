import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SplashController>()) {
      Get.put(SplashController());
    }

    return const Scaffold(
      body: Image(
        image: AssetImage('assets/images/screen.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}
