import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      return UserModel(
        id: googleUser.id,
        name: googleUser.displayName ?? '',
        email: googleUser.email,
        photoUrl: googleUser.photoUrl ?? '',
      );
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}