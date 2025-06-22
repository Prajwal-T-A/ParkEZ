// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AppInformation extends StatelessWidget {
  const AppInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Information"),
          backgroundColor: const Color.fromARGB(255, 60, 174, 32),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 32, 32),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "App Information : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "SMART PARKING ASSISTANT - Secure and Intelligent Parking Access\n\n"
                    "Urban areas face increasing challenges with managing parking, leading to congestion, delays, and inefficiencies.\n\n"
                    "This project offers a smart solution by integrating secure access control, real-time monitoring, and IoT connectivity for smarter parking operations.\n\n"
                    "With features like PIN-based entry, vehicle detection, slot monitoring, and data logging, the system aims to streamline parking access securely and efficiently.\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: "Function of Slot Status : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "The Slot Status feature provides real-time updates on whether the parking slot is occupied or free.\n\n"
                    "A single click on this tile lets users know the current status of the slot via server communication with the ESP32.\n\n"
                    "This enables intelligent parking decisions, avoids confusion, and helps maintain an organized parking flow.\n\n"
                    "Green indicators reflect availability, while red indicates the slot is currently in use.\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              TextSpan(
                text: "Function of Access Log : \n\n",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    "What it is: The Access Log keeps track of all entry attempts, including successful and failed PIN verifications.\n\n"
                    "It logs timestamps and statuses (Access Granted / Access Denied) to ensure transparency and traceability.\n\n"
                    "This feature is essential for security monitoring, audit trails, and identifying unauthorized access attempts.\n\n"
                    "Only the latest few logs are stored to keep the data concise and easy to browse through.\n\n",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ]),
          ),
        )));
  }
}
