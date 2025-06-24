import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SlotStatusScreen extends StatefulWidget {
  const SlotStatusScreen({Key? key}) : super(key: key);

  @override
  State<SlotStatusScreen> createState() => _SlotStatusScreenState();
}

class _SlotStatusScreenState extends State<SlotStatusScreen> {
  String slotStatus = 'Loading...';

  // ✅ ESP32 local IP address
  final String esp32IP = 'http://172.20.10.3';

  @override
  void initState() {
    super.initState();
    fetchSlotStatus();
  }

  Future<void> fetchSlotStatus() async {
    try {
      final response = await http.get(Uri.parse('$esp32IP/slotStatus'));

      if (response.statusCode == 200) {
        final value = response.body.trim();
        setState(() {
          if (value == '1') {
            slotStatus = 'Occupied'; // 🔴 All 4 slots full
          } else if (value == '0') {
            slotStatus = 'Free'; // 🟢 At least 1 slot free
          } else {
            slotStatus = 'Invalid response';
          }
        });
      } else {
        setState(() {
          slotStatus = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        slotStatus = 'Error: Could not connect';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slot Status"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFF222222),
      body: Center(
        child: Container(
          height: 200,
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:
                slotStatus == 'Occupied' ? Colors.red[700] : Colors.green[600],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              slotStatus,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchSlotStatus,
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh, color: Colors.black),
      ),
    );
  }
}
