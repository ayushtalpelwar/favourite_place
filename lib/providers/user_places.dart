import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../model/place.dart';

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);

  void addPlace(String title,File image) {
    final newPlace = Place(title: title,image: image);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlaceNotifier,List<Place>>(
  (ref) => UserPlaceNotifier(),
);
