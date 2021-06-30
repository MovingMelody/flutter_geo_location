import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked_annotations.dart';

@LazySingleton()
class LocationService {
  // List<double> points = [];
  String _address = "";
  late Position _position;
  String get actualaddress => _address;

  Future<Position> determinePosition() async {
    print("getting latitude and longitude");
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      // desiredAccuracy: LocationAccuracy.high,
      // forceAndroidLocationManager: true
    );
  }

  Future<String> getAddress() async {
    try {
      _position = await determinePosition();
      print(_position);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _position.latitude, _position.longitude);
      // List<Placemark> placemarks2 = await placemarkFromCoordinates(13.6293, 79.4056);
      Placemark place = placemarks[0];
      // _address =
      //     "name :  ${place.name},City : ${place.locality}, District : ${place.subAdministrativeArea}, postalCode :  ${place.postalCode}, country : ${place.country}";
      // _address +=
      //     "\n \n street : ${place.street},  subLocality: ${place.subLocality} ,State: ${place.administrativeArea}, isoCountryCode : ${place.isoCountryCode} ";
      // print(address);
      _address =
          " ${place.street} , ${place.name}, ${place.locality} ,  ${place.thoroughfare} , ${place.subLocality} , ${place.subAdministrativeArea} , ${place.postalCode} , ${place.administrativeArea} , ${place.country}";
      return _address;
    } catch (e) {
      print(e);
    }
    return _address;
  }
}
