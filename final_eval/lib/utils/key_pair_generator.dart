import 'package:fast_rsa/fast_rsa.dart';
import 'secure_storage_util.dart';  // Import your secure storage utility

Future<Map<String, String>> generateRSAKeyPair() async {
  try {
    // Generate RSA keys
    final keys = await RSA.generate(2048);

    // Store the private key securely in the KeyStore/Keychain
    await SecureStorageUtil.storeData(keys.privateKey);

    // Return the public key (private key is already stored)
    return {
      'publicKey': keys.publicKey,
    };
  } catch (e) {
    print('Error generating keys: $e');
    return {};
  }
}
