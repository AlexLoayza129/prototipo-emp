import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
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

class Home extends StatelessWidget {

  // Widget page(text, color, context){
  //   return Container(
  //     color: color,
  //     child: Align(
  //       alignment: Alignment(0, 0.5),
  //       child: Text(text, style: Theme.of(context).textTheme.headlineMedium,),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Text("Hi")
      ),
    );
  }
}