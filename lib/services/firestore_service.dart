import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ฟังก์ชันดึงข้อมูล memo ของผู้ใช้
  Stream<List<Memo>> getUserMemos(String username) {
    return _db
        .collection('user_memo')
        .doc(username)
        .collection('memo')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Memo.fromMap(doc.data())).toList());
  }
}

class Memo {
  final String subject;
  final double money;
  final String provider;
  final DateTime dueDate;

  Memo(
      {required this.subject,
      required this.money,
      required this.provider,
      required this.dueDate});

  factory Memo.fromMap(Map<String, dynamic> data) {
    return Memo(
      subject: data['subject'],
      money: (data['money'] is int)
          ? (data['money'] as int).toDouble()
          : data['money'] as double,
      provider: data['provider'],
      dueDate: (data['duedate'] as Timestamp).toDate(),
    );
  }
}
