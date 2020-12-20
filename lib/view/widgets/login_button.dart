import 'package:flutter/material.dart';

import 'customs.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final Function onPress;
  LoginButton(this.title, this.onPress);

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColor = [
      Theme.of(context).primaryColor,
      Theme.of(context).accentColor
    ];
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            customBoxShadow,
          ],
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.centerRight,
              colors: gradientColor)),
      child: FlatButton(
        onPressed: onPress,
        child: Text(
          title.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}