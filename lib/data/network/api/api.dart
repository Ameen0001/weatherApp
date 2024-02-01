import 'package:http/http.dart' as http;
import 'package:weatherapp/data/Model/weather.dart';
class WeatherData {

  getData() async {
    String baseUrl = 'api.weatherapi.com';
    String token = 'a04781ee5d9e4b97bab45024231912';
    var queryParameters = {'key': token, 'q': 'kochi'};
    var url = Uri.https(baseUrl, '/v1/current.json', queryParameters);

    final response =await http.get(url);
    if(response.statusCode==200){
      print(response.body);
      var data=weatherFromJson(response.body);
    }
    }
}