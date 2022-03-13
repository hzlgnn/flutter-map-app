import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:map_app/constants/constant.dart';
import 'package:map_app/core/core.dart';
import 'package:map_app/ui/favourites.dart';
import '../components/components.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final AuthController authController = AuthController.to;
  final FavouriteController favController = Get.find();
  final controller = MapController(
    location: LatLng(40.952867, 29.093025),
  );

  List<Pin>? currentPinList;
  Pin? currentPin;
  final markers = [];
  MapTransformer? mp;
  bool isShowInfo = false;

  void _onDoubleTap() {
    controller.zoom += 0.5;
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;
    if (scaleDiff > 0) {
      controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  Widget _buildMarkerWidget(Offset pos, Color color, Pin p) {
    return Positioned(
      left: pos.dx - 16,
      top: pos.dy - 16,
      width: 50,
      height: 50,
      child: IconButton(
        highlightColor: Colors.blue,
        icon: Icon(Icons.location_on, color: color),
        onPressed: () async {
          setState(() {
            currentPin = p;
            isShowInfo = true;
          });
        },
      ),
    );
  }

  Widget _pinInfo() {
    return Positioned(
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
                      GestureDetector(
                        child: Text(
                          currentPin!.website,
                          style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () async => await canLaunch(currentPin!.website)
                            ? await launch(currentPin!.website)
                            : throw 'Something bad happend',
                      ),
                    ],
                  ),
                  (currentPin!.open_now)
                      ? const Text("OPEN")
                      : const Text("CLOSED"),
                  IconButton(
                    icon: Icon(
                      (favController.favouritePins.contains(currentPin))
                          ? Icons.star
                          : Icons.star_border,
                      size: 40,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (favController.favouritePins.contains(currentPin)) {
                        favController.remove(currentPin!);
                      } else {
                        favController.add(currentPin!);
                      }
                      setState(() {});
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: const Text('Map Demo'),
      ),
      body: Center(
        child: MapLayoutBuilder(
            controller: controller,
            builder: (context, transformer) {
              mp ??= transformer;
              if (authController.pinList != null && currentPinList == null) {
                currentPinList = authController.pinList;
                for (var pin in currentPinList!) {
                  markers.add(LatLng(pin.lat, pin.lon));
                }
              }

              List<Widget> markerWidgets = <Widget>[];
              if (currentPinList != null) {
                for (int i = 0; i < markers.length; ++i) {
                  markerWidgets.add(_buildMarkerWidget(
                      transformer.fromLatLngToXYCoords(markers[i]),
                      Colors.red,
                      currentPinList![i]));
                }
              }

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onDoubleTap: _onDoubleTap,
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
                onTapUp: (details) {
                  setState(() {
                    isShowInfo = false;
                  });
                },
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final delta = event.scrollDelta;

                      controller.zoom -= delta.dy / 1000.0;
                      setState(() {});
                    }
                  },
                  child: Stack(
                    children: [
                      Map(
                        controller: controller,
                        builder: (context, x, y, z) {
                          //Google Maps
                          final url =
                              'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                          //final darkUrl =
                          //    'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i$z!2i$x!3i$y!4i256!2m3!1e0!2sm!3i556279080!3m17!2sen-US!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcC52Om9uLHMuZTpsfHAudjpvZmZ8cC5zOi0xMDAscy5lOmwudC5mfHAuczozNnxwLmM6I2ZmMDAwMDAwfHAubDo0MHxwLnY6b2ZmLHMuZTpsLnQuc3xwLnY6b2ZmfHAuYzojZmYwMDAwMDB8cC5sOjE2LHMuZTpsLml8cC52Om9mZixzLnQ6MXxzLmU6Zy5mfHAuYzojZmYwMDAwMDB8cC5sOjIwLHMudDoxfHMuZTpnLnN8cC5jOiNmZjAwMDAwMHxwLmw6MTd8cC53OjEuMixzLnQ6NXxzLmU6Z3xwLmM6I2ZmMDAwMDAwfHAubDoyMCxzLnQ6NXxzLmU6Zy5mfHAuYzojZmY0ZDYwNTkscy50OjV8cy5lOmcuc3xwLmM6I2ZmNGQ2MDU5LHMudDo4MnxzLmU6Zy5mfHAuYzojZmY0ZDYwNTkscy50OjJ8cy5lOmd8cC5sOjIxLHMudDoyfHMuZTpnLmZ8cC5jOiNmZjRkNjA1OSxzLnQ6MnxzLmU6Zy5zfHAuYzojZmY0ZDYwNTkscy50OjN8cy5lOmd8cC52Om9ufHAuYzojZmY3ZjhkODkscy50OjN8cy5lOmcuZnxwLmM6I2ZmN2Y4ZDg5LHMudDo0OXxzLmU6Zy5mfHAuYzojZmY3ZjhkODl8cC5sOjE3LHMudDo0OXxzLmU6Zy5zfHAuYzojZmY3ZjhkODl8cC5sOjI5fHAudzowLjIscy50OjUwfHMuZTpnfHAuYzojZmYwMDAwMDB8cC5sOjE4LHMudDo1MHxzLmU6Zy5mfHAuYzojZmY3ZjhkODkscy50OjUwfHMuZTpnLnN8cC5jOiNmZjdmOGQ4OSxzLnQ6NTF8cy5lOmd8cC5jOiNmZjAwMDAwMHxwLmw6MTYscy50OjUxfHMuZTpnLmZ8cC5jOiNmZjdmOGQ4OSxzLnQ6NTF8cy5lOmcuc3xwLmM6I2ZmN2Y4ZDg5LHMudDo0fHMuZTpnfHAuYzojZmYwMDAwMDB8cC5sOjE5LHMudDo2fHAuYzojZmYyYjM2Mzh8cC52Om9uLHMudDo2fHMuZTpnfHAuYzojZmYyYjM2Mzh8cC5sOjE3LHMudDo2fHMuZTpnLmZ8cC5jOiNmZjI0MjgyYixzLnQ6NnxzLmU6Zy5zfHAuYzojZmYyNDI4MmIscy50OjZ8cy5lOmx8cC52Om9mZixzLnQ6NnxzLmU6bC50fHAudjpvZmYscy50OjZ8cy5lOmwudC5mfHAudjpvZmYscy50OjZ8cy5lOmwudC5zfHAudjpvZmYscy50OjZ8cy5lOmwuaXxwLnY6b2Zm!4e0&key=AIzaSyAOqYYyBbtXQEtcHG7hwAwyCPQSYidG8yU&token=31440';

                          return CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.fitWidth,
                          );
                        },
                      ),
                      ...markerWidgets,
                      Positioned(
                        top: 20,
                        right: 20,
                        child: PrimaryButton(
                          key: Key('Favourites'),
                          labelText: 'Favourites',
                          onPressed: () {
                            //print(controller.center.latitude);
                            //print(controller.center.longitude);
                            Global.analytics.logEvent(
                              name: 'Go to Fav ',
                            );
                            Get.to(() => Favourites());
                          },
                        ),
                      ),
                      (currentPin != null)
                          ? (isShowInfo)
                              ? _pinInfo()
                              : Container()
                          : Container(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
