import 'package:flutter/material.dart';
import 'package:healthcare/screens/appoinment_screen.dart';
import 'package:healthcare/screens/settings.screen.dart';

class HomeScreen extends StatelessWidget {
  List psikologi = [
    "Bahagia",
    "Tenang",
    "Sedih",
    "Stress",
    "Gelisah",
  ];

  List imgs = [
    "dokter1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
  ];

  List name = [
    "Dr Angela",
    "Dr Alice",
    "Dr Odette",
    "Dr Gord",
  ];

  List about = [
    "Seorang psikologi klinis terkemuka dalam bidang psikologi klinis selama lebih dari 20 tahun,terlibat dalam penelitian terkait trauma dan penyembuhan.",
    "Seorang Neuropsikolog yang Ahli dalam memahami kaitan antara fungsi otak dan perilaku. Memiliki gelar doktor dalam Neuropsikologi, berkontribusi pada studi-studi mengenai kognisi.",
    "Seorang Psikolog Anak yang memiliki Dedikasi pada kesejahteraan mental anak selama lebih dari 15 tahun. Memiliki sertifikasi dalam Psikologi Anak, bekerja aktif dalam penelitian dan pencegahan masalah mental pada anak.",
    "Seorang Psikoterapis yang menyediakan terapi psikologis untuk individu dan keluarga selama lebih dari 10 tahun. Terlatih dalam berbagai pendekatan terapi, memegang sertifikasi dalam Psikoterapi Integratif.",
  ];

  Map<String, String> moodDescriptions = {
    "Bahagia": "Habiskan waktu dengan orang yang anda cintai.",
    "Tenang": "Rasakan ketenangan, keseimbangan, dan damai.",
    "Sedih":
        "Jangan bersedih,bicaralah dengan teman atau keluarga tentang perasaan anda.",
    "Stress":
        "Wah tenang, atur prioritas dan pecah tugas menjadi bagian - bagian kecil",
    "Gelisah":
        "jangan gelisah, lakukan aktivitas yang dapat membuat anda rileks.",
  };

  Map<String, Color> moodColors = {
    "Bahagia": Colors.yellow,
    "Tenang": Colors.green,
    "Sedih": Colors.blue,
    "Stress": Colors.grey,
    "Gelisah": Colors.lightBlue,
  };

  void showMoodDescription(BuildContext context, String mood) {
    Color backgroundColor = moodColors[mood] ?? Colors.white;
    // Menentukan warna teks berdasarkan kontrast dengan warna latar belakang
    Color textColor =
        backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: moodColors[mood],
          title: Text(
            mood,
            style: TextStyle(color: textColor),
          ),
          content: Text(
            moodDescriptions[mood] ?? "No explanation available.",
            style: TextStyle(color: textColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "images/heartcare.png",
                    height: 75.0,
                    fit: BoxFit.contain,
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("images/barudak.jpg"),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //         padding: EdgeInsets.all(20),
              //         decoration: BoxDecoration(
              //           color: Color(0xFFD4F280),
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black12,
              //               blurRadius: 6,
              //               spreadRadius: 4,
              //             ),
              //           ],
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               padding: EdgeInsets.all(8),
              //               decoration: BoxDecoration(
              //                 color: Colors.white,
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Icon(
              //                 Icons.add,
              //                 color: Color(0xFFD4F280),
              //                 size: 35,
              //               ),
              //             ),
              //             SizedBox(height: 30),
              //             Text(
              //               "Clinic Visit",
              //               style: TextStyle(
              //                 fontSize: 18,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             SizedBox(height: 5),
              //             Text(
              //               "Make an appointment",
              //               style: TextStyle(
              //                 color: Colors.white54,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //         padding: EdgeInsets.all(20),
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.black12,
              //               blurRadius: 6,
              //               spreadRadius: 4,
              //             ),
              //           ],
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               padding: EdgeInsets.all(8),
              //               decoration: BoxDecoration(
              //                 color: Color(0xFFF0EEFA),
              //                 shape: BoxShape.circle,
              //               ),
              //               child: Icon(
              //                 Icons.home_filled,
              //                 color: Color(0xFFD4F280),
              //                 size: 35,
              //               ),
              //             ),
              //             SizedBox(height: 30),
              //             Text(
              //               "Home Visit",
              //               style: TextStyle(
              //                 fontSize: 18,
              //                 color: Colors.black,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             SizedBox(height: 5),
              //             Text(
              //               "Call the doctor home",
              //               style: TextStyle(
              //                 color: Colors.black54,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "How are you today?",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: psikologi.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Tambahkan logika untuk menampilkan penjelasan mood
                        showMoodDescription(context, psikologi[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6FA),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            psikologi[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // // Widget untuk menampilkan penjelasan mood
              // Column(
              //   children: psikologi.map((mood) {
              //     return Container(
              //       margin: EdgeInsets.symmetric(vertical: 10),
              //       child: Text(
              //         "$mood: ${moodDescriptions[mood]}",
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: Colors.black54,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              // ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Popular Doctors",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentScreen(
                              name: name[index],
                              imageIndex: index,
                              doctorIndex: index,
                            ),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                AssetImage("images/${imgs[index]}"),
                          ),
                          Text(
                            index < name.length ? name[index] : '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          const Text(
                            "Therapist",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                "4.9",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
