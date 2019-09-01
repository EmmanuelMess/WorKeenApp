import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workeen/business_search.dart';

class BusinessFilterPeopleScreen extends StatefulWidget {
  BusinessFilterPeopleScreen({Key key, this.title}) : super(key: key);

  static const String routeName = "/buisnessFilter";

  final String title;

  @override
  _BusinessFilterPeopleState createState() => new _BusinessFilterPeopleState();
}

class _BusinessFilterPeopleState extends State<BusinessFilterPeopleScreen> {
  final List<String> _sexes = ['Indiferente', 'Hombre', 'Mujer'];
  final _formKey = GlobalKey<FormState>();

  FocusNode specialtyFocusNode;
  FocusNode expirienceFocusNode;
  FocusNode ageFocusNode;
  FocusNode sexFocusNode;
  FocusNode genderFocusNode;

  final specialtyController = TextEditingController();
  final expirienceController = TextEditingController();
  final ageController = TextEditingController();

  int _selectedSex = 0;
  int _selectedGender = 0;

  @override
  void initState() {
    super.initState();

    specialtyFocusNode = FocusNode();
    expirienceFocusNode = FocusNode();
    ageFocusNode = FocusNode();
    sexFocusNode = FocusNode();
    genderFocusNode = FocusNode();
  }

  @override
  void dispose() {
    specialtyFocusNode.dispose();
    expirienceFocusNode.dispose();
    ageFocusNode.dispose();
    sexFocusNode.dispose();
    genderFocusNode.dispose();

    specialtyController.dispose();
    expirienceController.dispose();
    ageController.dispose();

    super.dispose();
  }

  Widget _showFilter(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 32, 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              focusNode: specialtyFocusNode,
              autofocus: true,
              decoration: InputDecoration(hintText: 'Especialidad'),
              controller: specialtyController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingrese una especialidad';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).requestFocus(expirienceFocusNode),
            ),
            TextFormField(
              focusNode: expirienceFocusNode,
              decoration: InputDecoration(hintText: 'Años de experiencia'),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: expirienceController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).requestFocus(ageFocusNode),
            ),
            TextFormField(
              focusNode: ageFocusNode,
              decoration: InputDecoration(hintText: 'Edad'),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: ageController,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                setState(() {
                  FocusScope.of(context).requestFocus(sexFocusNode);
                  _selectedSex = _selectedSex;
                });
              },
            ),
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
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                child: Text('Buscar'),
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
                "Filtros",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            _showFilter(context),
          ],
        )),
      ),
    );
  }
}
