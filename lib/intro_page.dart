// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smart_parking/home_page.dart';
import 'package:smart_parking/main.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //background Colour
        backgroundColor: const Color.fromARGB(255, 105, 24, 24),
        body: Center(
            child: Column(
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                'lib/images/smartparking.png',
                height: 350,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            //title
            Text(
              'PARK EZ - Your SmartParking Assistant',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.grey[300],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 60,
            ),

            //subtitles
            const Text(
              'Your Space, Found. Effortless Parking, Every Time.',
              style: TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 70,
            ),

            //start now
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )),
            )
          ],
        )));
  }
}
