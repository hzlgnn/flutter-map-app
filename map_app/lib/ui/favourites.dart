import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/ui/home.dart';

import '../components/components.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
              itemCount: 6,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(i.toString()),
                );
              },
            )),
          ),
          Positioned(
            top: 20,
            right: 20,
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
