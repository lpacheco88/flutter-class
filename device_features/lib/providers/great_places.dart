import 'package:device_features/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
}
