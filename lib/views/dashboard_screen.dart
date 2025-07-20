import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/countdown_timer.dart';
import '../routes/app_routes.dart';

class DashboardScreen extends GetView<AuthController> {
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => controller.signOut(),
          ),
        ],
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.user.value == null) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Card
              _buildProfileCard().animate().fadeIn().slideX(),

              SizedBox(height: 20),

              // Stats Cards
              _buildStatsGrid().animate().fadeIn(delay: 200.ms),

              SizedBox(height: 20),

              // Countdown Timer
              CountdownTimer().animate().fadeIn(delay: 400.ms),

              SizedBox(height: 20),

              // Quick Actions
              _buildQuickActions().animate().fadeIn(delay: 600.ms),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileCard() {
    final user = controller.user.value!;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: user.photoUrl.isNotEmpty
                  ? CachedNetworkImageProvider(user.photoUrl)
                  : null,
              child: user.photoUrl.isEmpty
                  ? Icon(Icons.person, size: 30)
                  : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  Text(
                    user.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(Icons.health_and_safety, color: Colors.green, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Obx(() => GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.3,
      children: [
        _buildStatCard(
          'Steps Today',
          '${dashboardController.todaySteps.value}',
          Icons.directions_walk,
          Colors.blue,
        ),
        _buildStatCard(
          'Distance',
          '${dashboardController.todayDistance.value.toStringAsFixed(1)} km',
          Icons.location_on,
          Colors.green,
        ),
        _buildStatCard(
          'Calories',
          '${dashboardController.todayCalories.value}',
          Icons.local_fire_department,
          Colors.orange,
        ),
        _buildStatCard(
          'Activities',
          '${dashboardController.todayActivities.value}',
          Icons.fitness_center,
          Colors.purple,
        ),
      ],
    ));
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'View Graphs',
                Icons.bar_chart,
                Colors.blue,
                    () => Get.toNamed(AppRoutes.graph),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                'Activity Logs',
                Icons.list,
                Colors.green,
                    () => Get.toNamed(AppRoutes.activities),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class DashboardController extends GetxController {
  RxInt todaySteps = 8547.obs;
  RxDouble todayDistance = 6.2.obs;
  RxInt todayCalories = 423.obs;
  RxInt todayActivities = 5.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() {
    // Simulate loading data
    // In real app, this would fetch from API or local storage
    todaySteps.value = 8547;
    todayDistance.value = 6.2;
    todayCalories.value = 423;
    todayActivities.value = 5;
  }
}