import 'package:flutter/material.dart';
import 'package:fpg_greenhouse/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    _navigatetologin();
  }

  _navigatetologin() async{
    await Future.delayed(const Duration(milliseconds: 6000),(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: const Color(0xFF023020),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const[
               Center(child:Icon(Icons.eco,size: 100,color: Colors.white,)),
               Center(
                child: Text(
                  "Be Leaf",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),

              SizedBox(height: 200),
              CircularProgressIndicator(strokeWidth: 2,color: Colors.white,)
            ],
          )),
    );
  }
}
