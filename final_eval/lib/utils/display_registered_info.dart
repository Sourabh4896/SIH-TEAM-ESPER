import 'package:flutter/material.dart';

class DisplayRegisteredInfoPage extends StatelessWidget {
  final String publicKey;
  final String deviceId;
  final String signedData;

  DisplayRegisteredInfoPage({
    required this.publicKey,
    required this.deviceId,
    required this.signedData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registered Information"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Registration Details",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Device ID:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            SelectableText(
              deviceId,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 20),
            Text(
              "Public Key:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            SelectableText(
              publicKey,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            SizedBox(height: 20),
            Text(
              "Signed Data:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            SelectableText(
              signedData,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous page
                },
                child: Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
