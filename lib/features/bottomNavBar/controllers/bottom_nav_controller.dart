import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:graphics_cycle/features/home/screens/home_screen.dart';

// --- Controller ---
class BottomNavController extends GetxController {
  var index = 0.obs;

  // Active / inactive icon sets for selected and unselected states
  final List<IconData> activeIcons = const [
    Icons.home_rounded,
    Icons.history_rounded,
    Icons.cloud,
    Icons.person_rounded,
  ];

  final List<IconData> inactiveIcons = const [
    Icons.home_outlined,
    Icons.history_outlined,
    Icons.cloud_outlined,
    Icons.person_outline,
  ];

  // Backwards-compatible alias used elsewhere in the codebase
  List<IconData> get icons => activeIcons;

  final List<String> labels = const [
    'Home',
    'History',
    'Cloud',
    'Profile',
  ];

  final List<Widget> pages = const [
    HomeScreen(),
    Center(child: Text('History Page')),
    Center(child: Text('Cloud Page')),
    Center(child: Text('Profile Page')),
  ];
}

// --- Main Widget ---
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Get.put if not already initialized
    final c = Get.put(BottomNavController());

    return Obx(() => Scaffold(
          body: c.pages[c.index.value],

          // Updated FAB to match the purple rounded look in your screenshot
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFEADDFF), // Light purple
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: () => Get.to(() => const ScanScreen()),
            child: const Icon(
              Icons.qr_code_scanner,
              color: Colors.limeAccent, // Deep purple icon
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: c.icons.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? Colors.blue : Colors.grey;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    c.icons[index],
                    size: 24,
                    color: color,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    c.labels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              );
            },
            activeIndex: c.index.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => c.index.value = index,
          ),
        ));
  }
}

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan')),
      body: const Center(child: Text('Scanner Active')),
    );
  }
}
