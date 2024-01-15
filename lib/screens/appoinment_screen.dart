import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  final String name;
  final int imageIndex;
  final int doctorIndex;

  AppointmentScreen(
      {required this.name,
      required this.imageIndex,
      required this.doctorIndex});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late int imageIndex;
  late int doctorIndex;

  @override
  void initState() {
    imageIndex = widget.imageIndex;
    doctorIndex = widget.doctorIndex;
    super.initState();
  }

  int index = 0;
  List imgs = [
    "dokter1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  List reviewimg = [
    "cz.jpg",
    "larry.jpg",
    "dasha.jpg",
    "elon.jpg",
  ];

  List reviewname = [
    "Raden",
    "Aliando",
    "Salma",
    "Doge",
  ];

  List about = [
    "Seorang psikologi klinis terkemuka dalam bidang psikologi klinis selama lebih dari 20 tahun,terlibat dalam penelitian terkait trauma dan penyembuhan.",
    "Seorang Neuropsikolog yang Ahli dalam memahami kaitan antara fungsi otak dan perilaku. Memiliki gelar doktor dalam Neuropsikologi, berkontribusi pada studi-studi mengenai kognisi.",
    "Seorang Psikolog Anak yang memiliki Dedikasi pada kesejahteraan mental anak selama lebih dari 15 tahun. Memiliki sertifikasi dalam Psikologi Anak, bekerja aktif dalam penelitian dan pencegahan masalah mental pada anak.",
    "Seorang Psikoterapis yang menyediakan terapi psikologis untuk individu dan keluarga selama lebih dari 10 tahun. Terlatih dalam berbagai pendekatan terapi, memegang sertifikasi dalam Psikoterapi Integratif.",
  ];

  List review = [
    "dokternya ramah sekali",
    "nyaman diajak konsultasi apalagi tentang mental",
    "sangat professional dalam konsultasi",
    "dokter yang sangat sabar dan baik. nyaman ngob",
  ];

  // final DatabaseReference = FirebaseDatabase.instance.ref("appointment");

  final DatabaseReference _appointmentsRef =
      FirebaseDatabase.instance.ref().child("appointment");
  // date picker
  final TextEditingController _dateController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025));
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  // time picker
  final TextEditingController _timeController = TextEditingController();
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
      backgroundColor: Color(0xFFD4F280),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 28,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage("images/${imgs[imageIndex]}"),
                              ),
                              SizedBox(height: 15),
                              Text(
                                widget.name,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Therapist",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD4F280),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD4F280),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.chat_bubble_text_fill,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "About Doctor",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 5),
                        Text(
                          about[doctorIndex],
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Reviews",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "(124)",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  color: Color(0xFFD4F280),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 160,
                          // width: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(10),
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
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage(
                                              "images/${reviewimg[index]}"),
                                        ),
                                        title: Text(
                                          reviewname[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text("1 day ago"),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text(
                                              "4.9",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          review[index],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.location_on,
                              color: Color(0xFFD4F280),
                              size: 30,
                            ),
                          ),
                          title: Text(
                            "Heartcare Medical Center, Semarang",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text("address line of the medical center"),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                              labelText: 'Date',
                              filled: true,
                              prefixIcon: Icon(Icons.calendar_today),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              )),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Time",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
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
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectTime(context);
                          },
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Consultation price",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "\$100",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () async {
                // final appointmentRef = _appointmentsRef.push();
                // appointmentRef.set({
                //   'date': _dateController.text.toString(),
                //   'time': _timeController.text.toString(),
                // });
                final appointmentRef = _appointmentsRef.push();

                // Tambahkan ID ke data
                appointmentRef.set({
                  'date': _dateController.text,
                  'time': _timeController.text,
                });

                // clean the controller
                _dateController.clear();
                _timeController.clear();
                //for Dismiss the keyboard after adding items
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Color(0xFFD4F280),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Book Appointment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
