import 'package:http/http.dart' as http;

class RequestAssistant {
  static Future<dynamic> getRequest(String url) async {
    var response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        String data = response.body;
        return data;
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }
}
