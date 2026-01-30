import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../controllers/bottom_nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(BottomNavController());

    return Obx(() => Scaffold(
          body: c.pages[c.index.value],
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFE1F5FE), // Light blue
            onPressed: () => Get.to(() => const ScanScreen()),
            child: const Icon(Icons.qr_code_scanner, color: Colors.blueAccent),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: c.labels.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? Colors.blue : Colors.black54;
              final iconData =
                  isActive ? c.activeIcons[index] : c.inactiveIcons[index];
              return SizedBox(
                width: 72,
                height: 64,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(iconData, size: 26, color: color),
                      const SizedBox(height: 4),
                      Text(
                        c.labels[index],
                        style: TextStyle(fontSize: 11, color: color),
                      ),
                    ],
                  ),
                ),
              );
            },
            activeIndex: c.index.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            backgroundColor: Colors.white,
            splashColor: Colors.transparent,
            gapWidth: 60,
            onTap: (index) => c.index.value = index,
          ),
        ));
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan')),
      body: const Center(child: Text('Scan Screen')),
    );
  }
}
