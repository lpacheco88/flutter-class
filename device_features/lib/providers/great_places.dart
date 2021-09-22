import 'dart:io';

import 'package:device_features/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
      location: null,
    );

    _items.add(newPlace);
    notifyListeners();
  }
}
