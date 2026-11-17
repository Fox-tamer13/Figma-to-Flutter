import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationException implements Exception{
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationService {
  Future<LatLng> getCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()){
      throw const LocationException('location is turned off on this device');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever){
      throw const LocationException('location permission was denied');
    }
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        timeLimit: Duration(seconds: 10),
      ),
    );
    return LatLng(position.latitude, position.longitude);
  }
}
