import 'dart:convert';
import 'package:crypto/crypto.dart';

class SHA256Util {
  /// Hashes a given [input] string using SHA-256.
  static String hashString(String input) {
    final bytes = utf8.encode(input); // Convert input string to bytes
    final digest = sha256.convert(bytes); // Perform SHA-256 hashing
    return digest.toString(); // Convert the hash to a readable string
  }

  /// Hashes a given [input] byte array using SHA-256.
  static String hashBytes(List<int> input) {
    final digest = sha256.convert(input); // Perform SHA-256 hashing
    return digest.toString(); // Convert the hash to a readable string
  }
}
