import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'ApiException.dart';

enum ApiAddress {
  Expenses
}







class ApiClient{




  static String urlMovie = "https://hoblist.com/api/movieList";


  Future<dynamic> fetchData(String url,Map<String, dynamic> params) async {

    // SharedPreferences pref = await SharedPreferences.getInstance();
    // String token = pref.getString("token") ?? "";
    var urlData = Uri.parse(url);
    print(url);
    print(params);
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    try{
      var response = await http.post(
          urlData,
          headers: <String, String>{
            "Content-Type": "application/json",
          },
          body:  body
      );
      print('\x1B[32m${response.body}\x1B[0m');
      // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      // pattern.allMatches(response.body).forEach((match) => print('\x1B[32m${match.group(0)}\x1B[0m'));
      return returnResponse(response);
    }on SocketException {
      throw FetchDataException('No Internet connection');
    }

  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
