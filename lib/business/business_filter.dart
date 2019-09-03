import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workeen/business/business_search.dart';

class _BusinessFilterPeopleState extends State<BusinessFilterPeopleScreen> {
  final List<String> _sexes = ['Indiferente', 'Hombre', 'Mujer'];
  final _formKey = GlobalKey<FormState>();

  FocusNode specialtyFocusNode;
  FocusNode searchFocusNode;

  final specialtyController = TextEditingController();

  var _expirienceMinSelected = 0;
  var _expirienceMaxSelected = 70;
  var _ageMinSelected = 16;
  var _ageMaxSelected = 100;

  int _selectedSex = 0;
  int _selectedGender = 0;

  @override
  void initState() {
    super.initState();

    specialtyFocusNode = FocusNode();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    specialtyFocusNode.dispose();
    searchFocusNode.dispose();

    specialtyController.dispose();

    super.dispose();
  }

  Widget _showField(String title, Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          child,
        ],
      ),
    );
  }

  Widget _showFilter() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 32, 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _showField(
              "Especialidad",
              TextFormField(
                focusNode: specialtyFocusNode,
                autofocus: true,
                controller: specialtyController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ingrese una especialidad';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).requestFocus(searchFocusNode),
              ),
            ),
            _showField(
              "Años de experiencia",
              RangeSlider(
                values: RangeValues(_expirienceMinSelected.toDouble(), _expirienceMaxSelected.toDouble()),
                min: 0.0,
                max: 70.0,
                divisions: 70,
                labels: RangeLabels("$_expirienceMinSelected años", "$_expirienceMaxSelected años"),
                onChanged: (range) {
                  setState(() {
                    _expirienceMinSelected = range.start.toInt();
                    _expirienceMaxSelected = range.end.toInt();
                  });
                },
              ),
            ),
            _showField(
              "Edad",
              RangeSlider(
                values: RangeValues(_ageMinSelected.toDouble(), _ageMaxSelected.toDouble()),
                min: 16.0,
                max: 100.0,
                divisions: 100-16,
                labels: RangeLabels("$_ageMinSelected años", "$_ageMaxSelected años"),
                onChanged: (range) {
                  setState(() {
                    _ageMinSelected = range.start.toInt();
                    _ageMaxSelected = range.end.toInt();
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _showField(
                  "Sexo",
                  DropdownButton<int>(
                    value: _selectedSex,
                    items: List.generate(_sexes.length, (int i) {
                      return DropdownMenuItem(
                        value: i,
                        child: new Text(_sexes[i]),
                      );
                    }),
                    onChanged: (elem) => setState(() => _selectedSex = elem),
                  ),
                ),
                _showField(
                  "Genero",
                  DropdownButton<int>(
                    value: _selectedGender,
                    items: List.generate(['Indiferente'].length, (int i) {
                      return DropdownMenuItem(
                        value: i,
                        child: new Text(['Indiferente'][i]),
                      );
                    }),
                    onChanged: (elem) => setState(() => _selectedGender = elem),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                focusNode: searchFocusNode,
                child: Text('Buscar'),
                focusColor: ThemeData.light().primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pushNamed(
                        context,
                        BusinessSearchPeopleScreen.routeName,
                        arguments: PersonFilter(
                          specialtyController.text,
                        )
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                "¿A quien buscas?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            _showFilter(),
          ],
        )),
      ),
    );
  }
}

class BusinessFilterPeopleScreen extends StatefulWidget {
  BusinessFilterPeopleScreen({Key key, this.title}) : super(key: key);

  static const String routeName = "/buisnessFilter";

  final String title;

  @override
  _BusinessFilterPeopleState createState() => new _BusinessFilterPeopleState();
}
