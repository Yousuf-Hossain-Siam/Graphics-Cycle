import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart'; // Adjust path as needed

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'debug_camera_fab',
        onPressed: () => controller.debugCameraStatus(),
        child: const Icon(Icons.bug_report),
        tooltip: 'Debug camera permission',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopCards(),
            const SizedBox(height: 24),
            _buildSectionHeader(),
            const SizedBox(height: 12),
            _buildActivityList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
        ),
      ),
      title: const Text(
        "Dashboard",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTopCards() {
    return Row(
      children: [
        _quickActionCard(
          "Camera Scan",
          Icons.camera_enhance_outlined,
          Colors.black,
          onTap: () => controller.pickImageFromCamera(), // Link to controller
        ),
        const SizedBox(width: 12),
        _quickActionCard("Import Image", Icons.image_outlined, Colors.teal),
        const SizedBox(width: 12),
        _quickActionCard("Cloud Files", Icons.cloud_upload_outlined, Colors.blueAccent),
      ],
    );
  }

  Widget _quickActionCard(String title, IconData icon, Color color, {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: NetworkImage('https://www.transparenttextures.com/patterns/asfalt-dark.png'),
              opacity: 0.1,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Recent Activity",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: controller.onViewAll,
          child: const Text("View All"),
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.recentActivities.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = controller.recentActivities[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _buildFilePreview(item.type),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text("${item.time}  •  ${item.size}", style: const TextStyle(fontSize: 12)),
                trailing: const Icon(Icons.more_vert),
              ),
            );
          },
        ));
  }

  Widget _buildFilePreview(String type) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const Center(child: Icon(Icons.description, color: Colors.orange)),
          CircleAvatar(
            radius: 8,
            backgroundColor: type == "pdf" ? Colors.red : Colors.blue,
            child: Icon(
              type == "pdf" ? Icons.picture_as_pdf : Icons.image,
              size: 10,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}