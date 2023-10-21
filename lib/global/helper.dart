import 'package:drplus/pages/AgendarCita.dart';
import 'package:drplus/pages/Community.dart';
import 'package:drplus/pages/Consultas.dart';
import 'package:drplus/pages/CrearCuenta.dart';
import 'package:drplus/pages/Home.dart';
import 'package:drplus/pages/Login.dart';
import 'package:drplus/pages/Profile.dart';
import 'package:drplus/pages/ResumenCita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper{
  late dynamic width;
  late dynamic height;

  Color primaryColor =  const Color(0xFF1389FD);
  Color secondaryColor = const Color(0xFFFFFFFF);
  Color thirdColor = const Color(0xFF49BCF2);
  Color thirdOpacityColor = const Color.fromARGB(167, 73, 189, 242);
  Color disabledBg = Colors.grey;
  Color disabledText = const Color.fromARGB(255, 54, 54, 54);

  final formatPE = DateFormat('dd-MM-yyyy');

  Helper(context){
    width =  MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  //* Getters
  dynamic getWidth(){
    return width;
  }

  dynamic getHeight(){
    return height;
  }

  Color getPrimaryColor(){
    return primaryColor;
  }

  Color getSecondaryColor(){
    return secondaryColor;
  }

  Color getThirdColor(){
    return thirdColor;
  }

  Color getThirdOpacityColor(){
    return thirdOpacityColor;
  }

  Color getDisabledBgColor(){
    return disabledBg;
  }

  Color getDisabledTextColor(){
    return disabledText;
  }

  String getLocalDateFormat(DateTime day){
    return formatPE.format(day);
  }

  showAlertDialog(BuildContext context, String title, String content, String routeScreen, int? id) {

    Widget cancelButton = TextButton(
      child: const Text("Cancelar", style: TextStyle(color: Colors.redAccent)),
      onPressed: (){
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the button
    Widget okButton = TextButton(
      child: Text("Aceptar", style: TextStyle(color: getPrimaryColor())),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushNamedAndRemoveUntil(context, routeScreen, (route) => false, arguments: { 'id': id });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelButton,
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

  Map<String, Widget Function(BuildContext)> routes = {
    '/login': (context) => Login(),
    '/create': (context) => CrearCuenta(),
    '/home': (context) => Home(),
    '/profile': (context) => Profile(),
    '/makeAppointment': (context) => AgendarCita(),
    '/consults': (context) => Consultas(),
    '/community': (context) => Community(),
    '/dateResume': (context) => ResumenCita()
  };

  redirectTo(int index, BuildContext context, int id){
    switch(index){
      case 0:
        Navigator.pushNamedAndRemoveUntil(context,'/home', (route) => false, arguments: { 'id': id });
      case 1:
        Navigator.pushNamedAndRemoveUntil(context,'/profile', (route) => false, arguments: { 'id': id });
      case 2:
        Navigator.pushNamedAndRemoveUntil(context, '/community', (route) => false, arguments: { 'id': id });
      case 3:
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }
}