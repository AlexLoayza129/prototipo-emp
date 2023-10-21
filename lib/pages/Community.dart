import 'package:drplus/global/helper.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget{

  Community({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Helper helper = Helper(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    var id = arguments['id'];
    return MaterialApp(
      routes: helper.routes,
      home: _Community(id:id)
    );
  }

}

class _Community extends StatefulWidget{
  var id;

  _Community({Key? key, required this.id}) : super(key: key);

  @override
  State<_Community> createState() => _CommunityState();

}

class _CommunityState extends State<_Community>{

  var width;
  var height;
  late var id;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 2;
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
                    Text("Comunidad", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold, fontSize: width*0.04))
                  ]
                )
            ),
            Padding(padding: EdgeInsets.only(top: height*0.05)),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //? Mensaje de doctor Ricardo
                  Text("Doctor Ricardo - Mexico", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: height*0.01),
                    padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.02),
                    child: Text("Entonces necesitabas ayuda con algo Doctor Paco? "), 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,1.0),
                          blurRadius: 6.0
                        )
                      ]
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: height*0.03)),
                  //? Mensaje de doctor Carlos Mendoza
                  Text("Doctor Carlos Mendoza - Colombia", style: TextStyle(color: helper.getThirdColor(), fontWeight: FontWeight.bold),),
                  Container(
                    margin: EdgeInsets.only(top: height*0.01),
                    padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.02),
                    child: Text("Hola a todos!"), 
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,1.0),
                          blurRadius: 6.0
                        )
                      ]
                    )
                  ),
              ]) 
            )
          ]
        ),
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
        ),
    );
  }

  void _onItemTapped(int index) {
      Helper helper = Helper(context);
        setState(() {
          _selectedIndex = index;
        });
        helper.redirectTo(_selectedIndex, context, id);
  }

}