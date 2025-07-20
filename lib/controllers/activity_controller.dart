import 'package:get/get.dart';
import '../models/activity_log_model.dart';
import '../services/api_service.dart';


class ActivityController extends GetxController {
  final ApiService _apiService = ApiService();

  RxList<ActivityLogModel> activities = <ActivityLogModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  int currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  Future<void> loadActivities({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      activities.clear();
      hasMore.value = true;
    }

    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      List<ActivityLogModel> newActivities = await _apiService.getActivityLogs(page: currentPage);

      if (newActivities.isNotEmpty) {
        activities.addAll(newActivities);
        currentPage++;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load activities: $e');
    } finally {
      isLoading.value = false;
    }
  }
}