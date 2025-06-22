import 'package:flutter/material.dart';
import 'package:smart_parking/access_log.dart';
import 'package:smart_parking/intro_page.dart';
import 'package:smart_parking/slotstatus.dart';
import 'package:smart_parking/app_information.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      appBar: AppBar(
        title: const Text("Smart Parking Assistant"),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 122, 124, 122),
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                'lib/images/smartparking.png',
                fit: BoxFit.contain,
                height: 48,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IntroPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Slot Status Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SlotStatusScreen()),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 22, 91, 152),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "🅿️ Slot Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // Access Log Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccessLog()),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 102, 9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "📜 Slot Access Log",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),
            // App Info Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppInformation()),
                );
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 177, 43, 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "ℹ️ App Information",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
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
