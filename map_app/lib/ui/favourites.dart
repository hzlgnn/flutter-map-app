import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/core/services/favourite_contoller.dart';
import 'package:map_app/ui/home.dart';

import '../components/components.dart';

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
        title: Text('Map Demo'),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
                child: ListView.builder(
              itemCount: favController.favouritePins.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(favController.favouritePins[i].name.toString()),
                      Spacer(),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () {
                          favController.remove(favController.favouritePins[i]);
                          setState(() {});
                        },
                        child: Text(
                          "Kaldır",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            child: PrimaryButton(
              labelText: 'Back to Map',
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
