import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class CountdownTimer extends StatelessWidget {
  final TimerController controller = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Next Activity Reminder',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  Obx(() => Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.withOpacity(0.1),
                      border: Border.all(color: Colors.purple, width: 3),
                    ),
                    child: Center(
                      child: Text(
                        controller.formattedTime.value,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  )),
                  SizedBox(height: 16),
                  Obx(() => Text(
                    controller.isRunning.value
                        ? 'Time until next walk reminder'
                        : 'Timer paused',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  )),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => ElevatedButton.icon(
                        onPressed: controller.isRunning.value
                            ? controller.pauseTimer
                            : controller.startTimer,
                        icon: Icon(
                          controller.isRunning.value
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        label: Text(
                          controller.isRunning.value ? 'Pause' : 'Start',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )),
                      ElevatedButton.icon(
                        onPressed: controller.resetTimer,
                        icon: Icon(Icons.refresh, color: Colors.white),
                        label: Text('Reset', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerController extends GetxController {
  RxInt remainingSeconds = 600.obs; // 10 minutes in seconds
  RxBool isRunning = false.obs;
  RxString formattedTime = '10:00'.obs;
  Timer? _timer;
  static const int initialSeconds = 600; // 10 minutes

  @override
  void onInit() {
    super.onInit();
    updateFormattedTime();
    startTimer(); // Auto-start the timer
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    if (!isRunning.value) {
      isRunning.value = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (remainingSeconds.value > 0) {
          remainingSeconds.value--;
          updateFormattedTime();
        } else {
          // Timer finished
          _onTimerFinished();
        }
      });
    }
  }

  void pauseTimer() {
    if (isRunning.value) {
      isRunning.value = false;
      _timer?.cancel();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    isRunning.value = false;
    remainingSeconds.value = initialSeconds;
    updateFormattedTime();
  }

  void updateFormattedTime() {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    formattedTime.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onTimerFinished() {
    _timer?.cancel();
    isRunning.value = false;

    // Show notification
    Get.snackbar(
      'Time\'s Up!',
      'Time for your next activity!',
      backgroundColor: Colors.purple,
      colorText: Colors.white,
      icon: Icon(Icons.notifications, color: Colors.white),
      duration: Duration(seconds: 3),
    );

    // Auto-reset for next cycle
    Future.delayed(Duration(seconds: 2), () {
      resetTimer();
      startTimer();
    });
  }
}