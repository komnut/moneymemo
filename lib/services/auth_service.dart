import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ตรวจสอบสถานะผู้ใช้ (มีการล็อกอินอยู่หรือไม่)
  Stream<User?> get userChanges => _auth.authStateChanges();

  // สมัครสมาชิกด้วย Email & Password
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Register Error: $e');
      return null;
    }
  }

  // ล็อกอินด้วย Email & Password
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  // ออกจากระบบ
  Future<void> logout() async {
    await _auth.signOut();
  }
}
