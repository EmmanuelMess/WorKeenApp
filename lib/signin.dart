import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workeen/business/business_search.dart';
import 'package:workeen/utils/widget_utils.dart';

class _SignInState extends State<SignInScreen> {
  final List<String> _sexes = ['Indiferente', 'Hombre', 'Mujer'];
  final _formKey = GlobalKey<FormState>();

  FocusNode usernameFocusNode;
  FocusNode passwordFocusNode;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    usernameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();

    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget _showFilter() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 32, 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            WidgetUtils.showField(
              "Nombre de usuario / email",
              TextFormField(
                focusNode: usernameFocusNode,
                autofocus: true,
                controller: usernameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ingrese un nombre de usuario';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                onEditingComplete: () => FocusScope.of(context).requestFocus(passwordFocusNode),
              ),
            ),
            WidgetUtils.showField(
              "Contraseña",
              TextFormField(
                focusNode: passwordFocusNode,
                obscureText: true,
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Ingrese una contraseña';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                onEditingComplete: () {

                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: RaisedButton(
                focusNode: passwordFocusNode,
                child: Text('Iniciar sesión'),
                focusColor: ThemeData.light().primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {

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
        textTheme: ThemeData.light().textTheme,
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
                  "Iniciar sesión",
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

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key, this.title}) : super(key: key);

  static const String routeName = "/signInRoute";

  final String title;

  @override
  _SignInState createState() => new _SignInState();
}
