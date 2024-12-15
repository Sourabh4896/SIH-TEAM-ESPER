import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Import secure storage package

class FetchPublicKeyScreen extends StatefulWidget {
  @override
  _FetchPublicKeyScreenState createState() => _FetchPublicKeyScreenState();
}

class _FetchPublicKeyScreenState extends State<FetchPublicKeyScreen> {
  String publicKey = '';
  bool isLoading = false;
  final FlutterSecureStorage _storage = FlutterSecureStorage(); // Secure storage instance

  // Function to fetch public key from API
  Future<void> fetchPublicKey() async {
    setState(() {
      isLoading = true; // Show loading indicator when fetching data
    });

    final url = Uri.parse('https://yourserver.com/api/getPublicKey'); // Replace with your API URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          publicKey = data['publicKey']; // Assuming the API returns a JSON with a 'publicKey' field
          isLoading = false;
        });

        // Save the public key securely using Keystore
        await _storage.write(key: 'publicKey', value: publicKey);
        print("Public key stored securely in Keystore/Keychain.");
      } else {
        // Handle error if API fails
        setState(() {
          publicKey = 'Error fetching public key';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        publicKey = 'Failed to fetch public key: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPublicKey(); // Fetch public key automatically when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Key Received'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.key,
                color: Colors.blue,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Public Key Fetching...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                isLoading ? 'Fetching public key...' : 'Public Key: $publicKey',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Manually fetch the public key if needed
                  fetchPublicKey();
                },
                child: Text("Fetch Public Key"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Go back to the SuccessScreen
                  Navigator.pop(context);
                },
                child: Text("Back to Success Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
