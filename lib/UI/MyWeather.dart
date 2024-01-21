import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:receipebook/models/WeatherModel.dart';
import 'package:receipebook/services/ApiService.dart';

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  String getCurrentDate(){

    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('MMM d, y H:mm:ss a').format(now);
    return formattedDateTime;
  }

  String _formatTime(int timestamp){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedTime = "${dateTime.hour}:${dateTime.minute}";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(getCurrentDate())),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.more_vert))
        ],
      ),
      body: FutureBuilder<WeatherModel>(
        future: ApiService().getWeather(),
        builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
        }else if (snapshot.hasError){
           return Center(child: Text("Something went wrong ${snapshot.error}"));
        }else {
          WeatherModel weatherModel = snapshot.data as WeatherModel;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(weatherModel.name ?? "", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )

                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(weatherModel.weather?[0].main ?? "", style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0
                  ),),
                ),
                Icon(Icons.cloud_circle_sharp, size: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${weatherModel.main?.temp ?? ""}°C", style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w600

                  ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("max"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${weatherModel.main?.tempMax ?? ""}°C"),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1,
                        height: 30,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Column(
                      children: [
                        Text("min"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${weatherModel.main?.tempMin ?? ""}°C")
                      ],
                    ),

                  ],

                ),


                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.blueGrey,
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("wind speed"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${weatherModel.wind?.speed ?? 0}m/s")
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1,
                        height: 30,
                        color: Colors.blueGrey,
                      ),
                    ),

                    Column(
                      children: [
                        Text("sunrise"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${_formatTime(weatherModel.sys?.sunrise ?? 0)}")
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1,
                        height: 30,
                        color: Colors.blueGrey,
                      ),
                    ),

                    Column(
                      children: [
                        Text("sunset"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${_formatTime(weatherModel.sys?.sunset ?? 0)}")
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1,
                        height: 30,
                        color: Colors.blueGrey,
                      ),
                    ),

                    Column(
                      children: [
                        Text("humidity"),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${weatherModel.main?.humidity ?? 0}%")
                      ],
                    ),
                  ],
                )


              ]
          );
        }

        },
      )



    );
  }
}
