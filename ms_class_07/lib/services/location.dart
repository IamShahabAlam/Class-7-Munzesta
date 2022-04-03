import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

//  LocationPermission permission = await Geolocator.requestPermission();

  // print(position);
  // print(permission);
  // LocationPermission pmission = await Geolocator.checkPermission();

  // await Geolocator.openAppSettings();
  // await Geolocator.openLocationSettings();

      latitude = position.latitude;
      longitude = position.longitude;

    } catch (e) {
      print(e);
    }
  }
}
