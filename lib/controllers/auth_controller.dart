import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoading.value = true;
    bool isSignedIn = await _authService.isSignedIn();
    if (isSignedIn) {
      Get.offNamed(AppRoutes.dashboard);
    } else {
      Get.offNamed(AppRoutes.login);
    }
    isLoading.value = false;
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      UserModel? result = await _authService.signInWithGoogle();
      if (result != null) {
        user.value = result;
        Get.offNamed(AppRoutes.dashboard);
      } else {
        Get.snackbar('Error', 'Failed to sign in with Google');
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign in failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    user.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}