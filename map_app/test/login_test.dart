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

//createHomeScreen()
Widget createHomeScreen() => ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: MaterialApp(
        home: Login(),
      ),
    );
void main() {
  group('Giriş Ekranı ', () {
    Get.put(AuthController());
    Get.put(FavouriteController());
    testWidgets('Giriş ekranı olması gereken text kontrolleri',
        (WidgetTester tester) async {
      // await Firebase.initializeApp();
      await tester.pumpWidget(createHomeScreen());
      // Create the Finders.
      final titleFinder = find.text('Login to your account!');
      final usernameFinder = find.text('User name');
      final passwordFinder = find.text('User Password');
      final signinFinder = find.text('SIGN IN');

      expect(titleFinder, findsOneWidget);
      expect(usernameFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
      expect(signinFinder, findsOneWidget);

      final clickUserName = find.byKey(new Key('User name'));
      final clickPassword = find.byKey(new Key('User Password'));
      final clicksignIn = find.byKey(new Key('Sign in'));
      await tester.tap(find.byKey(new Key('User name')).first);
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(clickUserName, 'Test');

      await tester.pump(Duration(milliseconds: 400));
      await tester.tap(find.byKey(new Key('User Password')).first);
      await tester.pumpAndSettle(Duration(seconds: 10));
      await tester.enterText(clickPassword, 'Togg');

      //await tester.tap(clicksignIn);
      //await tester.pumpAndSettle(Duration(seconds: 1));
      //await tester.pump(Duration(milliseconds: 400));
      //await tester.pumpAndSettle();
    });
  });
}
