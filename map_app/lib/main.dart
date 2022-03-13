import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/constants/constant.dart';
import 'package:map_app/core/services/auth_controller.dart';
import 'package:map_app/core/services/favourite_contoller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/app_routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main(List<String> arguments) async {
/*  final FirebaseAnalytics analytics = FirebaseAnalytics();
  analytics.logLogin();
  analytics.logEvent(
      name: 'win_race', parameters: {'race_type': 0, 'loser': 'not me'});*/

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Global.analytics.logLogin();
  Global.analytics.logEvent(
    name: 'main',
  );
  //crashlytics deneme
  //FirebaseCrashlytics.instance.crash();

  var prefs = await SharedPreferences.getInstance();
  final String? name = prefs.getString('name');

  Get.put<AuthController>(AuthController());
  Get.put<FavouriteController>(FavouriteController());
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
