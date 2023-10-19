import 'package:flutter/material.dart';
import 'package:fpg_greenhouse/screens/splash_screen.dart';
import 'package:fpg_greenhouse/widgets/plot_one.dart';
import 'package:fpg_greenhouse/widgets/plot_three.dart';
import 'package:fpg_greenhouse/widgets/plot_two.dart';
import 'package:fpg_greenhouse/widgets/temp_humid_widget.dart';

void main() {
  runApp(const MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    double screenHeight =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    return Scaffold(
        backgroundColor: const Color(0xFFf9f9f9),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF023020),
          elevation: 0.0,
          title: Container(
            margin: EdgeInsets.only(left: screenWidth * 0.05),
            child: Row(
              children: [
                const Icon(Icons.eco),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    "Be Leaf",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
                height: screenHeight * 0.25,
                width: double.infinity,
                child: TempHumidWidget()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: screenHeight * 0.20,
                  width: screenWidth * 0.9,
                  child: const PlotCardsOne(),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: screenHeight * 0.20,
                  width: screenWidth * 0.9,
                  child: const PlotCardsTwo(),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: screenHeight * 0.20,
                  width: screenWidth * 0.8,
                  child: const PlotCardsThree(),
                ),
              ],
            )
          ],
        ));
  }
}
