import 'dart:convert';

import 'package:drplus/global/helper.dart';
import 'package:drplus/model/Consult.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Consultas extends StatelessWidget{
  Consultas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var id = arguments['id'];
    print(id);
    return MaterialApp(
      routes: helper.routes,
      home: _ConsultasFul(id: id),
    );
  }
}

class _ConsultasFul extends StatefulWidget{
  var id;
  _ConsultasFul({Key? key, required this.id}) : super(key: key);

  @override
  State<_ConsultasFul> createState() => _ConsultasFulState();
}

class _ConsultasFulState extends State<_ConsultasFul>{

  var width;
  var height;
  late var id;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
    id = widget.id;
  }

  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);
    setState(() {
      width = helper.getWidth();
      height = helper.getHeight();
    });
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        // padding: EdgeInsets.only(top: height*0.05, left: width*0.05, right: width*0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: height*0.05)),
              Container(
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
                      Column(
                        children: [
                          Text("Consutal C-000 con el Doctor Alex Loayza", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.04)),
                          Row(children: [
                            Text("Especialista en Pediatria", style: TextStyle( fontSize: width*0.03)),
                            Padding(padding: EdgeInsets.symmetric(horizontal: width*0.05)),
                            Text("Precio: 59", style: TextStyle(fontSize: width*0.03))
                          ],)
                        ],
                      )
                    ]
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

  Future<List<Consult>> getConsults() async {
  var res = await http.get(Uri.parse("https://53da-38-25-18-160.ngrok-free.app/getConsultas?id=$id"), headers: {'Content-type': 'application/json'});
    if (res.statusCode == 200) {
      List<Consult> consults  = (json.decode(res.body) as List)
          .map((data) => Consult.fromJson(data))
          .toList();

      return Future.value(consults);
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