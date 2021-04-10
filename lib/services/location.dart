// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class Locator {
  double latitude;
  double longitude;
  //Position position;
  LocationData position;
  Location location;

  Future<void> getCurrentLocation() async {
    location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    await checkServiceAndPermission(_serviceEnabled, _permissionGranted);
    try {
      // position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low, forceAndroidLocationManager: true);
      position = await location.getLocation();
      latitude = position.latitude;
      longitude = position.longitude;
      print(position);
    } on Exception catch (e) {
      print(e);
      await checkServiceAndPermission(_serviceEnabled, _permissionGranted);
    }
  }

  Future checkServiceAndPermission(bool _serviceEnabled, PermissionStatus _permissionGranted) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
