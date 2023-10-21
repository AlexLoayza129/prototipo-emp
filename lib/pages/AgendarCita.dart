import 'package:drplus/global/helper.dart';
import 'package:drplus/pages/CrearCuenta.dart';
import 'package:drplus/pages/Home.dart';
import 'package:drplus/pages/Login.dart';
import 'package:drplus/pages/Profile.dart';
import 'package:drplus/pages/ResumenCita.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class AgendarCita extends StatelessWidget {
  AgendarCita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var id = arguments['id']; 
    Helper helper = Helper(context);
    return MaterialApp(
      routes: helper.routes,
      home: _AgendarCita(id:id)
    );
  }


}

class _AgendarCita extends StatefulWidget {
  late int id;
  _AgendarCita({Key? key, required this.id}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<_AgendarCita> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _buttonState = false;
  bool _showMessage = false;
  bool _stateAccept = false;
  var id;

  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    
    Helper helper = Helper(context);
    var width = helper.getWidth();
    var height = helper.getHeight();

    String doctorName = "Doctor Paco Rivas";
    String doctorSpeciality = "Especializado en Pediatria";

    return  Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(width*0.08),
            width: width,
            height: height,
            color: const Color.fromARGB(255, 239, 243, 243),
            child: Column(children: <Widget>[
                Row(
                  children: [
                    //? Imagen
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "assets/doctor1.jpg",
                        width: width*0.2,
                      ),
                    ),
                    //? Descripcion
                    Container(
                      padding: EdgeInsets.only(left: width*0.02),
                      width: width*0.60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctorName, style: TextStyle(fontFamily: 'Schyler', fontSize: 14)),
                          Text(doctorSpeciality, style: TextStyle(fontFamily: 'Poppins', fontSize: 10, fontStyle: FontStyle.italic, color: helper.getPrimaryColor()))
                        ],
                      )
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height*0.05),
                ),
                TableCalendar(
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2023, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: height*0.05) 
                ),
                Text(
                  "Fecha de cita seleccionada: ${helper.getLocalDateFormat(_focusedDay)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)
                ),
                Padding(
                  padding: EdgeInsets.only(top: height*0.05) 
                ),
                if(!_buttonState)
                InkWell(
                  onTap: (){
                    helper.showAlertDialog(context, "Aceptación de Cita", "Está de acuerdo en aceptar la cita con el especialista ${doctorName} ${doctorSpeciality} para la fecha de ${helper.getLocalDateFormat(_focusedDay)}", '/dateResume',id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: width*0.8,
                    decoration: BoxDecoration(color: helper.getThirdColor(), borderRadius: BorderRadius.circular(5)),
                    child: Text("Agendar Cita", style: TextStyle(color: helper.getSecondaryColor()),  textAlign: TextAlign.center)
                  )
                ),
                Padding(padding: EdgeInsets.only(top: height*0.02)),
                InkWell(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: { 'id': id});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: width*0.8,
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
                    child: Text("Volver", style: TextStyle(color: helper.getSecondaryColor()),  textAlign: TextAlign.center)
                  )
                ),
                if(_buttonState)
                InkWell(
                  onTap: (){
                    setState(() {
                      _showMessage = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: width*0.8,
                    decoration: BoxDecoration(color: helper.getDisabledBgColor(), borderRadius: BorderRadius.circular(5)),
                    child: Text("Agendar Cita", style: TextStyle(color: helper.getDisabledTextColor()),  textAlign: TextAlign.center)
                  )
                ),
                if(_showMessage)
                Padding(
                  padding: EdgeInsets.only(top: height*0.05),
                  child: const Text("Aviso: Ya cuenta con una cita agendada!", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold))
                )
              ]),
          ),
        ),
      );
  }
}

