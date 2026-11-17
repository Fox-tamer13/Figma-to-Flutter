import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/attraction.dart';

class MapsLinkService {
  Uri linkFor(Attraction attraction) {
    final double lat = attraction.location.latitude;
    final double lng = attraction.location.longitude;

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Uri.https('maps.apple.com', '/', {'ll': '$lat,$lng', 'q': attraction.name
      });
    }
    return Uri.https('www.google.com', '/maps/search/',{
      'api': '1',
      'query': '$lat,$lng', 
    });
  }
  Future<bool> open(Attraction attraction) async {
    try {
      return await launchUrl(
        linkFor(attraction),
        mode: LaunchMode.externalApplication,
      );
    } catch (error) {
      return false;
    }
  }
}