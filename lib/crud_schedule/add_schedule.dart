import 'package:flutter/material.dart';

class addSchedule extends StatefulWidget {
  const addSchedule({super.key});

  @override
  State<addSchedule> createState() => _addScheduleState();
}

class _addScheduleState extends State<addSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                  color: Color(0xff368983),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
