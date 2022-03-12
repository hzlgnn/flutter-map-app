import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/core/models/markers.dart';

import '../core/services/favourite_contoller.dart';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class PinInfo extends StatefulWidget {
  var isShowInfo;

  var currentPin;

  PinInfo({
    required this.isShowInfo,
    required this.currentPin,
  });
  @override
  _PinInfoState createState() =>
      _PinInfoState(isShowInfo: isShowInfo, currentPin: currentPin);
}

class _PinInfoState extends State<PinInfo> {
  final FavouriteController favController = Get.find();

  late bool isShowInfo;
  Pin? currentPin;
  _PinInfoState({
    required this.isShowInfo,
    required this.currentPin,
  });

  @override
  Widget build(BuildContext context) {
    return (isShowInfo)
        ? Positioned(
            left: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: AnimatedOpacity(
              curve: Curves.easeInOut,
              opacity: isShowInfo ? 0.8 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentPin!.name.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(currentPin!.website),
                          ],
                        ),

                        (currentPin!.open_now) ? Text("OPEN") : Text("CLOSED"),
                        //Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.star,
                            size: 40,
                            color:
                                favController.favouritePins.contains(currentPin)
                                    ? Colors.red
                                    : Colors.black,
                          ),
                          onPressed: () {
                            favController.add(currentPin!);
                            setState(() {});
                            print("pressed");
                          },
                        ),
                      ]),
                ),
              ),
            ),
          )
        : Container();
  }
}
