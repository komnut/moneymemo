import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ฟังก์ชันดึงข้อมูล memo ของผู้ใช้
  Stream<List<Memo>> getUserMemos(String username) {
    return FirebaseFirestore.instance
        .collection('user_memo')
        .doc(username)
        .collection('memo')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Memo.fromFirestore(doc.data(), doc.id))
            .toList());
  }
}

class Memo {
  final String id; // เพิ่มฟิลด์ id
  final String subject;
  final double money;
  final String provider;
  final DateTime dueDate;

  Memo({
    required this.id, // รับค่า id ใน constructor
    required this.subject,
    required this.money,
    required this.provider,
    required this.dueDate,
  });

  // แปลงข้อมูลจาก Firestore เป็น Memo
  factory Memo.fromFirestore(Map<String, dynamic> data, String id) {
    return Memo(
      id: id, // ตั้งค่า id จาก Firestore
      subject: data['subject'] ?? '',
      money: (data['money'] ?? 0).toDouble(),
      provider: data['provider'] ?? '',
      dueDate: (data['duedate'] as Timestamp).toDate(),
    );
  }
}
