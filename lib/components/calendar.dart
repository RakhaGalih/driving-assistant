import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdla/components/container.dart';
import 'package:sdla/constants/constant.dart';
import 'package:sdla/services/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedDateProvider selectedDateProvider =
        Provider.of<SelectedDateProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ShadowContainer(
          child: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: kSemiBoldTextStyle.copyWith(fontSize: 18),
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: selectedDateProvider.selectedDay,
            selectedDayPredicate: (day) {
              return isSameDay(selectedDateProvider.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              selectedDateProvider.setSelectedDay(selectedDay);
              print('Selected day: $selectedDay');
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Selected day: ${selectedDateProvider.selectedDay.toLocal()}'
                .split(' ')[0],
            style: kSemiBoldTextStyle.copyWith(fontSize: 18),
          ),
        ],
      )),
    );
  }
}
