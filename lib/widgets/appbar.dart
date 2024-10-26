import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;

  const AppbarWidget({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
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
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      centerTitle: false,
      elevation: 2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
