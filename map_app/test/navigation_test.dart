import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_test/get_test.dart';

void main() {
  getTest(
    "test description",
    widgetTest: (tester) async {
      expect('/', Get.currentRoute);
    },
  );
}
