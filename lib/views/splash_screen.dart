import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Auto-navigate after splash
    Future.delayed(Duration(seconds: 2), () {
      final authController = Get.find<AuthController>();
      authController.checkLoginStatus();
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade600,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.health_and_safety,
                  size: 60,
                  color: Colors.blue.shade600,
                ),
              ).animate()
                  .scale(duration: Duration(milliseconds: 800))
                  .then()
                  .shimmer(duration: Duration(milliseconds: 1000)),

              SizedBox(height: 30),

              // App Title
              Text(
                'Daily Health Tracker',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ).animate(delay: Duration(milliseconds: 300))
                  .fadeIn(duration: Duration(milliseconds: 800))
                  .slideY(begin: 0.3, end: 0),

              SizedBox(height: 10),

              // Tagline
              Text(
                'Your wellness journey starts here',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 0.5,
                ),
              ).animate(delay: Duration(milliseconds: 600))
                  .fadeIn(duration: Duration(milliseconds: 800))
                  .slideY(begin: 0.3, end: 0),

              SizedBox(height: 50),

              // Loading Indicator
              Container(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ).animate(delay: Duration(milliseconds: 1000))
                  .fadeIn(duration: Duration(milliseconds: 500)),

              SizedBox(height: 20),

              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ).animate(delay: Duration(milliseconds: 1200))
                  .fadeIn(duration: Duration(milliseconds: 500)),
            ],
          ),
        ),
      ),
    );
  }
}