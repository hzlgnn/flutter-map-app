import 'package:get/get.dart';
import 'package:map_app/constants/constant.dart';
import 'package:map_app/core/models/pin.dart';

class FavouriteController extends GetxController {
  String? query;
  List<Pin> favouritePins = <Pin>[];

  void add(Pin pin) {
    favouritePins.add(pin);
    Global.analytics.logEvent(
      name: 'fav added ' + pin.name,
    );
    this.update();
  }

  void remove(Pin pin) {
    favouritePins.remove(pin);
    Global.analytics.logEvent(
      name: 'fav remove ' + pin.name,
    );
    this.update();
  }
}
