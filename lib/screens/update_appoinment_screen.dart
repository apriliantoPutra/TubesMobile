import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateAppointment extends StatefulWidget {
  final String initialDate;
  final String uId;
  final String initialTime;
  final Function(String, String) onAppointmentUpdated;

  const UpdateAppointment({
   
    required this.initialDate,
    required this.uId,
    required this.initialTime,
    required this.onAppointmentUpdated,
  }) ;

  @override
  State<UpdateAppointment> createState() => _UpdateAppointmentState();
}

class NavigateToUpdateScreen {
  static void navigate(
    BuildContext context,
    Map<String, dynamic> appointment,
    Function(String, String) onAppointmentUpdated,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateAppointment(
          uId: appointment['id'],
          initialDate: appointment['date'],
          initialTime: appointment['time'],
          onAppointmentUpdated: onAppointmentUpdated,
        ),
      ),
    );
  }
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  final DatabaseReference _appointmentsRef =
      FirebaseDatabase.instance.ref().child("appointment");

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = widget.initialDate;
    _timeController.text = widget.initialTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _timeController.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                filled: true,
                prefixIcon: Icon(Icons.access_time),
                suffixIcon: IconButton(
                  icon: Icon(Icons.schedule),
                  onPressed: () {
                    _selectTime(context);
                  },
                ),
              ),
              readOnly: true,
              onTap: () {
                _selectTime(context);
              },
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_dateController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  String appointmentId =
                      widget.uId; // Ganti ini dengan ID yang sesuai
                  _appointmentsRef.child(appointmentId).update({
                    'date': _dateController.text,
                    'time': _timeController.text,
                  }).then((_) {
                    print('Appointment updated successfully!');
                    widget.onAppointmentUpdated(
                        _dateController.text, _timeController.text);
                    Navigator.pop(context);
                  }).catchError((error) {
                    print('Error updating appointment: $error');
                  });
                } else {
                  print("Date/Time is empty");
                }
              },
              child: Text('Save Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
