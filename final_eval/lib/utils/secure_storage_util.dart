import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtil {
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Key used for storing the value in the secure storage
  static const String _key = 'secure_data_key';

  /// Store data securely in the KeyStore or Keychain
  static Future<void> storeData(String data) async {
    try {
      await _secureStorage.write(key: _key, value: data);
      print("Data stored successfully!");
    } catch (e) {
      print("Error storing data: $e");
    }
  }

  /// Fetch data securely from the KeyStore or Keychain
  static Future<String?> fetchData() async {
    try {
      final value = await _secureStorage.read(key: _key);
      return value;
    } catch (e) {
      print("Error fetching data: $e");
      return null;
    }
  }

  /// Delete data securely from the KeyStore or Keychain
  static Future<void> deleteData() async {
    try {
      await _secureStorage.delete(key: _key);
      print("Data deleted successfully!");
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  /// Check if data exists
  static Future<bool> doesDataExist() async {
    try {
      final value = await _secureStorage.read(key: _key);
      return value != null;
    } catch (e) {
      print("Error checking if data exists: $e");
      return false;
    }
  }
}
