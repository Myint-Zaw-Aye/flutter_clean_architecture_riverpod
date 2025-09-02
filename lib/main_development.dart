
import 'package:flutter/material.dart';
import 'main.dart' as runner;
import 'core/config/flavour_manager.dart';
Future<void> main() async {
  // Ensure that plugin services are initialized so that `rootBundle` is available.
  WidgetsFlutterBinding.ensureInitialized();
  await FlavorManager.instance?.init(Flavor.development);
  runner.main();
}