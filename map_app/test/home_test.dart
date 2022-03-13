import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
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
  group('Komponent Testleri - Anasayfa ', () {
    Get.put(AuthController());
    Get.put(FavouriteController());
    testWidgets('Scroll özelliğini test ediyoruz', (tester) async {
      await tester
          .pumpWidget(createHomeScreen()); //pumpWidget metodu widgeti ekrana
      //expect(find.text('Sayı 0'),
      //    findsOneWidget); // Ekranda "Sayı 0" elemanını buluyoruz
      //await tester.fling(find.byType(ListView), Offset(0, -200),
      //    3000); // ListView komponenetini otomatik kaydırıyoruz
      await tester
          .pumpAndSettle(); // Animasyonun tamamlanması için bekletiyoruz.
      expect(find.text('Login to your account!'),
          findsOneWidget); // Ekranda artık Sayı 0 'in olmadığına emin oluyoruz
    });
  });
}
