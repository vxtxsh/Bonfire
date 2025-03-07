import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:intl/intl.dart';

import 'my_text_field.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventController _controller = EventController();
  TextEditingController _eventController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Add Event',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextInput(
                  controller: _eventController,
                  label: 'Event',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextInput(
                  controller: _titleController,
                  label: 'Title',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTextInput(
                          controller: _startDateController,
                          label: 'Start Date',
                          onTap: () {
                            _selectDate(context, true);
                          }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomTextInput(
                        controller: _endDateController,
                        label: 'End Date',
                        onTap: () {
                          _selectDate(context, false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CustomTextInput(
                        controller: _startTimeController,
                        label: 'Start Time',
                        onTap: () {
                          _selectTime(context, true);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomTextInput(
                        controller: _endTimeController,
                        label: 'End Time',
                        onTap: () {
                          _selectTime(context, false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomTextInput(
                  controller: _descController,
                  label: 'Description',
                  line: 3,
                ),
              ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  //add event here
                  final event = CalendarEventData(
                    title: _titleController.text,
                    event: _eventController.text,
                    description: _descController.text,
                    date: _startDate,
                    endDate: _endDate,
                    startTime: DateTime(
                      _startDate.year,
                      _startDate.month,
                      _startDate.day,
                      _startTime.hour,
                      _startTime.minute,
                    ),
                    endTime: DateTime(
                      _endDate.year,
                      _endDate.month,
                      _endDate.day,
                      _endTime.hour,
                      _endTime.minute,
                    ),
                  );
                  CalendarControllerProvider.of(context).controller.add(event);
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay initialTime = isStartTime ? _startTime : _endTime;
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
          _startTimeController.text = pickedTime.format(context);
        } else {
          _endTime = pickedTime;
          _endTimeController.text = pickedTime.format(context);
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime initialDate = isStartDate ? _startDate : _endDate;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000), // Set a reasonable start date
      lastDate: DateTime(2100), // Set a reasonable end date
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          _startDateController.text = DateFormat.yMMMd().format(pickedDate);
        } else {
          _endDate = pickedDate;
          _endDateController.text = DateFormat.yMMMd().format(pickedDate);
        }
      });
    }
  }
}
