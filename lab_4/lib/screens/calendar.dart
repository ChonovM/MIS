import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<String>> events;
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    events = {};
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      selectedDay = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exam Schedule')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            onDaySelected: _onDaySelected,
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EventDetailScreen(selectedDay: selectedDay),
                ),
              );
            },
            child: Text('Add Event'),
          ),
        ],
      ),
    );
  }
}
