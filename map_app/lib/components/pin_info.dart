import 'package:flutter/material.dart';
import 'package:map_app/core/models/markers.dart';

Widget pinInfo(BuildContext context, bool isShowInfo, Pin marker) {
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
                            marker.name.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(marker.website),
                        ],
                      ),

                      (marker.open_now) ? Text("OPEN") : Text("CLOSED"),
                      //Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.star,
                          size: 40,
                        ),
                        onPressed: () {
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
