import 'dart:developer';
import 'dart:js_interop';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:healthcare/screens/update_appoinment_screen.dart';
import 'package:intl/intl.dart';

class regesteredSchedule extends StatefulWidget {
  const regesteredSchedule({super.key});

  @override
  State<regesteredSchedule> createState() => _regesteredScheduleState();
}

class _regesteredScheduleState extends State<regesteredSchedule> {
  late DatabaseReference _appointmentsRef;
  List<Map<String, dynamic>> appointmentsData = [];
  DataSnapshot? dataSnapshot;
  @override
  void initState() {
    super.initState();
    _appointmentsRef = FirebaseDatabase.instance.ref().child('appointment');
    _fetchAppointmentsData();
  }

  Future<void> _fetchAppointmentsData() async {
    try {
      DatabaseEvent event = await _appointmentsRef.once();
      // DataSnapshot dataSnapshot = event.snapshot;
      dataSnapshot = event.snapshot;

      print("DataSnapshot: ${dataSnapshot!.value}");

      if (dataSnapshot!.value != null) {
        setState(() {
          appointmentsData = (dataSnapshot!.value as Map<String, dynamic>)
              .entries
              .map<Map<String, dynamic>>(
                  (entry) => {'id': entry.key, ...entry.value})
              .toList();
        });
      }
    } catch (error) {
      print("Error fetching appointments data: $error");
    }
  }

  void _updateAppointment(data, date, time) {
    Map<String, dynamic> appointmentData = data;

    int index =
        appointmentsData.indexWhere((a) => a['id'] == appointmentData['id']);

    // update local data
    setState(() {
      appointmentsData[index]['date'] = date;
      appointmentsData[index]['time'] = time;
      log("id sekarang : ${appointmentsData[index]['id']}");
    });

    // update firebase
    _appointmentsRef.child(appointmentData['id']).update({
      'date': date,
      'time': time,
    }).then((_) {
      print('Appointment updated successfully!');
    }).catchError((error) {
      print('Error updating appointment in Firebase: $error');
    });
  }

  void _deleteAppointment(data) {
    Map<String, dynamic> appointmentData = data;

    int index =
        appointmentsData.indexWhere((a) => a['id'] == appointmentData['id']);

    // update local data
    setState(() {
      log("id sekarang : ${appointmentsData[index]['id']}");
    });

    // update firebase
    _appointmentsRef.child(appointmentData['id'].toString()).remove().then((_) {
      print('Appointment deleted successfully!');
    }).catchError((error) {
      print('Error deleting appointment in Firebase: $error');
    });
  }

  void onAppointmentUpdated(
      Map<String, dynamic> snapshot, String newDate, String newTime) {
    _updateAppointment(snapshot, newDate, newTime);
  }

  void onAppointmentDeleted(Map<String, dynamic> snapshot) {
    _deleteAppointment(snapshot);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Doctor",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            for (var appointmentData in appointmentsData)
              buildAppointmentItem(appointmentData),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildAppointmentItem(Map<String, dynamic> snapshot) {
    print("Appointment ID: ${snapshot['id']}");
    String time = snapshot['time']?.toString() ?? 'N/A';
    String date = snapshot['date'] != null
        ? DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(snapshot['date'].toString()))
        : 'N/A';
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Dr. Angela",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text("Therapist"),
                trailing: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("images/dokter1.jpg"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  height: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 5),
                      Text(
                        time,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Confirmed",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text(
                                "Are you sure you want to cancel this appointment?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // Close the confirmation dialog
                                },
                                child: Text("No"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Remove data from Firebase
                                  // String appointmentId = snapshot['id'];
                                  // log("id : $appointmentId");
                                  // _appointmentsRef
                                  //     .child(appointmentId)
                                  //     .remove()
                                  //     .then((_) {
                                  //   setState(() {});
                                  //   print('Appointment canceled successfully!');
                                  //   Navigator.pop(
                                  //       context); // Close the confirmation dialog
                                  // }).catchError((error) {
                                  //   print(
                                  //       'Error canceling appointment: $error');
                                  //   Navigator.pop(
                                  //       context); // Close the confirmation dialog
                                  // });
                                  // String appointmentId = snapshot['id'];
                                  // log(snapshot.toString());

                                  Map<dynamic, dynamic> values = dataSnapshot!
                                      .value as Map<dynamic, dynamic>;
                                  log(values.keys.first.toString());
                                  _appointmentsRef
                                      .child(values.keys.first.toString())
                                      .remove()
                                      .then((_) {
                                    print('Appointment deleted successfully!');
                                    Navigator.pop(context);
                                  }).catchError((error) {
                                    print(
                                        'Error deleting appointment in Firebase: $error');
                                  });
                                },
                                child: Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF4F6FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Map<String, dynamic> appointmentData = snapshot;
                      if (snapshot != null) {
                        NavigateToUpdateScreen.navigate(
                          context,
                          appointmentData,
                          (String newDate, String newTime) {
                            onAppointmentUpdated(
                                appointmentData, newDate, newTime);
                          },
                        );
                      } else {
                        // Handle case where snapshot is null
                        print("Error: Snapshot is null");
                      }
                    },
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFD4F280),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Reschedule",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// class UpdateAppointment extends StatefulWidget {
//   final String initialDate;
//   final String initialTime;
//   final Function(String, String) onAppointmentUpdated;

