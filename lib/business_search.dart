import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonFilter {
  final String specialty;

  PersonFilter(this.specialty);
}

class BusinessSearchPeopleScreen extends StatelessWidget {
  static const routeName = '/businessSearch';

  Widget _personWidget(BuildContext context, int person) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text('Persona'),
      onTap: () => {

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final PersonFilter filter = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("W"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(filter.specialty),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, position) => _personWidget(context, position)
            )
          ),
        ],
      )
    );
  }
}
