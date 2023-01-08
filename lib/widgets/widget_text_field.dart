import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';

class WidgetTextField extends StatelessWidget {
   WidgetTextField({
    required this.textLabel,required this.icon,required this.obscure,
    Key? key, required this.controller,
  }) : super(key: key);
  String textLabel;
  Widget icon;
  final controller;
  bool obscure;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextField(
        style: Theme.of(context).textTheme.labelMedium,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: icon,
            labelText: textLabel,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color:myColorScaffold,
                  width: 3,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                  color:Theme.of(context).highlightColor,
                  width: 3,
                )
            ),
          )
      ),
    );
  }
}
