import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_memo/screens/main_screen.dart';
import 'package:money_memo/screens/signup_screen.dart';
import 'package:money_memo/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>(
      create: (_) => AuthService().userChanges,
      initialData: null,
      child: MaterialApp(
        home: AuthWrapper(),
      ),
    );
  }
}

// ตรวจสอบว่าให้ไปหน้าล็อกอินหรือหน้า MainScreen
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context); // รับค่าจาก StreamProvider

    print('User status: $user'); // ตรวจสอบว่าค่า User ที่ได้เป็น null หรือไม่

    if (user != null) {
      return MainScreen(
          username: user.email ?? 'Unknown'); // ถ้ามีผู้ใช้ล็อกอินแล้ว
    } else {
      return SignUpScreen(); // ถ้าไม่มีผู้ใช้ให้ไปที่หน้า LoginScreฑen
    }
  }
}




// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:money_memo/screens/main_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MainScreen(username: "komnut.w"),
//     );
//   }
// }
