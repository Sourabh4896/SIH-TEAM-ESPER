import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceIdUtil {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Fetches the unique device ID based on the platform.
  static Future<String> getDeviceUniqueId() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        return androidInfo.id ?? "Unknown"; // Returns Android device ID (e.g., IMEI or hardware ID)
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor ?? "Unknown"; // Returns iOS device unique identifier
      } else {
        return "Unsupported Platform";
      }
    } catch (e) {
      return "Error fetching device ID: $e";
    }
  }
}
