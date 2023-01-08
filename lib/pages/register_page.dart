
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/my_button.dart';
import '../widgets/widget_text_button.dart';
import '../widgets/widget_text_field.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showloginPage;

  const RegisterPage({Key? key, required this.showloginPage}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassWordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameWordController = TextEditingController();
  final _ageController = TextEditingController();


  @override
  void dispose() {
    // ram kullanımı azaltmak için
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassWordController.dispose();
    _ageController.dispose();
    _firstNameController.dispose();
    _lastNameWordController.dispose();
    super.dispose();
  }
  Future addUserDetails(String firstName,String lastName,String email,int age) async{
    await FirebaseFirestore.instance.collection("users").add({
      'first name' : firstName,
      'last name' : lastName,
      'age' : age,
      'email' : email,
      'count' : 1
    });

  }
  Future signUp() async {
    if ( passwordConfirmed()) {
      // kullanıcı oluşturma
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      // kullanıcı bilgileri

      addUserDetails(_firstNameController.text.trim(), _lastNameWordController.text.trim(), _emailController.text.trim(), int.parse(_ageController.text.trim()));

    }
      }
  bool passwordConfirmed(){
    if (_passwordController.text.trim()==_confirmPassWordController.text.trim()) {
      return true;
    } else {
      return false;
      
    }
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Image.asset(
                  "assets/png/brain.png",
                  width: 100,
                  height: 80,
                ),
                Text("Kayıt Ol", style: Theme.of(context).textTheme.headline2),

                WidgetTextField(
                  obscure: false,
                  controller: _firstNameController,
                  textLabel: 'Ad',
                  icon: const Icon(Icons.account_circle_sharp),
                ),WidgetTextField(
                  obscure: false,
                  controller: _lastNameWordController,
                  textLabel: 'Soyad',
                  icon: const Icon(Icons.account_circle_sharp),
                ),WidgetTextField(
                  obscure: false,
                  controller: _ageController,
                  textLabel: 'Yaş',
                  icon: const Icon(Icons.account_circle_sharp),
                ),
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
                WidgetTextField(
                    textLabel: "Şifre Onayı",
                    icon: const Icon(Icons.password_outlined),
                    obscure: true,
                    controller: _confirmPassWordController),

                SizedBox(
                  height: 20,
                ),
                MyButton(
                  height: 50,width: 300,
                  color: myColorButton,
                  text: "Kayıt Ol",
                  onTap: signUp,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text("Zaten Üyeyim"),
                    MyTextButton(
                      text: 'Giriş Yap',
                      onPressed: widget.showloginPage,
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
    ));
  }
}
