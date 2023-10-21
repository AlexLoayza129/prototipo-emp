import 'dart:convert';

import 'package:drplus/global/helper.dart';
import 'package:drplus/model/User.dart';
import 'package:drplus/pages/CrearCuenta.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    Helper helper = Helper(context);

    return MaterialApp(
      title: _title,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
      routes: helper.routes,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  redirectToHome(id){
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: {'id': id });
  }

  var url = 'http://20.84.60.188:8080/getUser';
  void saveUser() async{
    var username = nameController.text.toString();
    var pwd = passwordController.text.toString();
    Map data = {
      'username': username,
      'password': pwd,
    };

    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),body: body, headers: {'Content-type': 'application/json'});

    if(response.statusCode == 200){
      setState(() {
        var data = jsonDecode(response.body);
        redirectToHome(data['id']);
      });
    }else{
      nameController.text = "";
      passwordController.text = "";
      showAlertMessage(context, "Datos incorrectos", "Por favor asegurate que el usuario y contraseña sean correctos!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Image(
                  image: AssetImage('assets/logo.png'),
                  width: 120,
                  height: 120,
                )
                ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Bienvenido (a)',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('¿Olvidaste tu contraseña?',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Ingresar'),
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                    saveUser();
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('¿Aún no tienes una cuenta en DR.PLUS?', style: TextStyle(fontSize: 10),),
                TextButton(
                  child: const Text(
                    'Crear Cuenta',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/create', (route) => false);
                  },
                )
              ]
            ),
          ],
        ));
  }
}

showAlertMessage(BuildContext context, String title, String content) {
    Helper helper = Helper(context);
      // set up the button
      Widget okButton = TextButton(
        child: Text("Aceptar", style: TextStyle(color: helper.getThirdColor())),
        onPressed: () {
          // Navigator.of(context).pop();
          Navigator.of(context, rootNavigator: true).pop();
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

}