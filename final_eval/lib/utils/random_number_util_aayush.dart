import 'dart:math';

class RandomNumberUtil {
  /// Generates a pseudo-random number between [min] and [max].
  static int generatePseudoRandomNumber(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1); // Random integer in range [min, max]
  }

  /// Generates a list of random bytes.
  static List<int> generateRandomBytes(int length) {
    final random = Random.secure();
    return List<int>.generate(length, (_) => random.nextInt(256)); // Random byte array
  }
}
