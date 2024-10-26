import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title; // รับค่า title เป็น parameter
  final Widget? leading; // รับค่า leading เป็น parameter (optional)

  const AppbarWidget({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF9FE2BF),
      automaticallyImplyLeading: false,
      leading: leading, // ใช้ leading widget ที่ส่งเข้ามา
      title: Text(
        title, // ใช้ title ที่ส่งเข้ามา
        style: const TextStyle(
          fontFamily: 'Inter Tight',
          color: Colors.white,
          fontSize: 22,
          letterSpacing: 0.0,
        ),
      ),
      centerTitle: false,
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
