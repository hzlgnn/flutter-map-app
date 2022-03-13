import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/constants/constant.dart';
import 'package:map_app/core/services/favourite_contoller.dart';
import '../components/components.dart';

// FavouriteController classı ile state management yapılmıştır
// Sayafada liste ve back buton bulunmaktadır
class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final FavouriteController favController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: const Text('Map Demo'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: favController.favouritePins.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: _favouriteList(i),
              );
            },
          ),
          _backToHome()
        ],
      ),
    );
  }

  Widget _favouriteList(int i) {
    return Row(
      children: [
        Text(favController.favouritePins[i].name.toString()),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Background color
            onPrimary: Colors.white, // Text Color
          ),
          onPressed: () {
            favController.remove(favController.favouritePins[i]);
            setState(() {});
          },
          child: const Text(
            "Kaldır",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }

  // Home'a dönmek için kullanılmaktadır.
  Widget _backToHome() {
    return Positioned(
      bottom: 20,
      right: 20,
      left: 20,
      child: PrimaryButton(
        key: Key('Back to Map'),
        labelText: 'Back to Map',
        onPressed: () {
          Global.analytics.logEvent(
            name: 'Back to map ',
          );
          Get.back();
        },
      ),
    );
  }
}
