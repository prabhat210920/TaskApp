import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  DateCard({required this.date, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? const Color(0xFFffa85c).withOpacity(0.6) : Colors.white,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${date.day}',
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(height: 4.0),
            Text(
              _weekdayToString(date.weekday),
              style: const TextStyle(
                  fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Text(
              _monthToString(date.month),
              style: const TextStyle(
                  fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  String _weekdayToString(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  String _monthToString(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}