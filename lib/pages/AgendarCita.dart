import 'package:flutter/material.dart';
 
 
class AgendarCita extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<AgendarCita> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            color: Color.fromARGB(255, 239, 243, 243),
            width: double.infinity,
            child: Column(children: <Widget>[
              Container(
                width: 200,
                margin: EdgeInsets.only(top:40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage('assets/perfil.png'),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

