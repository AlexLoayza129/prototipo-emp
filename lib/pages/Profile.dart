import 'dart:convert';

import 'package:drplus/global/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatelessWidget{
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic> {}) as Map;
    var id = arguments['id'];
    return MaterialApp(
      routes: helper.routes,
      home: ProfileFul(id: id),
    );
  }
}

class ProfileFul extends StatefulWidget{
  var id;
  ProfileFul({Key? key, required this.id}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileFul>{
  late int idUser;
  var user;
  int _selectedIndex = 1;
  var helper;
  var width;
  var height;

  // var nombre;
  // var apellido;
  // var direccion;
  // var telefono;
  @override
  void initState() {
    super.initState();
    idUser = widget.id;
    _selectedIndex = 1;
    getUserInfo();
    // nombre = user?['nombre'] ?? "";
    // apellido = user?['apellido'] ?? "";
    // direccion = user?['direccion'] ?? "";
    // telefono = user?['telefono'] ?? "";
  }

  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);
    // setState(() {
    //   selfContext = context;
    // });
    var width = helper.getWidth();
    var height = helper.getHeight();

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.only(top: height*0.05, left: width*0.05, right: width*0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Column(
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
                            Text("Perfil de Usuario", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.04))
                          ]
                        )
                      ),
                    Padding(padding: EdgeInsets.only(top: height*0.05)),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: Image.asset(
                        "assets/doctor1.jpg",
                        width: width*0.3,
                        height: width*0.9/2,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: height*0.02)),
                    Text("Nombres: ${user?['nombre'] ?? ''}"),
                    Padding(padding: EdgeInsets.only(top: height*0.02)),
                    Text("Apellidos: ${user?['apellido'] ?? ''}"),
                    Padding(padding: EdgeInsets.only(top: height*0.02)),
                    Text("Direccion: ${user?['direccion'] ?? ''}"),
                    Padding(padding: EdgeInsets.only(top: height*0.02)),
                    Text("Telefono: ${user?['telefono'] ?? ''}")
                    ]
                  )
                ,Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: height*0.20)),
                    InkWell(
                      onTap: () => {
                        Navigator.pushNamedAndRemoveUntil(context, '/consults', (route) => false, arguments: {'id': idUser})
                      },
                      child: Container(
                        width: width*0.6,
                        padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.02),
                        decoration: BoxDecoration(color: helper.getThirdColor(), borderRadius: BorderRadius.circular(10)),
                        child: Text("Consultas", textAlign: TextAlign.center, style: TextStyle(color: helper.getSecondaryColor()),)
                      ),
                    )
                  ],
                )
            ],
          )
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
                backgroundColor: helper.getThirdColor(),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.business),
              //   label: 'Agendar Cita',
              //   backgroundColor: helper.getThirdColor(),
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pending_actions),
                label: 'Perfil',
                backgroundColor: helper.getThirdColor(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.web_rounded),
                label: 'Comunidad',
                backgroundColor: helper.getThirdColor(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Salir',
                backgroundColor: helper.getThirdColor(),
              ),
            ],
            currentIndex: _selectedIndex,
            // selectedItemColor: ,
            onTap: _onItemTapped,
          )
      );
  }

  void getUserInfo() async{
    var res = await http.get(Uri.parse("http://20.84.60.188:8080/findUser?id=$idUser"), headers: {'Content-type': 'application/json'});
    if(res.statusCode == 200){
      setState(() {
        user = jsonDecode(res.body);
      });
    }
  }

  void _onItemTapped(int index) {
    Helper helper = Helper(context);
    setState(() {
      _selectedIndex = index;
    });
    helper.redirectTo(index, context, idUser);
  }
}
