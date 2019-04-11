import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSimCountryCode {
  static const MethodChannel _channel =
      const MethodChannel('flutter_sim_country_code');

  static Future<String> get simCountryCode async {
    final String version = await _channel.invokeMethod('getSimCountryCode');
    return version;
  }
}
