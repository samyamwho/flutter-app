// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:team_rescue_routes/Models/address.dart';

class AppData extends ChangeNotifier {
  late Address pickUpLocation;
  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
