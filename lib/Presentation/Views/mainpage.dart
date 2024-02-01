import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/Presentation/widgets/history_container.dart';
import 'package:weatherapp/providers/hsitory_provider.dart';
import '../../data/Model/weather.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var locationName, currentWeather, wind, temp, hum, data;
  String? condition;
  getData() async {
    String baseUrl = 'api.weatherapi.com';
    String token = 'a04781ee5d9e4b97bab45024231912';
    var queryParameters = {'key': token, 'q': 'kochi'};
    var url = Uri.https(baseUrl, '/v1/current.json', queryParameters);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      data = weatherFromJson(response.body);
      setState(() {
        locationName = data.location.name;
        currentWeather = data.current.condition.text;
        wind = data.current.windDegree;
        temp = data.current.tempC;
        hum = data.current.humidity;
        condition = data.current.condition.text;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    Provider.of<HistoryProvider>(context, listen: false).getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    print(historyProvider.hdata);
    return Scaffold(
        body: data == null
            ? CircularProgressIndicator()
            : Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        locationName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(condition!.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.normal)),
                      Lottie.network(
                          height: 200,
                          width: 200,
                          'https://lottie.host/cb82905c-d19e-4ea2-beb5-29f657b21bb5/Pb3lE6xwVP.json'),
                      Text(
                        currentWeather.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Wind',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    wind.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            VerticalDivider(
                              width: 60,
                              color: Colors.white70,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Temp',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${temp.round().toString()}°',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            VerticalDivider(
                              indent: 50,
                              endIndent: 50,
                              width: 50,
                              color: Colors.black,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    'Humidity',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    hum.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.blue,
                                  Colors.white,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return historyProvider.hdata == null
                                  ? Center(child: CircularProgressIndicator())
                                  : HistoryContainer(
                                      imgUrl: 'assets/images/img1.png',
                                      temp: historyProvider.hdata!.forecast
                                          .forecastday[0].hour[index].tempC
                                          .toString(),
                                      time: historyProvider.hdata!.forecast
                                          .forecastday[0].hour[index].time
                                          .split(' ')[1],
                                    );
                            },
                          )),
                    ],
                  ),
                ),
              ));
  }
}
