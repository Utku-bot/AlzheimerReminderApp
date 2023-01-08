import 'package:flutter/material.dart';
import 'package:hatirla/pages/login_page.dart';

import '../pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  void toggleScreens(){
    setState(() {
      showLoginPage=!showLoginPage;
    });

  }

  bool showLoginPage = true;
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage:toggleScreens );
    } else {
      return  RegisterPage(showloginPage:toggleScreens);
      
    }
  }
}
