import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_memo/widgets/appbar.dart';

class EditFormScreen extends StatefulWidget {
  final String username;
  final String memoId;
  final String subject;
  final double money;
  final String provider;
  final DateTime dueDate;

  const EditFormScreen({
    super.key,
    required this.username,
    required this.memoId,
    required this.subject,
    required this.money,
    required this.provider,
    required this.dueDate,
  });

  @override
  _EditFormScreenState createState() => _EditFormScreenState();
}

class _EditFormScreenState extends State<EditFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dueDateController;
  late String _subject;
  late double _money;
  late String _provider;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _subject = widget.subject;
    _money = widget.money;
    _provider = widget.provider;
    _dueDate = widget.dueDate;
    _dueDateController = TextEditingController(
      text: "${_dueDate.toLocal()}".split(' ')[0],
    );
  }

  // ฟังก์ชันอัปเดต Memo ใน Firestore
  Future<void> _updateMemo() async {
    final memoData = {
      'subject': _subject,
      'money': _money,
      'provider': _provider,
      'duedate': Timestamp.fromDate(_dueDate),
    };

    try {
      await FirebaseFirestore.instance
          .collection('user_memo')
          .doc(widget.username)
          .collection('memo')
          .doc(widget.memoId)
          .update(memoData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Memo updated successfully!')),
      );
      Navigator.pop(context); // กลับไปหน้าก่อนหน้า
    } catch (e) {
      print('Error updating memo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update memo!')),
      );
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
        _dueDateController.text = "${_dueDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(
        title: 'Edit Memo',
        showDeleteButton: true,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _subject,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
                onChanged: (value) => _subject = value,
              ),
              TextFormField(
                initialValue: _money.toString(),
                onChanged: (value) {
                  // ตรวจสอบว่าค่าที่ป้อนเข้ามาเป็นอักขระที่ไม่ถูกต้องหรือไม่
                  if (value.isEmpty) {
                    setState(() {
                      _money = 0; // กำหนดค่า money เป็น 0 ถ้าไม่มีข้อมูล
                    });
                    return; // ออกจากฟังก์ชัน
                  }

                  // ลบอักขระที่ไม่จำเป็น เช่น $
                  String sanitizedValue =
                      value.replaceAll(RegExp(r'[^0-9.]'), '');

                  // ตรวจสอบค่าที่ลบแล้วก่อนแปลง
                  if (sanitizedValue.isNotEmpty) {
                    try {
                      double parsedValue = double.parse(sanitizedValue);
                      setState(() {
                        _money = parsedValue; // อัปเดตค่า money
                      });
                    } catch (e) {
                      print(
                          'Invalid input for money: $value'); // แสดงข้อความผิดพลาด
                    }
                  } else {
                    print(
                        'Invalid input for money: $value'); // แสดงข้อความผิดพลาดถ้า sanitizedValue ว่าง
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Amount',
                  errorText: _money == 0
                      ? 'Please enter a valid amount.'
                      : null, // ข้อความผิดพลาด
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              TextFormField(
                initialValue: _provider,
                decoration: const InputDecoration(labelText: 'Provider'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a provider';
                  }
                  return null;
                },
                onChanged: (value) => _provider = value,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _dueDateController,
                decoration: const InputDecoration(
                  labelText: 'Due Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDueDate(context),
              ),
              const SizedBox(height: 20),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFF9FE2BF), // สีเขียวแบบ Bootstrap btn-success
                      foregroundColor: Colors.white, // สีข้อความ (ให้เป็นสีขาว)
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // เพิ่มระยะห่างให้เหมือนปุ่ม Bootstrap
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // ปรับให้มุมมนเล็กน้อย
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateMemo();
                      }
                    },
                    child: const Text('Update', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
