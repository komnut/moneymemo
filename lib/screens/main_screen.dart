import 'package:flutter/material.dart';
import 'package:money_memo/screens/form.dart';
import 'package:money_memo/services/firestore_service.dart';
import 'package:money_memo/widgets/appbar.dart';
import 'package:money_memo/widgets/cardmain.dart';
import 'package:money_memo/widgets/background_container.dart'; // ใช้ Widget ใหม่

class MainScreen extends StatelessWidget {
  final String username;

  const MainScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Money Memo'),
      body: StreamBuilder<List<Memo>>(
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
                    // แก้ไข memo ตามที่ต้องการ
                  },
                );
              },
            ),
          );
        },
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
