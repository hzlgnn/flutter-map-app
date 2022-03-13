import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:map_app/core/core.dart';
import 'package:map_app/ui/home.dart';
import 'package:map_app/ui/login.dart';
import 'package:provider/provider.dart';

void main() {
  group('Authentication Kontrol ', () {
    // await Firebase.initializeApp();
    AuthController controller = AuthController();
    Get.put(controller);

    expect(controller.token, "");
    TextEditingController inputvalue1 = new TextEditingController();
    controller.emailController.text = "Test";
    controller.passwordController.text = "Togg";
    //controller.passwordController.value = "Togg" as TextEditingValue;

    controller.signInWithUsernameAndPassword();
    print(controller.token);
    print("hey");
    print(controller.pinList);
    print("hey");
    // expect(controller.pinList.length, "");
//      TextEditingValue s = TextEditingValue("Test");
    // expect(controller.emailController.value, 'Test');
  });
}
