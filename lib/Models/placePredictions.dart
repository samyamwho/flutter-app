// ignore_for_file: non_constant_identifier_names

class PlacePredictions 
{
  String secondary_text;
  String main_text;
  String place_id;

  PlacePredictions({required this.secondary_text, required this.main_text, required this.place_id});
  
  factory PlacePredictions.fromJson(Map<String, dynamic> json) {
    return PlacePredictions(
      place_id: json["place_id"],
      main_text: json["structured_formatting"]["main_text"],
      secondary_text: json["structured_formatting"]["secondary_text"],
    );
  }
}