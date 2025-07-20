class ActivityLogModel {
  final int id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String type;

  ActivityLogModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });

  factory ActivityLogModel.fromJson(Map<String,dynamic> json){
    return ActivityLogModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      timestamp: DateTime.now(),
      type: ['Walking', 'Running', 'Cycling'][json['id'] % 3],
    );
  }
}