import 'dart:ui';

import 'package:drplus/global/helper.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget{

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);

    return MaterialApp(
      title: "Dr. Plus - Home",
      routes: helper.routes,
      home:  const HomeFul(),
    );
  }

}

class HomeFul extends StatefulWidget {
  const HomeFul({Key? key}) : super(key: key);

  @override
  State<HomeFul> createState() => _HomePageState();

}

class _HomePageState extends State<HomeFul>{
   

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

 @override
  Widget build(BuildContext context) {

    Helper helper = Helper(context);
    var width = helper.getWidth();
    var height = helper.getHeight();

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
      helper.redirectTo(index, context);
    }

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.only(top: height*0.05, left: width*0.05, right: width*0.05),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(width*0.05),
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,1.0),
                    blurRadius: 6.0
                  )
              ]),
              child: Row(
                children: [
                  Text("Bienvenido Alex Loayza", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.04))
                ]
              )
            )
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: helper.getThirdColor(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Agendar Cita',
              backgroundColor: helper.getThirdColor(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
              backgroundColor: helper.getThirdColor(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: helper.getThirdColor(),
            ),
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: ,
          onTap: _onItemTapped,
        )
    );
  }
}