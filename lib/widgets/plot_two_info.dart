// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fpg_greenhouse/screens/plot_one_screen.dart';
import 'package:http/http.dart' as http;
import '../api_models/api_classes.dart';

class PlotCardsTwoInfo extends StatefulWidget {
  const PlotCardsTwoInfo({Key? key}) : super(key: key);

  @override
  State<PlotCardsTwoInfo> createState() => _PlotCardsTwoInfoState();
}

class _PlotCardsTwoInfoState extends State<PlotCardsTwoInfo> {
  final StreamController<PlotOne> _streamController = StreamController();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getCurrentData();
    });
  }

  Future<void> getCurrentData() async {
    var endpoint = Uri.parse(
        "https://api.thingspeak.com/channels/2210836/feeds.json?api_key=P7OIIVFCXPB6609T&results=2");

    var response = await http.get(endpoint);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      PlotOne data = PlotOne.fromJson(jsonData);
      _streamController.sink.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PlotOne>(
          stream: _streamController.stream,
          builder: (context, snapdata) {
            switch (snapdata.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF023020),
                    strokeWidth: 2,
                  ),
                );
              default:
                if (snapdata.hasError) {
                  return const Center(
                    child: Text("Check internet connection..."),
                  );
                } else {
                  return PlotBody(context, snapdata.data!);
                }
            }
          }),
    );
  }
}

Widget PlotBody(BuildContext context, PlotOne data) {
  List<Map<String, String>> cards = [
    {
      "genotype": "${data.description}",
      "ph": "${data.ph}",
      "moisture": "${data.moisture}",
      "temp": "${data.temp}",
      "humid": "${data.humidity}"
    }
  ];

  const titlestyle = TextStyle(
      color: Color.fromARGB(255, 157, 199, 5),
      fontSize: 16,
      fontWeight: FontWeight.w500);

  double screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  double screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: screenHeight * 0.02,
            // left: screenWidth * 0.05,
            // right: screenWidth * 0.05,
            // bottom: screenHeight * 0.05
          ),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.thermostat,
                    color: Color(0xFF023020),
                  ),
                  Text("Temperature",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF023020))),
                ],
              ),
              Text(
                "${data.temp!}°C",
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF023020)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: screenHeight * 0.02,
            // left: screenWidth * 0.05,
            // right: screenWidth * 0.05,
            // bottom: screenHeight * 0.05
          ),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.water_drop_outlined,
                    color: Color(0xFF023020),
                  ),
                  Text("Humidity",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF023020))),
                ],
              ),
              Text(
                data.humidity!,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF023020)),
              ),
            ],
          ),
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: screenHeight * 0.05,
              // left: screenWidth * 0.05,
              // right: screenWidth * 0.05,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.water_drop,
                    color: Color(0xFF023020),
                  ),
                  Text("Ph",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF023020))),
                ],
              ),
              Text(
                "N/A",
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF023020)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: screenHeight * 0.05,
              // left: screenWidth * 0.05,
              // right: screenWidth * 0.05,
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.water_drop_outlined,
                    color:Color(0xFF023020),
                  ),
                  Text("Moisture",
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF023020))),
                ],
              ),
              Text(
                "${data.moisture!}%",
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color(0xFF023020)),
              ),
            ],
          ),
        )
      ],
    ),
  ]);
}
