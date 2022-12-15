import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:loggy/loggy.dart';

class CryptoKit {
  Future<String>? getHash(String text) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      MethodChannel methodChannel =
          const MethodChannel('com.appnoe.flutter-workshop/cryptokit');
      final result =
          await methodChannel.invokeMethod<String>('getHash', {'text': text});
      if (result != null) {
        logDebug('Hash: $result');
        return result;
      } else {
        return 'No hash available';
      }
    } else {
      return 'Runs only on iOS';
    }
  }
}
