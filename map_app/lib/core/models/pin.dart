// Model
import 'package:map_app/src/generated/poi.pb.dart';

class Pin {
  final int id;
  final double lat;
  final double lon;
  final String name;
  final bool open_now;
  final String website;

  Pin(
      {required this.id,
      required this.lat,
      required this.lon,
      required this.name,
      required this.open_now,
      required this.website});

  factory Pin.fromMap(Map data) {
    return Pin(
      id: data['id'],
      lat: data['lat'] ?? '',
      lon: data['lon'] ?? '',
      name: data['name'] ?? '',
      open_now: data['open_now'] ?? '',
      website: data['website'] ?? '',
    );
  }
  factory Pin.fromPoiReply(PoiReply data) {
    return Pin(
      id: data.id.toInt(),
      lat: data.lat,
      lon: data.lon,
      name: data.name,
      open_now: data.openNow,
      website: data.website,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lon": lon,
        "name": name,
        "open_now": open_now,
        "website": website
      };
}
