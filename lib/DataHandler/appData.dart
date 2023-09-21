// ignore: file_names
import 'package:flutter/material.dart';
import 'package:team_rescue_routes/Models/address.dart';

import 'package:flutter/foundation.dart';

class PickUpLocation {
  get placeName => null;
  // Add fields and methods related to the PickUpLocation class here
}

class AppData with ChangeNotifier {
  PickUpLocation? pickUpLocation = PickUpLocation(); // Declare as nullable with a default value

  // Constructor to initialize pickUpLocation
  AppData() {
    pickUpLocation = PickUpLocation();
  }

  void updatePickupLocationAddress(Address userPickUpAddress) {}
  // Other fields and methods...
}
