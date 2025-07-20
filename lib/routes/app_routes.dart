import 'package:daily_health_tracker/views/activity_logs_screen.dart';
import 'package:daily_health_tracker/views/dashboard_screen.dart';
import 'package:daily_health_tracker/views/graph_screen.dart';
import 'package:daily_health_tracker/views/login_screen.dart';
import 'package:daily_health_tracker/views/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String graph = '/graph';
  static const String activities = '/activities';

  static List<GetPage> Pages = [
    GetPage(name: splash, page: ()=> SplashScreen()),
    GetPage(name: login, page: ()=> LoginScreen()),
    GetPage(name: dashboard, page: ()=> DashboardScreen()),
    GetPage(name: graph, page: ()=> GraphScreen()),
    GetPage(name: activities, page: ()=> ActivityLogsScreen()),
  ];
}