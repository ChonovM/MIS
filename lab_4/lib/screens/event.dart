import 'package:flutter/material.dart';

class EventDetailScreen extends StatefulWidget {
  final DateTime selectedDay;

  EventDetailScreen({required this.selectedDay});

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final TextEditingController locationController = TextEditingController();
  String? eventLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Date: ${widget.selectedDay.toLocal()}'),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  eventLocation = locationController.text;
                });
                Navigator.pop(context, eventLocation);
              },
              child: Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}
