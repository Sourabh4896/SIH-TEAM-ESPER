// public_key_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For secure storage
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON

class PublicKeyPage extends StatefulWidget {
  @override
  _PublicKeyPageState createState() => _PublicKeyPageState();
}

class _PublicKeyPageState extends State<PublicKeyPage> {
  final _secureStorage = FlutterSecureStorage();
  String _serverPublicKey = 'No public key received yet';

  @override
  void initState() {
    super.initState();
    _fetchPublicKey();
  }

  // Fetch the public key from the server
  Future<void> _fetchPublicKey() async {
    try {
      final response = await http.get(Uri.parse('http://yourserverurl.com/public_key'));
      
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String publicKey = responseData['publicKey']; // Assuming server returns { "publicKey": "<key>" }
        
        // Store the public key securely in the KeyStore
        await _secureStorage.write(key: 'server_public_key', value: publicKey);
        
        setState(() {
          _serverPublicKey = publicKey;
        });
      } else {
        setState(() {
          _serverPublicKey = 'Failed to fetch public key';
        });
      }
    } catch (e) {
      setState(() {
        _serverPublicKey = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Key from Server'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Server Public Key:'),
            SizedBox(height: 10),
            Text(
              _serverPublicKey,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the success screen
                Navigator.pop(context);
              },
              child: Text('Back to Success Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
