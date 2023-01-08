import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  MyTextButton({
    required this.text,
    Key? key,this.onPressed
  }) : super(key: key);
  String text;
  var onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
                style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}