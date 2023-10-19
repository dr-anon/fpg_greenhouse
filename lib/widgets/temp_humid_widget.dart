import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api_models/api_classes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TempHumidWidget extends StatefulWidget {
  TempHumidWidget({Key? key}) : super(key: key);

  @override
  State<TempHumidWidget> createState() => _TempHumidWidgetState();
}

class _TempHumidWidgetState extends State<TempHumidWidget> {
  final StreamController<Data> _streamController = StreamController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getCurrentData();
    });
  }

  Future<void> getCurrentData() async {
    var endpoint = Uri.parse(
        "https://api.thingspeak.com/channels/2194506/feeds.json?api_key=JWKCSKYRMEO03HKZ&results=2");

    var response = await http.get(endpoint);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      Data data = Data.fromJson(jsonData);
      _streamController.sink.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Data>(
          stream: _streamController.stream,
          builder: (context, snapdata) {
            switch (snapdata.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: Text("No Internet connection"),
                );
              default:
                if (snapdata.hasError) {
                  return const Center(
                    child: Text("Check internet connection..."),
                  );
                } else {
                  return Body(snapdata.data!);
                }
            }
          }),
    );
  }
}

Widget Body(Data data) {
  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  return Row(
    children: [
      Container(
          margin: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.05),
          height: screenHeight * 0.15,
          width: screenWidth * .40,
          padding: EdgeInsets.only(
              top: screenHeight * 0.20 * 0.25, left: screenWidth * .40 * 0.125),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(-2, 2))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.thermostat,
                          color: const Color(0xFF023020),
                          size: 25.0,
                        ),
                        Text("Temperature",
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFF023020))),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.20 * 0.005),
                      child: Text(
                        "${data.temp!}°C",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xFF023020)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      Container(
          margin: EdgeInsets.only(
              top: screenHeight * 0.05,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: screenHeight * 0.05),
          height: screenHeight * 0.15,
          width: screenWidth * .40,
          padding: EdgeInsets.only(
              top: screenHeight * 0.20 * 0.25, left: screenWidth * .40 * 0.125),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(-2, 2))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.drop,
                          color: Color(0xFF023020),
                          size: 25.0,
                        ),
                        Text("Humidity",
                            style: TextStyle(
                                fontSize: 11, color: Color(0xFF023020))),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.20 * 0.005),
                      child: Text(
                        "${data.humidity!}%",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Color(0xFF023020)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    ],
  );
}
