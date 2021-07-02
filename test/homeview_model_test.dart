import 'package:flutter_test/flutter_test.dart';
import 'package:get_user_location/services/LocationService/location_service.dart';
import 'package:mockito/mockito.dart';

class MockLocationService extends Mock implements LocationService {}

void main() {
  test("It should return the current user address by detecting his location",
      () async {
    final mockLocationService = MockLocationService();
    await mockLocationService.getAddress();
    expect(mockLocationService.getAddress,
        "NH71 , Chennai - Anantapur Highway, Kothavaripalle ,  Chennai - Anantapur Highway ,  , Chittoor , 517319 , Andhra Pradesh , India");
  });
}
