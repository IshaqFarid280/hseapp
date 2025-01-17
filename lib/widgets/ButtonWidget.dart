import 'package:flutter/material.dart';

class Buttonwidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const Buttonwidget({super.key, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
          shape: StadiumBorder(),

        ),

        onPressed: onClicked, child: FittedBox(child: Text(text, style: TextStyle(
      fontSize: 20,
      color: Colors.lightBlue
    ),)));
  }
}
