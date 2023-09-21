// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Import 'widgets' instead of 'framework'
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:team_rescue_routes/Assistants/requestAssistant.dart';
import 'package:team_rescue_routes/DataHandler/appData.dart';
import 'package:team_rescue_routes/Models/address.dart';

class AssistantMethods {
    static BuildContext? get context => null;
    
    static get mapkey => null;

    static Future<String> searchCoordinateAddress(BuildContext context, Position position) async {
    
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url ="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapkey";

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      // placeAddress = response [ "results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      // ignore: prefer_interpolation_to_compose_strings
      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      // ignore: prefer_typing_uninitialized_variables
      var latitude2;
      // ignore: prefer_typing_uninitialized_variables
      var longitude2;
      Address userPickUpAddress = Address(placeFormattedAddress: '', placeName: '', placeId: '', latitude: latitude2, longitude: longitude2);
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickupLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }
}
