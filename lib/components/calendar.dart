import 'package:flutter/material.dart';
import 'package:sdla/components/container.dart';
import 'package:sdla/constants/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ShadowContainer(
          child: TableCalendar(
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: kSemiBoldTextStyle.copyWith(fontSize: 18)),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: DateTime.now(),
      )),
    );
  }
}
