import 'package:geolocator/geolocator.dart';
import 'package:get_user_location/app/locator.dart';
import 'package:get_user_location/services/LocationService/location_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel<String> {
  final _locationService = locator<LocationService>();
  double lat = 0.0;
  double long = 0.0;
  late Position pos;
  void position() async {
    pos = await _locationService.determinePosition();
    lat = pos.latitude;
    long = pos.longitude;
    // lat = pos.then((value) => value.latitude) as double;
    // long = pos.then((value) => value.longitude) as double;
    notifyListeners();
  }

  Future<String> getFutureAddress() async {
    return await _locationService.getAddress();
  }

  @override
  Future<String> futureToRun() => getFutureAddress();
}
