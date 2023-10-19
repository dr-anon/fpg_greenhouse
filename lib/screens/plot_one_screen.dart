import 'package:flutter/material.dart';
import 'package:fpg_greenhouse/api_models/api_classes.dart';
// import 'package:fpg_greenhouse/widgets/temp_humid_widget.dart';

import '../database/database.dart';
import '../widgets/plot_one_info.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PlotOneInfoScreen extends StatefulWidget {
  const PlotOneInfoScreen({Key? key}) : super(key: key);

  @override
  State<PlotOneInfoScreen> createState() => _PlotOneInfoScreenState();
}

class _PlotOneInfoScreenState extends State<PlotOneInfoScreen> {
  List<Map<String, dynamic>> input_data = [];
  int clicked = 0;
  // bool _isLoading = true;
  void _refreshinput_data() async {
    final data = await SQLHelper.getItems();
    setState(() {
      input_data = data;
      // _isLoading = false
      print(input_data);
    });
  }

  final _genotypeController = TextEditingController();
  final _phController = TextEditingController();
  final _moistureController = TextEditingController();
  final _tempController = TextEditingController();
  final _humidController = TextEditingController();
  final StreamController<EditedPlotOne> _streamController = StreamController();

  Future<void> _addItem() async {
    await SQLHelper.createItem(_tempController.text, _humidController.text,
        _phController.text, _moistureController.text);
    _refreshinput_data();
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _tempController.text, _humidController.text,
        _phController.text, _moistureController.text);
    _refreshinput_data();
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingInputData =
          input_data.firstWhere((element) => element['id'] == id);
      _tempController.text = existingInputData['temperature'];
      _humidController.text = existingInputData['humidity'];
      _phController.text = existingInputData['ph'];
      _moistureController.text = existingInputData['moisture'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  top: 40,
                  left: 40,
                  right: 40,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit Plot Details",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _tempController,
                    decoration: InputDecoration(
                      labelText: 'Temperature',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _humidController,
                    decoration: InputDecoration(
                      labelText: 'Humidity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _phController,
                    decoration: InputDecoration(
                      labelText: 'Ph',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _moistureController,
                    decoration: InputDecoration(
                      labelText: 'Soil Moisture',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text('Cancel',
                            style: TextStyle(color: Color(0xFF023020))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Edit',
                            style: TextStyle(color: Color(0xFF023020))),
                        onPressed: () async {
                          if (id == null) {
                            await _addItem();
                          }

                          if (id != null) {
                            await _updateItem(id);
                          }

                          runPostData();

                          _genotypeController.clear();
                          _phController.clear();
                          _humidController.clear();
                          _moistureController.clear();
                          _tempController.clear();

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    _refreshinput_data();
  }

  String apiKey = "6M7I806L7NG3MGOQ";
  String baseUrl = "https://api.thingspeak.com/update.json";

  void runPostData() {
    postData();
  }

  postData() async {
    var url = Uri.parse(baseUrl);
    Map<String, dynamic> body = {
      "api_key": apiKey,
      "description": _genotypeController.text,
      "field1": _tempController.text,
      "field2": _humidController.text,
      "field3": _phController.text,
      "field4": _moistureController.text,
      // "field6": clicked
    };
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    var response = await http.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // print("res body ${jsonDecode(response.body)}  status= ${response.statusCode}");
    }
  }
  
  waterPump() async{
    var url = Uri.parse(baseUrl);
    Map<String, dynamic> body = {
      "api_key": apiKey,
      "field6": clicked
    };
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    var response = await http.post(url, body: body, headers: header);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // print("res body ${jsonDecode(response.body)}  status= ${response.statusCode}");
    }
    
  }

  Future<void> getEditedData() async {
    var endpoint = Uri.parse(
        "https://api.thingspeak.com/channels/2231473/feeds.json?api_key=1JY467G2I787MSLV&results=2");

    var response = await http.get(endpoint);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      EditedPlotOne data = EditedPlotOne.fromJson(jsonData);
      _streamController.sink.add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    double screenHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF023020),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              height: screenHeight * 0.25,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Image.asset(
                  'assets/images/wallpaper.jpg',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.15,
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                    bottom: screenHeight * 0.03),
                height: screenHeight * 0.20,
                width: screenWidth * 0.90,
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
                child: Container(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.9 * 0.05,
                        top: screenHeight * 0.20 * 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      right: screenWidth * 0.9 * 0.05),
                                  child: const Text(
                                    "Plot I",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            Color.fromARGB(255, 158, 160, 159)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: screenWidth * 0.9 * 0.05),
                                  child: const Text(
                                    "Threshold Values",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            Color.fromARGB(255, 158, 160, 159)),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => {
                                _showForm(input_data[0]['id']),
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                    right: screenWidth * 0.9 * 0.09),
                                child: const Icon(
                                  Icons.edit,
                                  color: Color(0xFF023020),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: screenHeight * 0.20 * 0.02),
                          // color: Colors.green,
                          height: screenHeight * 0.20 * 0.45,
                          width: screenWidth * 0.9 * 0.9,
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.9 * 0.9 * 0.01),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.female_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "A",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.thermostat,
                                        size: 20, color: Color(0xFF023020)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${input_data[0]['temperature'].toString()}°C",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.water_drop_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${input_data[0]['humidity'].toString()}%",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.water_drop_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      input_data[0]['ph'].toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Icon(Icons.water_drop_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${input_data[0]['moisture'].toString()}%",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    )),
              ),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.68),
            child: const Text(
              "Live Readings",
              style: TextStyle(
                  fontSize: 10, color: Color.fromARGB(255, 158, 160, 159)),
            ),
          ),
          SizedBox(
              height: screenHeight * 0.43,
              width: screenWidth * 0.9,
              child: const PlotCardsOneInfo()),
          SizedBox(
            width: screenWidth * 0.8,
            height: 50,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF023020)),
                      onPressed: () {
                        clicked = 1;
                        waterPump();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.cloudy_snowing,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Pump On",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 176, 1, 1)),
                      onPressed: () {
                        clicked =0;
                        print(waterPump());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.cloudy_snowing,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Pump off",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
