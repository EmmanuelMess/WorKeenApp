import 'package:flutter/material.dart';
import 'package:workeen/business_filter.dart';

import 'business_search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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