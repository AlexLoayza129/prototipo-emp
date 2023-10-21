import 'dart:convert';
import 'dart:ui';

import 'package:drplus/global/helper.dart';
import 'package:drplus/model/User.dart';
import 'package:drplus/widget/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Home extends StatelessWidget{

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var id = arguments['id']; 
    return MaterialApp(
      title: "Dr. Plus - Home",
      routes: helper.routes,
      home:  HomeFul(id: id),
    );
  }

}

class HomeFul extends StatefulWidget {
  var id;
  HomeFul({Key? key, required this.id}) : super(key: key);

  @override
  State<HomeFul> createState() => _HomePageState();

}

class _HomePageState extends State<HomeFul>{
   
  late var id;
  var nombre;
  var apellido;
  var user;
  late Future<List<User>> doctores;
  List<User> doctoresList = [];
  // List cards = List.generate(doctores, (i)=> new CustomCard());

  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    id = widget.id;
    getUserInfo();
    // getDoctors();
  }

 @override
  Widget build(BuildContext context) {
    Helper helper = Helper(context);
    var width = helper.getWidth();
    var height = helper.getHeight();

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.only(top: height*0.05, left: width*0.05, right: width*0.05),
        child: SingleChildScrollView(
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
                  Text("Bienvenido ${user?['nombre'] ?? ''} ${user?['apellido'] ?? ''}", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.04))
                ]
              )
            )
            ,
            Padding(padding: EdgeInsets.only(top: height*0.04)),
            SingleChildScrollView(
              child: FutureBuilder(
              future: getDoctors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No se encontraron doctores.');
                } else {
                  print("=============================================");
                  // return Text(snapshot.data![0].nombre);
                  var data = snapshot.data;
                  for(int i = 0; i < data!.length; i++){
                    return InkWell(
                      onTap: () => {
                        Navigator.pushNamedAndRemoveUntil(context, '/makeAppointment', (route) => false, arguments: { 'id' : id})
                      },
                      child: Container(
                          margin: EdgeInsets.all(width*0.05),
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
                              Image.asset(
                                "assets/doctor1.jpg",
                                width: width*0.2,
                                // height: width*0.9/2,
                              ),
                              Padding(padding: EdgeInsets.only(left: width*0.02)),
                              Column(
                                children: [
                                  Text("Doctor ${snapshot.data![0].nombre} ${snapshot.data![0].apellido}", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.04)),
                                  Text("Especialista en Pediatria", style: TextStyle(color: helper.getThirdColor(), fontSize: width*0.03))
                                ],
                              )
                            ]
                          )
                        )
                    );
                  }
                  // snapshot.data!.map((data) {
                    
                  // });
                }
                return Text("Nada");
              },
              )
            )
          ]
        )
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
    // "https://53da-38-25-18-160.ngrok-free.app"
    //"http://192.168.18.13:7575"
    var res = await http.get(Uri.parse("http://20.84.60.188:8080/findUser?id=$id"), headers: {'Content-type': 'application/json'});
    if(res.statusCode == 200){
      setState(() {
        user = jsonDecode(res.body);
      });
    }
  }

  Future<List<User>> getDoctors() async {
  var res = await http.get(Uri.parse("http://20.84.60.188:8080/getDoctores"), headers: {'Content-type': 'application/json'});
    if (res.statusCode == 200) {
      List<User> docs = (json.decode(res.body) as List)
          .map((data) => User.fromJson(data))
          .toList();

      // setState(() {
      //   doctoresList = docs;
      //   doctores = ;
      // });
      return Future.value(docs);
    }
    throw Exception("Error al obtener los datos"); // Usa throw para lanzar una excepción en lugar de Future<T>.error
  }

  void _onItemTapped(int index) {
      Helper helper = Helper(context);
        setState(() {
          _selectedIndex = index;
        });
        helper.redirectTo(_selectedIndex, context, id);
  }
}