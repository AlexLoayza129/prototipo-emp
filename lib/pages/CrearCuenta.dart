import 'dart:convert';

import 'package:drplus/global/helper.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;

class CrearCuenta extends StatelessWidget {
  const CrearCuenta({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    Helper helper = Helper(context);
    return MaterialApp(
      routes: helper.routes,
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: const _CrearCuenta(),
      ),
    );
  }
}

class _CrearCuenta extends StatefulWidget{
  const _CrearCuenta({Key? key}) : super(key: key);

 @override
 _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<_CrearCuenta> {
 GlobalKey<FormState> keyForm = new GlobalKey();
 TextEditingController nameCtrl = new TextEditingController();
 TextEditingController apeCtrl = new TextEditingController();
 TextEditingController emailCtrl = new TextEditingController();
 TextEditingController mobileCtrl = new TextEditingController();
 TextEditingController passwordCtrl = new TextEditingController();
 TextEditingController repeatPassCtrl = new TextEditingController();
 TextEditingController dropdownValue = new TextEditingController();
 String genderCtrl = 'hombre';
 List<String> list = ["Doctor", "Paciente"];
 var error = "";
 late var width;
 late var height;
  var url = 'http://20.84.60.188:8080/createUser';
  void saveUser() async{
    var nombre = nameCtrl.text.toString();
    var apellido = apeCtrl.text.toString();
    var cel = mobileCtrl.text.toString();
    var gender = genderCtrl.toString();
    var userType = dropdownValue.toString();
    var idType;
    if(userType.toString().toUpperCase() == "DOCTOR"){
      idType = 1;
    }else{
      idType = 2;
    }
    var email = emailCtrl.text.toString();
    var pwd = '';
    if(passwordCtrl.text.toString().toLowerCase() == repeatPassCtrl.text.toString().toLowerCase()){
      pwd = passwordCtrl.text.toString();
    }else{
      error = "Las contraseñas no coinciden";
      return;
    }

    Map data = {
      'nombre': nombre.toString(),
      'apellido': apellido.toString(),
      'telefono': cel.toString(),
      // 'gender': gender,
      'usertype': idType,
      'username': email,
      'password': pwd.toString()
    };

    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),body: body, headers: {'Content-type': 'application/json'});
  }

 @override
 Widget build(BuildContext context) {
    Helper helper = Helper(context);

    setState(() {
      width = helper.getWidth();
      height = helper.getHeight();
    });  
   return MaterialApp(
     home: new Scaffold(
       appBar: new AppBar(
                leading: BackButton(
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>Login())),
        ),
        automaticallyImplyLeading: true,
         title: new Text('Registrarse'),
       ),
       body: new SingleChildScrollView(
         child: new Container(
           margin: new EdgeInsets.all(20.0),
           child: new Form(
             key: keyForm,
             child: formUI(),
           ),
         ),
       ),
     ),
   );
 }

 formItemsDesign(icon, item) {
   return Padding(
     padding: EdgeInsets.symmetric(vertical: 2),
     child: Card(child: ListTile(leading: Icon(icon), title: item)),
   );
 }

 Widget formUI() {
   return  Column(
     children: <Widget>[
       formItemsDesign(
           Icons.person,
           TextFormField(
             controller: nameCtrl,
             decoration: new InputDecoration(
               labelText: 'Nombres',
             ),
            //  validator: validateName,
           )),
       formItemsDesign(
          Icons.person,
          TextFormField(
            controller: apeCtrl,
            decoration: new InputDecoration(
              labelText: 'Apellidos',
            ),
          //  validator: validateName,
        )),
       formItemsDesign(
           Icons.phone,
           TextFormField(
             controller: mobileCtrl,
               decoration: new InputDecoration(
                 labelText: 'Numero de telefono',
               ),
               keyboardType: TextInputType.phone,
               maxLength: 10,
              // validator: validateMobile,
      )),
       formItemsDesign(
           null,
           Column(children: <Widget>[
             Text("Genero"),
             RadioListTile<String>(
               title: const Text('Hombre'),
               value: 'hombre',
               groupValue: genderCtrl,
               onChanged: (value) {
                 setState(() {
                  genderCtrl = value!;
                 });
               },
             ),
             RadioListTile<String>(
               title: const Text('Mujer'),
               value: 'mujer',
               groupValue: genderCtrl,
               onChanged: (value) {
                 setState(() {
                  genderCtrl = value!;
                 });
               },
             )
           ])),
       formItemsDesign(Icons.supervised_user_circle,
        DropdownMenu<String>(
          width: width*0.6,
          controller: dropdownValue,
          initialSelection: list.first,
          onSelected: (String? value) {
          },
          dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        )
       ),
       formItemsDesign(
           Icons.email,
           TextFormField(
             controller: emailCtrl,
               decoration: new InputDecoration(
                 labelText: 'Usuario',
               ),
               keyboardType: TextInputType.emailAddress,
               maxLength: 32,
              //  validator: validateEmail,
               
        )),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: passwordCtrl,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Contraseña',
             ),
           )),
       formItemsDesign(
           Icons.remove_red_eye,
           TextFormField(
             controller: repeatPassCtrl,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'Repetir la Contraseña',
             ),
            //  validator: validatePassword?.toString(),
           )),
   GestureDetector(
   onTap: (){
    saveUser();
    Navigator.pushNamedAndRemoveUntil(context, '/login',(route) => false);
    // Navigator.pop(context);
   },child: Container(
         margin: new EdgeInsets.all(30.0),
         alignment: Alignment.center,
         decoration: ShapeDecoration(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(30.0)),
           gradient: LinearGradient(colors: [
             Color(0xFF0EDED2),
             Color(0xFF03A0FE),
           ],
               begin: Alignment.topLeft, end: Alignment.bottomRight),
         ),
         child: Text("Guardar",
             style: TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.w500)),
         padding: EdgeInsets.only(top: 16, bottom: 16),
       ))
     ],
   );
 }



 String? validatePassword(String value) {
   print("valorrr $value passsword ${passwordCtrl.text}");
   if (value != passwordCtrl.text) {
     return "Las contraseñas no coinciden";
   }
   return null;
 }

 String? validateName(String value) {
   String pattern = r'(^[a-zA-Z ]*$)';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "El nombre es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "El nombre debe de ser a-z y A-Z";
   }
   return null;
 }

 String? validateMobile(String value) {
   String patttern = r'(^[0-9]*$)';
   RegExp regExp = new RegExp(patttern);
   if (value.length == 0) {
     return "El telefono es necesariod";
   } else if (value.length != 10) {
     return "El numero debe tener 10 digitos";
   }
   return null;
 }

 String? validateEmail(String value) {
   String pattern =
       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "El correo es necesario";
   } else if (!regExp.hasMatch(value)) {
     return "Correo invalido";
   } else {
     return null;
   }
 }

}
