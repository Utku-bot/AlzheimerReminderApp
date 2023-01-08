import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hatirla/pages/family_page.dart';
import 'package:hatirla/pages/quiz_page.dart';
import 'package:hatirla/pages/todo_page.dart';
import 'package:hatirla/pages/user_data_page.dart';
import 'package:hatirla/utils/colors.dart';
import '../auth/auth_page_med.dart';
import '../notifications/noti.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;


  final userEmail = FirebaseAuth.instance.currentUser?.email;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  List<String> docIds = [];
  late int count;

  Future getDocIds() async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: user?.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((documents) {
      docIds.add(documents.reference.id);

    }));
  }



  @override
  void initState() {
    getDocIds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: myColorScaffold,
        title: Text(
          "$userEmail" ,
          style: TextStyle(fontSize: 15),
        ),
        actions: [
          AppBarButton(),
        ],
      ),
      backgroundColor: myColorScaffold2,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                MyButton2(
                  color: myColorButton,
                  width: 150,
                  height: 150,
                  icon: const Icon(Icons.person),
                  widget: const Text(
                    "Kullanıcı Bilgileri",
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  UserDataPage(docId: docIds.first)),
                    );
                  },
                ),
                MyButton2(
                  color: myColorButton,
                  width: 150,
                  height: 150,
                  icon: const Icon(Icons.list),
                  widget: const Text("Görevlerim"),
                  onTap: (){

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>   TodoPage()
                        ));
                  },
                ),
              ],
            ),
            MyButton2(
              color: myColorButton,
              width: 150,
              height: 150,
              icon: const Icon(Icons.medical_information_outlined),
              widget: const Text("İlaç Listem"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  AuthPageMed()),
                );
            }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton2(
                  color: myColorButton,
                  width: 150,
                  height: 150,
                  icon: const Icon(Icons.quiz),
                  widget: const Text("Quiz"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const QuizPage()),
                    );
                  },
                ),
                MyButton2(
                  color: myColorButton,
                  width: 150,
                  height: 150,
                  icon: const Icon(Icons.photo_album_outlined),
                  widget: const Text("Aile Albümüm"),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>   FamilyPage()
                    ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
      },
      color: myColorButton,
      textColor: myColorScaffold2,
      child: Text(
        "Çıkış Yap",
      ),
    );
  }
}
class MyButton2 extends StatelessWidget {
  MyButton2({
    required this.color,
    required this.widget,
    required this.icon,
    required this.width,
    required this.height,
    Key? key,
    this.onTap,
  }) : super(key: key);
  Color color;

  final onTap;
  double height;
  double width;
  Icon icon;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.elliptical(20, 40)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [icon, widget],
        ),
      ),
    );
  }
}
