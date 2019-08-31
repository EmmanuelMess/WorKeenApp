import 'package:flutter/material.dart';

class BusinessRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workeen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BusinessFilterPage(title: 'Pagina principal'),
    );
  }
}

class BusinessFilterPage extends StatefulWidget {
  BusinessFilterPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _BusinessFilterPageState createState() => _BusinessFilterPageState();
}

class _BusinessFilterPageState extends State<BusinessFilterPage> {
  Widget _showFilter() {
    List<FocusNode> foucuses = [FocusNode(), FocusNode(), FocusNode(), FocusNode()];

    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 32, 24),
      child: Form(child:Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: 'Trabajo'),
            autofocus: true,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(foucuses[0]);
            },
          ),
          TextFormField(
            focusNode: foucuses[0],
            decoration: InputDecoration(hintText: 'Años de experiencia'),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(foucuses[1]);
            },
          ),
          TextFormField(
            focusNode: foucuses[1],
            decoration: InputDecoration(hintText: 'Edad'),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(foucuses[2]);
            },
          ),
          TextFormField(
            focusNode: foucuses[2],
            decoration: InputDecoration(hintText: 'Sexo'),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(foucuses[3]);
            },
          ),
          TextFormField(
            focusNode: foucuses[3],
            decoration: InputDecoration(hintText: 'Genero'),
            textInputAction: TextInputAction.done,
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("W"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, top: 24, right: 16),
              child: Text(
                "Filtros",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            _showFilter(),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                child: Text('Buscar'),
                onPressed: () {

                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