//   const UpdateAppointment({
//     Key? key,
//     required this.initialDate,
//     required this.initialTime,
//     required this.onAppointmentUpdated,
//   }) : super(key: key);

//   @override
//   State<UpdateAppointment> createState() => _UpdateAppointmentState(
//         initialDate: initialDate,
//         initialTime: initialTime,
//       );
// }

// class _UpdateAppointmentState extends State<UpdateAppointment> {
//   late DatabaseReference _appointmentsRef;

//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();

//   _UpdateAppointmentState({
//     required String initialDate,
//     required String initialTime,
//   }) {
//     _dateController.text = initialDate;
//     _timeController.text = initialTime;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _appointmentsRef = FirebaseDatabase.instance.ref().child("appointment");
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         _dateController.text = picked.toString().split(" ")[0];
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     TimeOfDay? selectedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (selectedTime != null) {
//       print("Selected Time: ${selectedTime.format(context)}");
//       setState(() {
//         _timeController.text = selectedTime.format(context);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Appointment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _dateController,
//               decoration: InputDecoration(
//                 labelText: 'Date',
//                 filled: true,
//                 prefixIcon: Icon(Icons.calendar_today),
//               ),
//               readOnly: true,
//               onTap: () {
//                 _selectDate(context);
//               },
//               keyboardType: TextInputType.datetime,
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _timeController,
//               decoration: InputDecoration(
//                 labelText: 'Time',
//                 filled: true,
//                 prefixIcon: Icon(Icons.access_time),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.schedule),
//                   onPressed: () {
//                     _selectTime(context);
//                   },
//                 ),
//               ),
//               readOnly: true,
//               onTap: () {
//                 _selectTime(context);
//               },
//               keyboardType: TextInputType.text,
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 if (_dateController.text.isNotEmpty &&
//                     _timeController.text.isNotEmpty) {
//                   widget.onAppointmentUpdated(
//                       _dateController.text, _timeController.text);
//                   Navigator.pop(context);
//                 } else {
//                   print("Date/Time is empty");
//                 }
//               },
//               child: Text('Save Appointment'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Container(
//   padding: EdgeInsets.symmetric(vertical: 5),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(10),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black12,
//         blurRadius: 4,
//         spreadRadius: 2,
//       ),
//     ],
//   ),
//   child: SizedBox(
//     width: MediaQuery.of(context).size.width,
//     child: Column(
//       children: [
//         ListTile(
//           title: Text(
//             "Dr. Doctor Name",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text("Therapist"),
//           trailing: CircleAvatar(
//             radius: 25,
//             backgroundImage: AssetImage("images/doctor1.jpg"),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Divider(
//             thickness: 1,
//             height: 20,
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_month,
//                   color: Colors.black54,
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   appointmentData['date'] ?? '',
//                   style: TextStyle(
//                     color: Colors.black54,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(
//                   Icons.access_time_filled,
//                   color: Colors.black54,
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   appointmentData['time'] ?? '',
//                   style: TextStyle(
//                     color: Colors.black54,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Text(
//                   "Confirmed",
//                   style: TextStyle(
//                     color: Colors.black54,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 width: 150,
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFF4F6FA),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 width: 150,
//                 padding: EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF7165D6),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "Reschedule",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 10),
//       ],
//     ),
//   ),
// )
