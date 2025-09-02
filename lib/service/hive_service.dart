import 'dart:convert';
import 'package:clean_architecture_riverpod/service/hive_secure_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';

mixin class HiveCacheManager {

  static final HiveCacheManager _instance = HiveCacheManager._internal();

  factory HiveCacheManager() => _instance;
  HiveCacheManager._internal();
  
  static const tokenKey = "token";
  static const islogin = "islogin";
  static const asxoxinfo = "asxoxinfo";
  static const profile = 'profile';
  static const themeStatus = 'themeStatus';

  late Box _secureBox;
  late Box _regularBox;

  /// Initialize Hive with encryption
  Future<HiveCacheManager> init() async {
    await Hive.initFlutter();

    final encryptionKey = await HiveSecureHelper.getEncryptionKey();

    _secureBox = await Hive.openBox(
      'secureBox',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    _regularBox = await Hive.openBox('regularBox');
    return this;
  }

  /// Generic setter
  Future<void> setData(String key, dynamic value) async {
    await _regularBox.put(key, value);
  }

  /// Generic getter
  T? getData<T>(String key) => _regularBox.get(key);

  /// String setter/getter
  Future<void> setString(String key, String value) async =>
      await _regularBox.put(key, value);
  String? getString(String key) => _regularBox.get(key);

  /// Bool setter/getter
  Future<void> setBool(String key, bool value) async =>
      await _regularBox.put(key, value);
  bool? getBool(String key) => _regularBox.get(key);

  /// Double setter/getter
  Future<void> setDouble(String key, double value) async =>
      await _regularBox.put(key, value);
  double? getDouble(String key) => _regularBox.get(key);

  /// Save user object
  Future<void> setUser(String key, Map<String, dynamic> user) async {
    final encoded = json.encode(user);
    await _regularBox.put(key, encoded);
  }
  Map<String, dynamic>? getUser(String key) {
    final encoded = _regularBox.get(key);
    if (encoded == null) return null;
    return json.decode(encoded);
  }

  /// Save theme status
  Future<void> setThemeStatus(bool isDark) async =>
      await _regularBox.put('themeStatus', isDark);
  bool? getThemeStatus() => _regularBox.get('themeStatus');

  /// Secure token
  Future<void> saveToken(String? token) async => await _secureBox.put(tokenKey, token);
  String? getToken() => _secureBox.get(tokenKey);
  Future<void> removeToken() async => await _secureBox.delete(tokenKey);

  /// Clear all regular & secure data
  Future<void> clearAllData() async {
    await _regularBox.clear();
    await _secureBox.clear();
  }
}
