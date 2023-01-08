import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';
import 'package:hatirla/widgets/my_button.dart';

import '../widgets/widget_text_field.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
_emailController.dispose();
    super.dispose();
  }
  Future passwordReset()async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());


    }on FirebaseAuthException catch (e){

      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString(),style: TextStyle(color: Colors.black26),),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColorScaffold,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "E-mail giriniz. Size şifre yenileme maili gönderilecektir",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: WidgetTextField(
                obscure: false,
                controller: _emailController,
                textLabel: 'E-mail',
                icon: const Icon(Icons.account_circle_sharp),
              ),
            ),
            MyButton(
              height: 50,width: 300,
              color: myColorButton,
              text: "Şifreyi Yenile",
              onTap: passwordReset,
            ),
          ],
        ),
      ),
    );
  }
}
