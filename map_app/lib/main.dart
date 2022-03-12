import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/core/services/auth_controller.dart';
import 'package:map_app/ui/login.dart';
import 'package:map_app/ui/splashScreen.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_routes.dart';

Future<void> main(List<String> arguments) async {
/*  final FirebaseAnalytics analytics = FirebaseAnalytics();
  analytics.logLogin();
  analytics.logEvent(
      name: 'win_race', parameters: {'race_type': 0, 'loser': 'not me'});*/

  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  final String? name = prefs.getString('name');

  Get.put<AuthController>(AuthController());
  //Get.put(configuration);

  runApp(MyPoiApp());
}

class MyPoiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //defaultTransition: Transition.fade,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
