import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_memo/widgets/appbar.dart';

class FormScreen extends StatefulWidget {
  final String username; // รับ username เข้ามา

  const FormScreen({super.key, required this.username});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dueDateController = TextEditingController();

  // ตัวแปรเก็บค่าที่ผู้ใช้กรอก
  String _subject = '';
  double _money = 0.0;
  String _provider = '';
  DateTime _dueDate = DateTime.now();

  // ฟังก์ชันบันทึกข้อมูลลง Firestore
  Future<void> _saveMemo() async {
    final memoData = {
      'subject': _subject,
      'money': _money,
      'provider': _provider,
      'duedate': Timestamp.fromDate(_dueDate),
    };

    try {
      await FirebaseFirestore.instance
          .collection('user_memo')
          .doc(widget.username) // ระบุ username เป็น document ID
          .collection('memo')
          .add(memoData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Memo saved successfully!')),
      );

      Navigator.pop(context); // กลับไปหน้าก่อนหน้า
    } catch (e) {
      print('Error saving memo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save memo!')),
      );
    }
  }

  // ฟังก์ชันเพื่อแสดง DatePicker
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
        _dueDateController.text =
            "${_dueDate.toLocal()}".split(' ')[0]; // แสดงวันที่ใน TextField
      });
    }
  }

  // สร้าง UI ของฟอร์ม
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'Add New Memo'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
                onSaved: (value) => _subject = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount (฿)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                onSaved: (value) => _money = double.parse(value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Provider'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a provider';
                  }
                  return null;
                },
                onSaved: (value) => _provider = value!,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _dueDateController,
                decoration: const InputDecoration(
                  labelText: 'Due Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true, // ทำให้ไม่สามารถแก้ไขได้
                onTap: () =>
                    _selectDueDate(context), // แสดง DatePicker เมื่อคลิก
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveMemo(); // บันทึกข้อมูลเมื่อกด Save
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
