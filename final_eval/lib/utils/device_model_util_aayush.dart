import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DeviceModelUtil {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Fetches the model ID of the device.
  static Future<String> getDeviceModelId() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        return androidInfo.model ?? "Unknown"; // Returns Android model
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        return iosInfo.model ?? "Unknown"; // Returns iOS model
      } else {
        return "Unsupported Platform"; // Returns if platform is not supported
      }
    } catch (e) {
      return "Error fetching device model: $e"; // Error handling
    }
  }
}
