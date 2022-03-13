import 'package:flutter_test/flutter_test.dart';
import 'package:map_app/core/core.dart';

void main() {
  group('Favoriler Test', () {
    var favorites = FavouriteController();
    test('Favorilere ekleme', () {
      Pin pin = Pin(
          id: 1,
          lat: 40,
          lon: 20,
          name: "Deneme",
          open_now: false,
          website: "www.togg.com");
      favorites.add(pin);
      //expect metodu ile beklediğimiz sonucu kontrol ediyoruz
      expect(favorites.favouritePins.contains(pin), true);
    });

    test('Favorilerden çıkarma', () {
      //Önce ekle sonra çıkart
      Pin pin = Pin(
          id: 1,
          lat: 40,
          lon: 20,
          name: "Deneme",
          open_now: false,
          website: "www.togg.com");

      favorites.add(pin);
      expect(favorites.favouritePins.contains(pin), true);
      favorites.remove(pin);
      expect(favorites.favouritePins.contains(pin), false);
    });
  });
}
