import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade800],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.health_and_safety,
                  size: 100,
                  color: Colors.white,
                ).animate().fadeIn().scale(),

                SizedBox(height: 20),

                Text(
                  'Daily Health Tracker',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 200.ms),

                SizedBox(height: 10),

                Text(
                  'Track your daily activities and health',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ).animate().fadeIn(delay: 400.ms),

                SizedBox(height: 50),

                Obx(() => ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.signInWithGoogle,
                  icon: controller.isLoading.value
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : Icon(Icons.login),
                  label: Text(
                    controller.isLoading.value
                        ? 'Signing in...'
                        : 'Sign in with Google',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                )).animate().fadeIn(delay: 600.ms).scale(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}