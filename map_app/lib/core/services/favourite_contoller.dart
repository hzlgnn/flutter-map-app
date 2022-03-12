import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:map_app/core/models/markers.dart';

class FavouriteController extends GetxController {
  String? query;
  List<Pin> favouritePins = <Pin>[];

  /// NOTE: Not used since 0.0.2.
  //LibrarySearch type = LibrarySearch.albums;

  void add(Pin pin) {
    favouritePins.add(pin);
    this.update();
  }

  void remove(Pin pin) {
    favouritePins.remove(pin);
    this.update();
  }
}
