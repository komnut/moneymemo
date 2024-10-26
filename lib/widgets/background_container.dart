import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter, // ปรับทิศทางให้ไล่จากบนลงล่าง
          colors: [
            Color(0xFFC8E6C9), // สีเริ่มต้น (เหมือน AppBar)
            Color(0xFF9FE2BF), // สีปลายทางที่เข้ากับธีมมากขึ้น
          ],
          stops: [0.3, 1.0], // ปรับการกระจายสี
        ),
      ),
      child: child,
    );
  }
}
