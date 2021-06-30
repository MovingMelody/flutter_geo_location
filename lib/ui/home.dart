import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as locintent;

var location = locintent.Location();
Future _checkGps() async {
  if (!await location.serviceEnabled()) {
    location.requestService();
  }
}

Future<Position> _determinePosition() async {
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
      desiredAccuracy: LocationAccuracy.medium,
      forceAndroidLocationManager: true);
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkGps();
  }

  late String lat = "initially somewhere";
  late String lon = "initially somewhere";
  late String address = "", addressAdditional = "actual address here";
  late Position _position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get user location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Lat : ".toUpperCase() + lat),
              Text("Long : ".toUpperCase() + lon),
              ElevatedButton(
                onPressed: () async {
                  _position = await _determinePosition();
                  print(_position);
                  setState(() {
                    lat = _position.latitude.toString();
                    lon = _position.longitude.toString();
                    print(lat);
                    print(lon);
                  });
                },
                child: Text("1. Get lat and long"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                        _position.latitude, _position.longitude);
                    // List<Placemark> placemarks2 = await placemarkFromCoordinates(13.6293, 79.4056);
                    Placemark place = placemarks[0];
                    setState(() {
                      address =
                          "name :  ${place.name},City : ${place.locality}, District : ${place.subAdministrativeArea}, postalCode :  ${place.postalCode}, country : ${place.country}";
                      addressAdditional =
                          " street : ${place.street},  subLocality: ${place.subLocality} ,State: ${place.administrativeArea}, isoCountryCode : ${place.isoCountryCode} ";
                      print(address);
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("2. Customer readable address"),
              ),
              Center(child: Text(address.toUpperCase())),
              SizedBox(
                height: 30.0,
              ),
              Center(child: Text(addressAdditional.toUpperCase())),
            ],
          ),
        ),
      ),
    );
  }
}
