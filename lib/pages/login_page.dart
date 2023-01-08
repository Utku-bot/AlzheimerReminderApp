import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatirla/pages/password_page.dart';
import 'package:hatirla/utils/colors.dart';
import '../widgets/my_button.dart';
import '../widgets/widget_text_button.dart';
import '../widgets/widget_text_field.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage( {Key? key,required this.showRegisterPage}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  Future signIn() async{
    showDialog(context: context,
        builder: (context) {
      return Center(child: CircularProgressIndicator(color: myColorButton2,),);
    });
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());

    Navigator.of(context).pop();
  }



@override
  void dispose() {  // ram kullanımı azaltmak için
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: myColorScaffold,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/png/brain.png",
                ),
                Text("Merhaba", style: Theme.of(context).textTheme.headline1),

                WidgetTextField(
                  obscure: false,
                  controller: _emailController,
                  textLabel: 'E-mail',
                  icon: const Icon(Icons.account_circle_sharp),
                ),
                WidgetTextField(
                  obscure: true,
                  controller: _passwordController,
                  textLabel: 'Şifre',
                  icon: const Icon(Icons.password_sharp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyTextButton(text: "Şifremi Unuttum",onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return PasswordPage();
                      }));
                    },
                    ),
                  ],
                ),
                MyButton(
                  height: 50,width: 300,
                  color: myColorButton,
                  text: "Giriş Yap",
                  onTap: signIn,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Text("Üye Değil misin?"),
                    MyTextButton(
                      text: 'Kayıt Ol',
                      onPressed: widget.showRegisterPage,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
