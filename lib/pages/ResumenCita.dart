import 'package:drplus/global/helper.dart';
import 'package:flutter/material.dart';

class ResumenCita extends StatelessWidget{

  const ResumenCita({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var id = arguments['id'];
    Helper helper = Helper(context);
    return MaterialApp(
      routes: helper.routes,
      home: Scaffold(
        body: ResumenCitaFull(id: id),
      ),
    );
  }

}

class ResumenCitaFull extends StatefulWidget{
  var id;
  ResumenCitaFull({Key? key, required this.id}) : super(key: key);


  @override
  _ResumenCitaState createState() => _ResumenCitaState();

}

class _ResumenCitaState extends State<ResumenCitaFull>{

  //? Inicializar variables
  late var id;
  //* Agregar sus valores
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context){

    //! Variables en este contexto
    Helper helper = Helper(context);
    var width = helper.getWidth();
    var height = helper.getHeight();

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.only(top: helper.height*0.05),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Resumen de cita",
            style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          //? Nombres del paciente
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Nombres del paciente:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "Alex Jesús Loayza Almeyda",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Edad del paciente
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Edad:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "21 años",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Dirrecion
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Dirección:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "Jr Andres Avelino áceres 157, Santa anita",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Género
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Género:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "Masculino",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Tipo de consulta y modalidad
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Consulta:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "Pediatría - Online",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Especialista 
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Especialista:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "Doctor Paco - Especialista en Pediatría",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Fecha de la cita
          Padding(
            padding: EdgeInsets.only(top: height*0.05, left: height*0.05, right: height*0.05),
            child: Row(
              children: [
                Text(
                  "Fecha de la cita:",
                  style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.035),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    "21/10/2023",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: width*0.028),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                )
              ],
            )
          ),
          //? Regreso al perfil
          Padding(padding: EdgeInsets.only(top: height*0.05)),
          InkWell(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false, arguments: {'id': id});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: width*0.8,
              decoration: BoxDecoration(color: helper.getThirdColor(), borderRadius: BorderRadius.circular(5)),
              child: const Text("De acuerdo", style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
            )
          )
      ])
    );
  }
}