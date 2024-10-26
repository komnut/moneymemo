import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_memo/screens/form.dart';
import 'package:money_memo/widgets/appbar.dart';
import 'package:money_memo/widgets/cardmain.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ทำให้ Flutter รอ async code ก่อนเริ่มแอป
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Money Memo'),
      backgroundColor: const Color.fromARGB(255, 232, 245, 233),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          CardMainWidget(
            subject: 'Electric Bill',
            money: 1500.50,
            provider: 'ABC Bank',
            dueDate: '2024-10-31',
            onEdit: () {
              print('Edit Electric Bill!');
            },
          ),
          CardMainWidget(
            subject: 'Water Bill',
            money: 800.00,
            provider: 'XYZ Bank',
            dueDate: '2024-11-05',
            onEdit: () {
              print('Edit Water Bill!');
            },
          ),
          CardMainWidget(
            subject: 'Internet Bill',
            money: 1200.75,
            provider: 'DEF Bank',
            dueDate: '2024-11-10',
            onEdit: () {
              print('Edit Internet Bill!');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FormScreen(username: "komnut.w")),
          );
        },
        backgroundColor: const Color(0xFF9FE2BF),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
