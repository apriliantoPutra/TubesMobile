import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class ChatSample extends StatelessWidget {
  final String messages;

  ChatSample({required this.messages});

   List doctor = [
    "doctor1.jpg",
    "doctor2.jpg",
    "doctor3.jpg",
    "doctor4.jpg",
    "doctor1.jpg",
    "doctor2.jpg",
  ];
  List Patient = [
    "Dr. Richard",
    "Dr. Boyke",
    "Dr. Faris",
    "Dr. Ganjar",
    "Dr. Prabowo",
    "Dr. Anis",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: ClipPath(
            clipper: UpperNipMessageClipper(MessageType.receive),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFE1E1E2),
              ),
              child: Text(
                messages,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        // Container(
        //   alignment: Alignment.centerRight,
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 20, left: 80),
        //     child: ClipPath(
        //       clipper: LowerNipMessageClipper(MessageType.send),
        //       child: Container(
        //         padding:
        //             EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
        //         decoration: BoxDecoration(
        //           color: Color(0xFFD4F280),
        //         ),
        //         child: Text(
        //           "Hello Doctor, Are you there?",
        //           style: TextStyle(fontSize: 16, color: Colors.white),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}