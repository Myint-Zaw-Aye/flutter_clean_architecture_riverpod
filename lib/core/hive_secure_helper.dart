import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

class HiveSecureHelper {
  static const _keyName = 'flix_secure_key';
  static const _secureStorage = FlutterSecureStorage();

  static Future<Uint8List> getEncryptionKey() async {
    String? encodedKey = await _secureStorage.read(key: _keyName);

    if (encodedKey == null) {
      final key = Hive.generateSecureKey();
      encodedKey = base64UrlEncode(key);
      await _secureStorage.write(key: _keyName, value: encodedKey);
    }

    return base64Url.decode(encodedKey);
  }
}
