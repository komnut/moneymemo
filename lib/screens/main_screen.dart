import 'package:flutter/material.dart';
import 'package:money_memo/screens/form.dart';
import 'package:money_memo/screens/edit_form.dart'; // นำเข้า EditFormScreen
import 'package:money_memo/services/firestore_service.dart';
import 'package:money_memo/widgets/appbar.dart';
import 'package:money_memo/widgets/cardmain.dart';
import 'package:money_memo/widgets/background_container.dart';

class MainScreen extends StatelessWidget {
  final String username;
  final String email; // เพิ่มตัวแปรสำหรับ email

  const MainScreen({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'Welcome, $username',
        showLogoutButton: true,
        showBackButton: false,
      ), // แสดงชื่อผู้ใช้
      body: Column(
        children: [
          // แสดงข้อความทักทายและยอดรวม
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              color: const Color(0xFFFFE7D1), // ตั้งสีพื้นหลัง
              padding: const EdgeInsets.fromLTRB(
                  0, 5, 20, 5), // เพิ่ม padding ข้างใน
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Hi, $email',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StreamBuilder<List<Memo>>(
                        stream: FirestoreService().getUserMemos(username),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }

                          final memos = snapshot.data;

                          // ตรวจสอบว่ามี memo หรือไม่
                          if (memos == null || memos.isEmpty) {
                            return const Text(
                              'Your asset: 0.00 ฿',
                              style: TextStyle(fontSize: 18),
                            );
                          }

                          // คำนวณยอดรวม
                          double totalAmount =
                              memos.fold(0, (sum, memo) => sum + memo.money);

                          return Text(
                            'Your asset: ${totalAmount.toStringAsFixed(2)} ฿',
                            style: const TextStyle(fontSize: 18),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 0), // เพิ่มช่องว่างระหว่างข้อความและ List
          Expanded(
            child: StreamBuilder<List<Memo>>(
              stream: FirestoreService().getUserMemos(username),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final memos = snapshot.data;

                if (memos == null || memos.isEmpty) {
                  return const Center(
                    child: Text(
                      'No memos available.\nAdd a new memo by clicking the + button.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return BackgroundContainer(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(5.0),
                    itemCount: memos.length,
                    itemBuilder: (context, index) {
                      final memo = memos[index];
                      return CardMainWidget(
                        subject: memo.subject,
                        money: memo.money,
                        provider: memo.provider,
                        dueDate: memo.dueDate.toString().split(' ')[0],
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditFormScreen(
                                username: username,
                                memoId: snapshot.data![index].id,
                                subject: memo.subject,
                                money: memo.money,
                                provider: memo.provider,
                                dueDate: memo.dueDate,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(username: username),
            ),
          );
        },
        backgroundColor: const Color(0xFF9FE2BF),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
