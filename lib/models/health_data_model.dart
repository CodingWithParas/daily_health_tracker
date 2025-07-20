class HealthDataModel {
  final DateTime date;
  final int steps;
  final double distance;
  final int calories;

  HealthDataModel({
    required this.date,
    required this.steps,
    required this.distance,
    required this.calories,
  });

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    return HealthDataModel(
      date: DateTime.parse(json['date']),
      steps: json['steps'] ?? 0,
      distance: json['distance'] ?? 0.0,
      calories: json['calories'] ?? 0,
    );
  }
}