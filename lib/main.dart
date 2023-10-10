import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';
// import './pages/Login.dart';
import './pages/AgendarCita.dart';
void main() => runApp(MaterialApp(
      theme: ThemeData(
        // backgroundColor: Color(0xff121217),
         textTheme: TextTheme(
           headlineMedium: TextStyle(fontSize: 40)
         )
      ),
      home: SplashScreen(),
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  //Simulates loading of data
  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AgendarCita()));
    // await Timer(const Duration(seconds: 5), onDoneLoading);
  }

  // onDoneLoading() async {
  // }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
          'assets/splash2.json',
          fit: BoxFit.fill,
    );
  }
}
