import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../data/location_service.dart';

class LocationViewModel extends ChangeNotifier {
  final LocationService _service = LocationService();

  LatLng? _userLocation;
  bool _isLocating = false;
  String? _problem;

  LatLng? get userLocation => _userLocation;
  bool get isLocating => _isLocating;
  String? get problem => _problem;

  Future<void> findUser() async {
    _isLocating = true;
    _problem = null;
    notifyListeners();

    try {
      _userLocation = await _service.getCurrentLocation();
    } on LocationException catch (error) {
      _problem = error.message;
    } catch (error) {
      _problem = "Couldn't get a location fix";
    } finally {
      _isLocating = false;
      notifyListeners();
    }
  }
}