import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/health_data_model.dart';

class GraphScreen extends StatelessWidget {
  final GraphController controller = Get.put(GraphController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Statistics'),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Steps Chart
              _buildChartCard(
                'Steps - Last 7 Days',
                _buildStepsChart(),
                Colors.blue,
              ).animate().fadeIn(),

              SizedBox(height: 20),

              // Distance Chart
              _buildChartCard(
                'Distance - Last 7 Days',
                _buildDistanceChart(),
                Colors.green,
              ).animate().fadeIn(delay: 200.ms),

              SizedBox(height: 20),

              // Calories Chart
              _buildChartCard(
                'Calories - Last 7 Days',
                _buildCaloriesChart(),
                Colors.orange,
              ).animate().fadeIn(delay: 400.ms),

              SizedBox(height: 20),

              // Weekly Summary
              _buildWeeklySummary().animate().fadeIn(delay: 600.ms),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildChartCard(String title, Widget chart, Color color) {
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
                  width: 20,
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${(value / 1000).toStringAsFixed(0)}k',
                  style: TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < days.length) {
                  return Text(
                    days[value.toInt()],
                    style: TextStyle(fontSize: 10),
                  );
                }
                return Text('');
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 12000,
        lineBarsData: [
          LineChartBarData(
            spots: controller.healthData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.steps.toDouble());
            }).toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.blue,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceChart() {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toStringAsFixed(1)}km',
                  style: TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < days.length) {
                  return Text(
                    days[value.toInt()],
                    style: TextStyle(fontSize: 10),
                  );
                }
                return Text('');
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: 10,
        barGroups: controller.healthData.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.distance,
                color: Colors.green,
                width: 20,
                borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCaloriesChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                if (value.toInt() >= 0 && value.toInt() < days.length) {
                  return Text(
                    days[value.toInt()],
                    style: TextStyle(fontSize: 10),
                  );
                }
                return Text('');
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 600,
        lineBarsData: [
          LineChartBarData(
            spots: controller.healthData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.calories.toDouble());
            }).toList(),
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withOpacity(0.3),
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.orange,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySummary() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weekly Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Total Steps',
                  '${controller.totalSteps.value}',
                  Icons.directions_walk,
                  Colors.blue,
                ),
                _buildSummaryItem(
                  'Avg Distance',
                  '${controller.avgDistance.value.toStringAsFixed(1)} km',
                  Icons.location_on,
                  Colors.green,
                ),
                _buildSummaryItem(
                  'Total Calories',
                  '${controller.totalCalories.value}',
                  Icons.local_fire_department,
                  Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

class GraphController extends GetxController {
  RxList<HealthDataModel> healthData = <HealthDataModel>[].obs;
  RxBool isLoading = false.obs;
  RxInt totalSteps = 0.obs;
  RxDouble avgDistance = 0.0.obs;
  RxInt totalCalories = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadHealthData();
  }

  void loadHealthData() {
    isLoading.value = true;

    // Simulate network delay
    Future.delayed(Duration(seconds: 1), () {
      // Generate mock data for the last 7 days
      final now = DateTime.now();
      final mockData = List.generate(7, (index) {
        final date = now.subtract(Duration(days: 6 - index));
        return HealthDataModel(
          date: date,
          steps: 7000 + (index * 500) + (index % 2 == 0 ? 1000 : 0),
          distance: 5.0 + (index * 0.5) + (index % 2 == 0 ? 1.0 : 0),
          calories: 300 + (index * 30) + (index % 2 == 0 ? 50 : 0),
        );
      });

      healthData.assignAll(mockData);
      _calculateSummary();
      isLoading.value = false;
    });
  }

  void _calculateSummary() {
    totalSteps.value = healthData.fold(0, (sum, item) => sum + item.steps);
    avgDistance.value = healthData.fold(0.0, (sum, item) => sum + item.distance) / healthData.length;
    totalCalories.value = healthData.fold(0, (sum, item) => sum + item.calories);
  }
}