import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workeen/utils/widget_utils.dart';
import 'package:faker/faker.dart';

import '../colors.dart';
import 'possible_employee.dart';

class _BusinessSearchPeopleState extends State<BusinessSearchPeopleScreen> with SingleTickerProviderStateMixin {
  final List<PossibleEmployee> people = List.from(Iterable.generate(
    500,
    (index) => PossibleEmployee(
        faker.person.name(),
        faker.randomGenerator.integer(45, min: -1),
        faker.randomGenerator.integer(70),
        faker.randomGenerator.integer(2, min: -1),
        faker.randomGenerator.integer(3),
    ),
  ));

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

  String _specialty = "";
  bool _showFilter = false;
  AnimationController _filterAnimationController;
  final Duration _duration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    specialtyFocusNode = FocusNode();
    searchFocusNode = FocusNode();

    _filterAnimationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: _duration,
    );
  }

  @override
  void didUpdateWidget(BusinessSearchPeopleScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    _filterAnimationController.duration = _duration;
  }

  @override
  void dispose() {
    specialtyFocusNode.dispose();
    searchFocusNode.dispose();

    specialtyController.dispose();
    _filterAnimationController.dispose();

    super.dispose();
  }

  void _modifyFilterVisibility() async {
    try {
      setState(() {
        _showFilter = !_showFilter;
      });

      if (_showFilter) {
        await _filterAnimationController
            .forward()
            .orCancel;
      } else {
        await _filterAnimationController
            .reverse()
            .orCancel;
      }
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  Widget _contentFilter() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 32, 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            WidgetUtils.showField(
              "Especialidad",
              TextFormField(
                focusNode: specialtyFocusNode,
                //TODO autofocus: true,
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
            WidgetUtils.showField(
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
            WidgetUtils.showField(
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
                WidgetUtils.showField(
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
                WidgetUtils.showField(
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
                    setState(() {
                      _specialty = specialtyController.text;
                    });
                    _modifyFilterVisibility();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _personWidget(BuildContext context, PossibleEmployee person) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text("${person.name} (${person.sex == 0? "hombre":"mujer"}), ${person.age} años"),
      subtitle: Text("Experiencia: ${person.expirience} años"),
      onTap: () => {

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<PossibleEmployee> filtered = List.from(people);
    filtered.removeWhere((possibleEmployee) {
      return !(_expirienceMinSelected <= possibleEmployee.expirience
          && possibleEmployee.expirience <= _expirienceMaxSelected
          && _ageMinSelected <= possibleEmployee.age
          && possibleEmployee.age <= _ageMaxSelected
          && (_selectedSex == 0 || _selectedSex == (possibleEmployee.sex+1)));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("W"),
        backgroundColor: ColorsApp.empresas,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$_specialty",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _modifyFilterVisibility,
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: _duration,
            transitionBuilder: (Widget child, Animation<double> animation) =>
              SizeTransition(
                child: child,
                sizeFactor: CurvedAnimation(
                  parent: _filterAnimationController,
                  curve: Curves.fastOutSlowIn
                ),
              ),
            child: Container(
              key: ValueKey<bool>(_showFilter),
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
                  _contentFilter(),
                ],
              )),
            ),
          ),
          Visibility(
            visible: !_showFilter,
            child: Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, position) => _personWidget(context, filtered[position]),
              )
            ),
          ),
        ],
      )
    );
  }
}

class BusinessSearchPeopleScreen extends StatefulWidget {
  BusinessSearchPeopleScreen({Key key, this.title}) : super(key: key);

  static const routeName = '/businessSearch';

  final String title;

  @override
  _BusinessSearchPeopleState createState() => new _BusinessSearchPeopleState();
}
