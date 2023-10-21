import 'package:drplus/global/helper.dart';
import 'package:drplus/pages/CrearCuenta.dart';
import 'package:drplus/pages/Home.dart';
import 'package:drplus/pages/Login.dart';
import 'package:drplus/pages/Profile.dart';
import 'package:drplus/pages/ResumenCita.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';
// import './pages/Login.dart';
import './pages/AgendarCita.dart';
void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // backgroundColor: Color(0xff121217),
         textTheme: TextTheme(
           headlineMedium: TextStyle(fontSize: 40)
         )
      ),
      routes: {
        '/login': (context) => Login(),
        '/create': (context) => CrearCuenta(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/makeAppointment': (context) => AgendarCita(),
        '/dateResume': (context) => ResumenCita()
      },
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
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
