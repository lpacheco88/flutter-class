import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = '';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitute, double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitute,$latitute&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitute,$longtitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAdress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    print(json.decode(response.body));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
