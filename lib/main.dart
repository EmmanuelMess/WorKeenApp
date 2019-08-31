import 'package:flutter/material.dart';
import 'package:workeen/business.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                "W",
                textScaleFactor: 10,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  child: Text("SOY EMPRESA"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BusinessFilterPeopleScreen()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text("SOY PERSONA"),
                  onPressed: () {

                  },
                ),
              ],
            ),
            Center(
              child: FlatButton(
                child: Text("Iniciar sesión"),
                onPressed: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
