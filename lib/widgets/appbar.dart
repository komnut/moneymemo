import 'package:flutter/material.dart';
import 'package:money_memo/screens/signup_screen.dart';
import 'package:money_memo/services/auth_service.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // เพิ่มตัวแปรนี้เพื่อแสดงปุ่ม Back

  const AppbarWidget({
    super.key,
    required this.title,
    this.showBackButton = false, // ค่าเริ่มต้นเป็น false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton // ถ้า showBackButton เป็น true ให้แสดงปุ่ม Back
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFC8E6C9),
              Color(0xFF9FE2BF),
            ],
          ),
        ),
      ),
      title: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter Tight',
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await AuthService().logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
      ],
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
