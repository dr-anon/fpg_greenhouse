import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_models/api_classes.dart';
import '../screens/plot_two_screen.dart';

class PlotCardsTwo extends StatefulWidget {
  const PlotCardsTwo({Key? key}) : super(key: key);

  @override
  State<PlotCardsTwo> createState() => _PlotCardsTwoState();
}

class _PlotCardsTwoState extends State<PlotCardsTwo> {
  final StreamController<PlotTwo> _streamController = StreamController();

  @override
  void initState() {
    super.initState();
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
      PlotTwo data = PlotTwo.fromJson(jsonData);
      _streamController.sink.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PlotTwo>(
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

Widget PlotBody(BuildContext context, PlotTwo data) {
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

  return Column(
    children: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PlotTwoInfoScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF023020),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: const Offset(-2, 2))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          width: screenWidth * .90,
          height: screenHeight * .55 * 0.35,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: screenWidth * 0.10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/plant-eight.png',
                            height: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data.name!,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.female,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Genotype",
                              style: titlestyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(
                              CupertinoIcons.drop,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "PH",
                              style: titlestyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: const [
                            Icon(
                              CupertinoIcons.drop,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Soil Moisture", style: titlestyle),
                          ],
                        )
                      ],
                    ),
                    Container(
                      // padding: EdgeInsets.only(top: 10,left: 30,bottom: 10),
                      margin: EdgeInsets.only(right: screenWidth * 0.80 * 0.05),
                      child: Column(
                        children: [
                          Text(
                            data.description ?? '',
                            style: titlestyle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "N/A",
                            style: titlestyle,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "${data.moisture}%",
                            style: titlestyle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
        ),
      ),
    ],
  );
}
