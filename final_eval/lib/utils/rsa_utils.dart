import 'package:flutter/material.dart';
import 'package:fast_rsa/fast_rsa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RSA Encryption',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RSAHomePage(),
    );
  }
}

class RSAHomePage extends StatefulWidget {
  @override
  _RSAHomePageState createState() => _RSAHomePageState();
}

class _RSAHomePageState extends State<RSAHomePage> {
  String? publicKey;
  String? privateKey;
  String plainText = '';
  String cipherText = '';
  String decryptedText = '';
  final TextEditingController plainTextController = TextEditingController();
  final TextEditingController cipherTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateKeys();
  }

  // Generate RSA keys
  Future<void> _generateKeys() async {
    try {
      final keys = await RSA.generate(2048);
      setState(() {
        publicKey = keys.publicKey;
        privateKey = keys.privateKey;
      });
    } catch (e) {
      print('Error generating keys: $e');
    }
  }

  // Encrypt the plain text
  Future<void> _encryptText() async {
    if (publicKey == null || plainText.isEmpty) return;

    try {
      final encrypted = await RSA.encryptPKCS1v15(plainText, publicKey!);
      setState(() {
        cipherText = encrypted;
      });
    } catch (e) {
      print('Error encrypting text: $e');
    }
  }

  // Decrypt the cipher text
  Future<void> _decryptText() async {
    if (privateKey == null || cipherText.isEmpty) return;

    try {
      final decrypted = await RSA.decryptPKCS1v15(cipherText, privateKey!);
      setState(() {
        decryptedText = decrypted;
      });
    } catch (e) {
      print('Error decrypting text: $e');
    }
  }

  // Method to get the encrypted data to be sent
  String getEncryptedData() {
    return cipherText;
  }

  // Method to receive encrypted data and decrypt
  void setEncryptedData(String encryptedData) {
    setState(() {
      cipherText = encryptedData;
    });
    _decryptText(); // Decrypt automatically after receiving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSA Encryption/Decryption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: plainTextController,
              decoration: InputDecoration(
                labelText: 'Enter text to encrypt',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                plainText = value;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _encryptText();
              },
              child: Text('Encrypt'),
            ),
            SizedBox(height: 16),
            Text(
              'Encrypted Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(cipherText),
            SizedBox(height: 16),
            TextField(
              controller: cipherTextController,
              decoration: InputDecoration(
                labelText: 'Enter text to decrypt',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                cipherText = value;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _decryptText();
              },
              child: Text('Decrypt'),
            ),
            SizedBox(height: 16),
            Text(
              'Decrypted Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(decryptedText),
            SizedBox(height: 16),
            Divider(),
            Text(
              'Generated Keys:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Public Key:'),
            SelectableText(publicKey ?? 'Generating...'),
            SizedBox(height: 8),
            Text('Private Key:'),
            SelectableText(privateKey ?? 'Generating...'),
          ],
        ),
      ),
    );
  }
}
