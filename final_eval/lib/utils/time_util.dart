class TimeUtil {
  /// Returns the current time in milliseconds since Unix epoch (January 1, 1970).
  static int getCurrentTimeInMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}
