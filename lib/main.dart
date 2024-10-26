import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_memo/widgets/appbar.dart';
import 'package:money_memo/widgets/cardmain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const AppbarWidget(),
        // เปลี่ยนสีพื้นหลังเป็นดำ
        backgroundColor: const Color.fromARGB(255, 232, 245, 233),
        // ListView สำหรับแสดงการ์ดหลายอัน
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            CardMainWidget(
              subject: 'Electric Bill',
              money: 1500.50,
              provider: 'ABC Bank',
              dueDate: '2024-10-31',
              onEdit: () {
                if (kDebugMode) {
                  print('Edit Electric Bill!');
                }
              },
            ),
            CardMainWidget(
              subject: 'Water Bill',
              money: 800.00,
              provider: 'XYZ Bank',
              dueDate: '2024-11-05',
              onEdit: () {
                if (kDebugMode) {
                  print('Edit Water Bill!');
                }
              },
            ),
            CardMainWidget(
              subject: 'Internet Bill',
              money: 1200.75,
              provider: 'DEF Bank',
              dueDate: '2024-11-10',
              onEdit: () {
                if (kDebugMode) {
                  print('Edit Internet Bill!');
                }
              },
            ),
          ],
        ),
        // ปุ่ม FloatingActionButton อยู่ด้านนอกการ์ดทั้งหมด
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Add new bill!');
          },
          backgroundColor: const Color(0xFF9FE2BF),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
