import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onClicked;

  ButtonWidget({this.onClicked, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: Text(
        "$text",
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all((10.0)),
        primary: Colors.white,
      ),
    );
  }
}
