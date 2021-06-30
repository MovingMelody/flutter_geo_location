import 'package:get_it/get_it.dart';
import 'package:get_user_location/services/LocationService/location_service.dart';
import 'package:injectable/injectable.dart';

import './locator.config.dart';

GetIt locator = GetIt.instance;

// @injectableInit
// Future<void> setupLocator() async {
//   $initGetIt(locator);
// }

@injectableInit
void setupLocator() {
  locator.registerSingleton<LocationService>(LocationService());
}
