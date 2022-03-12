import 'package:get/get.dart';
import 'package:map_app/ui/favourites.dart';
import 'package:map_app/ui/home.dart';
import 'package:map_app/ui/login.dart';
import 'package:map_app/ui/splashScreen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/signin', page: () => Login()),
    GetPage(name: '/home', page: () => HomeUI()),
    GetPage(name: '/favourites', page: () => Favourites()),
  ];
}
