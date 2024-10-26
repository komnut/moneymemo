import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF9FE2BF),
      automaticallyImplyLeading: false,
      title: const Text(
        'Money Memo',
        style: TextStyle(
          fontFamily: 'Inter Tight',
          color: Colors.white,
          fontSize: 22,
          letterSpacing: 0.0,
        ),
      ),
      actions: const [],
      centerTitle: false,
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
