import 'dart:convert';
import 'package:http/http.dart' as apiHit;

//!function

hitApi(Uri uri) async {
  var response = await apiHit.get(uri);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {'Staus': 'false', 'Message': response.reasonPhrase};
  }
}
