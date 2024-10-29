import 'package:flutter/material.dart';
import 'package:money_memo/screens/signup_screen.dart';
import 'package:money_memo/services/auth_service.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogoutButton;
  final bool showDeleteButton;
  final bool showBackButton;

  const AppbarWidget({
    super.key,
    required this.title,
    this.showLogoutButton = false,
    this.showDeleteButton = false,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // ไม่ใช้ leading อัตโนมัติ
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (showDeleteButton) {
                  _showCancelEditDialog(context);
                } else {
                  Navigator.pop(context);
                }
              },
            )
          : null, // ถ้าไม่ต้องแสดงปุ่ม Back จะเป็น null
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      actions: [
        if (showLogoutButton)
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
        if (showDeleteButton)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
      ],
      elevation: 2,
    );
  }

  // Dialog ยืนยันการยกเลิกใน EditFormScreen
  void _showCancelEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Edit'),
          content: const Text('Are you sure you want to cancel the changes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // ปิด Dialog
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
                Navigator.pop(context); // กลับไปหน้า MainScreen
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  // Dialog ยืนยันการลบ Memo
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Memo'),
          content: const Text('Are you sure you want to delete this memo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // ปิด Dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ปิด Dialog
                Navigator.pop(context); // กลับไปหน้า MainScreen
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
