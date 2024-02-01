
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/data/Model/history.dart';

class HistoryProvider extends ChangeNotifier {
  History? hdata;
  getHistory() async {
    String baseUrl = 'api.weatherapi.com';
    String token = 'a04781ee5d9e4b97bab45024231912';
    var queryParameters = {'key': token, 'q': 'kochi', 'dt': '2024-02-01'};
    var url = Uri.https(baseUrl, '/v1/history.json', queryParameters);
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      hdata=historyFromJson(response.body);
      notifyListeners();
      print(hdata);

    }
      else{
        print('object');
    }
    }

}