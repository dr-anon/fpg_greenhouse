import 'package:flutter/material.dart';

import '../widgets/plot_two_info.dart';
// import 'package:fpg_greenhouse/widgets/temp_humid_widget.dart';

// import '../widgets/plot_one_info.dart';

class PlotTwoInfoScreen extends StatefulWidget {
  const PlotTwoInfoScreen({Key? key}) : super(key: key);

  @override
  State<PlotTwoInfoScreen> createState() => _PlotTwoInfoScreenState();
}

class _PlotTwoInfoScreenState extends State<PlotTwoInfoScreen> {
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
                                      right: screenWidth * 0.9 * 0.04),
                                  child: const Text(
                                    "Plot II",
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
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Edit plot details'),
                                      content: Form(
                                        // key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              // controller: _genotypeController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Genotype Field cannot be empty';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Genotype',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              // controller: _phController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Ph field cannot be empty';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Ph',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              // controller: _moistureController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Moisture field cannot be empty';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Moisture',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              // controller: _tempController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Temperature Field cannot be empty';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Temperature',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              // controller: _humidController,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Humidity Field cannot be empty';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Humidity',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text(
                                            'Cancel',
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Edit'),
                                          onPressed: () {},
                                        ),
                                      ],
                                    );
                                  },
                                );
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
                                  children: const [
                                    Icon(Icons.thermostat,
                                        size: 20, color: Color(0xFF023020)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "25",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.water_drop_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "54",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.water_drop_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "45",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF023020)),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.water_drop_outlined,
                                        size: 20, color: Color(0xFF023020)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "45",
                                      style: TextStyle(
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
              child: const PlotCardsTwoInfo()),
          SizedBox(
            width: screenWidth * 0.8,
            height: 50,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFF023020)),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.cloudy_snowing,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Water Plot",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
