import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'SuccessScreen.dart';

class SendingDataScreen extends StatefulWidget {
  final String publicKey;
  final String deviceId;
  final String signedData;

  SendingDataScreen({
    required this.publicKey,
    required this.deviceId,
    required this.signedData,
  });

  @override
  _SendingDataScreenState createState() => _SendingDataScreenState();
}

class _SendingDataScreenState extends State<SendingDataScreen> {
  double progress = 0.0;
  String statusMessage = "Ready to send data.";

  // Send data to server when the user clicks the button
  Future<void> _sendDataToServer() async {
    setState(() {
      statusMessage = 'Sending data to server...';
      progress = 0.5; // Update the progress bar while sending
    });

    final url = Uri.parse('http://10.70.73.218:5000/save_data');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'public_key': widget.publicKey,
        'device_id': widget.deviceId,
        'signed_data': widget.signedData,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        statusMessage = 'Data sent successfully!';
        progress = 1.0; // Update progress to 100% on success
      });

      // After data is sent successfully, navigate to SuccessScreen
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SuccessScreen()),
        );
      });
    } else {
      setState(() {
        statusMessage = 'Failed to send data: ${response.body}';
        progress = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sending Data")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display status message
            Text(
              statusMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Display Public Key, Device ID, and Signed Data
            Text(
              "Public Key: ${widget.publicKey}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              "Device ID: ${widget.deviceId}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Text(
              "Signed Data: ${widget.signedData}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),

            // Progress bar
            AnimatedContainer(
              duration: Duration(seconds: 1),
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Send button
            if (progress == 0.0 || progress < 1.0)
              ElevatedButton(
                onPressed: _sendDataToServer, // Trigger data send when clicked
                child: Text("Send Data to Server"),
              ),

            // Button to return home after successful data send
            if (progress == 1.0)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text("Back to Home"),
              ),
          ],
        ),
      ),
    );
  }
}

