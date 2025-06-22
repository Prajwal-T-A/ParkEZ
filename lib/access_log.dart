import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccessLog extends StatefulWidget {
  const AccessLog({super.key});

  @override
  State<AccessLog> createState() => _AccessLogState();
}

class _AccessLogState extends State<AccessLog> {
  List<Map<String, dynamic>> accessData = [];

  Future<void> fetchLogs() async {
    try {
      final response = await http.get(Uri.parse(
          "http://172.20.10.3/accessLogs"));
      if (response.statusCode == 200) {
        final List<dynamic> logs = json.decode(response.body);
        setState(() {
          accessData = logs
              .map<Map<String, dynamic>>(
                  (log) => Map<String, dynamic>.from(log))
              .toList();
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text("Access Log"),
        backgroundColor: const Color.fromARGB(221, 46, 204, 59),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C3E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Time",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text("Status",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: accessData.length,
                  itemBuilder: (context, index) {
                    final log = accessData[index];
                    final isGranted = log["status"] == "Access Granted";
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(log["time"],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          Text(log["status"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isGranted ? Colors.green : Colors.red,
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
