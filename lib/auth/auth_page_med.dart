import 'package:flutter/material.dart';


import '../pages/medicine_page2.dart';

class AuthPageMed extends StatefulWidget {
   AuthPageMed({Key? key,}) : super(key: key);



  @override
  _AuthPageMedState createState() => _AuthPageMedState();
}

class _AuthPageMedState extends State<AuthPageMed> {

  @override
  Widget build(BuildContext context) {

      return MedicinePage2();

  }
}
