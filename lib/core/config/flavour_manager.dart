import 'dart:convert';

import 'package:flutter/services.dart';

class FlavorManager {
  static FlavorManager? _instance;
  static FlavorManager? get instance {
    _instance ??= FlavorManager._init();
    return _instance;
  }

  FlavorManager._init();

  Flavor? flavor;
  static Environment? env;
  Future<FlavorManager> init(Flavor flavor) async {
    flavor = flavor;
    final configString = await rootBundle.loadString(
      '${flavor.name}.config.json',
    );
    final configJson = json.decode(configString);
    env = Environment.fromJson(configJson);
    return this;
  }
}

enum Flavor { development, production }

class Environment {
  String? baseUrl;
  String? title;

  Environment({this.baseUrl, this.title});

  Environment.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'] as String?;
    title = json['title'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseUrl'] = baseUrl;
    data['title'] = title;
    return data;
  }
}
