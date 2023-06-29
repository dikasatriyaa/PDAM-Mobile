import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pdam/components/userr_model.dart';
import 'package:pdam/models/pdam_models.dart';

class FetchUserList {
  var data = [];
  List<Album> results = [];
  String urlList = 'http://10.0.2.2/uasb/create/';

  Future<List<Album>> getuserList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {

        data = json.decode(response.body);
        results = data.map((e) => Album.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.idPengaduan == query).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
