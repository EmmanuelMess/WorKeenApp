import 'package:flutter/material.dart';
import 'package:workeen/business_filter.dart';

import 'business_search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workeen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        BusinessFilterPeopleScreen.routeName: (context) => BusinessFilterPeopleScreen(),
        BusinessSearchPeopleScreen.routeName: (context) => BusinessSearchPeopleScreen(),
      },
      home: IntroPage(title: 'Pagina principal'),
    );
  }
}

class IntroPage extends StatefulWidget {
  IntroPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: _SlashedBackground(),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    "W",
                    textScaleFactor: 10,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      child: Text("BUSCAR EMPLEADOS"),
                      color: Color.fromARGB(255, 251, 251, 251),
                      onPressed: () {
                        Navigator.pushNamed(context, BusinessFilterPeopleScreen.routeName);
                      },
                    ),
                    RaisedButton(
                      child: Text("BUSCAR EMPLEO"),
                      color: Color.fromARGB(255, 251, 251, 251),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
                Center(
                  child: FlatButton(
                    child: Text("Iniciar sesión"),
                    textColor: Color.fromARGB(255, 251, 251, 251),
                    onPressed: () {

                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

class _SlashedBackground extends CustomPainter {
  final _leftPaint = Paint()
    ..color = Color.fromARGB(255, 0, 148, 128);

  final _rightPaint = Paint()
    ..color = Color.fromARGB(255, 0, 176, 222);

  @override
  void paint(Canvas canvas, Size size) {
    final _leftPath = Path()
      ..addPolygon([
        Offset(0, 0),
        Offset(size.width*0.30, 0),
        Offset(size.width*0.70, size.height),
        Offset(0, size.height),
      ], true);

    final _rightPath = Path()
      ..addPolygon([
        Offset(size.width*0.30, 0),
        Offset(size.width, 0),
        Offset(size.width, size.height),
        Offset(size.width*0.70, size.height),
      ], true);

    canvas.drawPath(_leftPath, _leftPaint);
    canvas.drawPath(_rightPath, _rightPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}