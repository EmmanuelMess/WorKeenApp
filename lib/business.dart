import 'package:flutter/material.dart';
import 'package:workeen/business_search.dart';

class BusinessFilterPeopleScreen extends StatelessWidget {
  Widget _showFilter(BuildContext context) {
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
            _showFilter(context),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                child: Text('Buscar'),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    BusinessSearchPeopleScreen.routeName,
                    arguments: PersonFilter(
                      "Escritor",
                    )
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
