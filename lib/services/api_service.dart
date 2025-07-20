import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity_log_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<ActivityLogModel>> getActivityLogs({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts?_page=$page&_limit=10'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ActivityLogModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load activity logs');
      }
    } catch (e) {
      print('API Error: $e');
      return [];
    }
  }
}