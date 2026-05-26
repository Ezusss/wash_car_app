import 'package:geolocator/geolocator.dart';
import 'package:wash_car_app/core/errors.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationException(
          message: 'Location services are disabled.',
        );
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw LocationException(
            message: 'Location permissions are denied.',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationException(
          message: 'Location permissions are permanently denied.',
        );
      }

      return await Geolocator.getCurrentPosition(
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      if (e is LocationException) rethrow;
      throw LocationException(message: e.toString());
    }
  }

  Future<Position?> getLastKnownLocation() async {
    try {
      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      return null;
    }
  }
}
