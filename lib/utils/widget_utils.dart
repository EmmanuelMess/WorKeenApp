import 'package:flutter/widgets.dart';

class WidgetUtils {
  static Widget showField(String title, Widget child) {
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
}