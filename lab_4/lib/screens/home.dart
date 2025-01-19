import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/exam.dart';
import '../helpers/storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Exam> exams = [];
  DateTime _selectedDay = DateTime.now();

  final _subjectController = TextEditingController();
  final _locationController = TextEditingController();
  TimeOfDay _time = const TimeOfDay(hour: 9, minute: 0); // Default time

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  Future<void> _loadExams() async {
    final loadedExams = await StorageHelper.loadExams();
    setState(() {
      exams = loadedExams;
    });
  }

  Future<void> _addExam() async {
    // Show a dialog for the user to input exam details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exam'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            Row(
              children: [
                Text("Time: ${_time.format(context)}"),
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () async {
                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                    if (picked != null && picked != _time) {
                      setState(() {
                        _time = picked;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Create new exam and save
              if (_subjectController.text.isNotEmpty &&
                  _locationController.text.isNotEmpty) {
                final newExam = Exam(
                  subject: _subjectController.text,
                  date: DateTime(_selectedDay.year, _selectedDay.month,
                      _selectedDay.day, _time.hour, _time.minute),
                  location: _locationController.text,
                );
                setState(() {
                  exams.add(newExam);
                });
                StorageHelper.saveExams(exams); // Save the exam
                Navigator.of(context).pop(); // Close dialog
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  List<Exam> _getExamsForDay(DateTime day) {
    return exams.where((exam) => isSameDay(exam.date, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 1, 1),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, _) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: _getExamsForDay(_selectedDay).map((exam) {
                return ListTile(
                  title: Text(exam.subject),
                  subtitle: Text('${exam.date} - ${exam.location}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExam,
        child: Icon(Icons.add),
      ),
    );
  }
}
