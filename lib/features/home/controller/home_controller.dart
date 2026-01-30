import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ActivityItem {
  final String title;
  final String time;
  final String size;
  final String type;

  ActivityItem({
    required this.title, 
    required this.time, 
    required this.size, 
    required this.type
  });
}

class HomeController extends GetxController {
  // Observable list for Recent Activity
  final recentActivities = <ActivityItem>[
    ActivityItem(title: "Invoice_Acme_2023.pdf", time: "2 mins ago", size: "1.2 MB", type: "pdf"),
    ActivityItem(title: "Contract_Draft_v2.pdf", time: "Yesterday", size: "450 KB", type: "pdf"),
    ActivityItem(title: "Business_Card_John.jpg", time: "Oct 24", size: "100 KB", type: "image"),
  ].obs;

  final ImagePicker _picker = ImagePicker();

  /// Handles Camera Scanning
  Future<void> pickImageFromCamera() async {
    try {
      // Request/check camera permission at runtime
      final status = await Permission.camera.status;
      if (!status.isGranted) {
        final result = await Permission.camera.request();
        if (!result.isGranted) {
          if (result.isPermanentlyDenied) {
            Get.snackbar(
              'Camera Error',
              'Camera permission permanently denied. Please enable it in app settings.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            // Open app settings to allow the user to grant permission
            openAppSettings();
            return;
          } else {
            Get.snackbar(
              'Camera Error',
              'Camera permission denied. Cannot open camera.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            return;
          }
        }
      }

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera, 
        imageQuality: 85,
      );

      if (photo != null) {
        final file = File(photo.path);
        final int bytes = await file.length();
        
        // Calculate dynamic size
        final String sizeString = bytes < 1024 * 1024 
            ? '${(bytes / 1024).toStringAsFixed(0)} KB' 
            : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';

        // Insert new activity at the top
        recentActivities.insert(0, ActivityItem(
          title: photo.name, 
          time: 'Just now', 
          size: sizeString, 
          type: 'image',
        ));
        
        Get.snackbar(
          'Success', 
          'Image added to activities', 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on PlatformException catch (e) {
      // Specifically addresses the "channel-error"
      Get.snackbar(
        'System Error', 
        'Plugin connection failed. Please rebuild the app (flutter clean).', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      debugPrint("Platform Error: ${e.message}");
    } catch (e, st) {
      final msg = e.toString();
      Get.snackbar(
        'Camera Error',
        msg.isNotEmpty ? msg : 'Could not open camera. Please restart the app.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      debugPrint('Camera Error: $e');
      debugPrint('Stacktrace: $st');
    }
  }

  /// Debug helper: show current camera permission status
  Future<void> debugCameraStatus() async {
    final status = await Permission.camera.status;
    Get.snackbar(
      'Camera Permission',
      status.toString(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueGrey,
      colorText: Colors.white,
    );
    debugPrint('Camera permission status: $status');
  }

  void onViewAll() => debugPrint("View All clicked");
}