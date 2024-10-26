import 'package:flutter/material.dart';

class CardMainWidget extends StatelessWidget {
  final String subject;
  final double money;
  final String provider;
  final String dueDate;
  final VoidCallback onEdit;

  const CardMainWidget({
    super.key,
    required this.subject,
    required this.money,
    required this.provider,
    required this.dueDate,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit, // กดเพื่อเปิดฟอร์มแก้ไข
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // แถวที่ 1: subject (ซ้าย) และ money (ขวา)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${money.toStringAsFixed(2)} ฿',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // แถวที่ 2: provider
                Text(
                  'Provider: $provider',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                // แถวที่ 3: due date
                Text(
                  'Due Date: $dueDate',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
