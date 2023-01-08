import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatefulWidget {
  GetUserData({Key? key, required this.documentId}) : super(key: key);
  final String documentId;




  @override
  State<GetUserData> createState() => GetUserDataState();
}

class GetUserDataState extends State<GetUserData> {


  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.documentId).get(),
        builder: ((context, snapshot) {

      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        //Text("Ad:  ${data["first name"]} Soyad: ${data["last name"] } Yaş: ${data["age"]}");


        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.supervised_user_circle_sharp,size: 30,),
                  Text("${data["first name"]} ${data["last name"]}",style: TextStyle(fontSize: 30),),
                ],
              ),
              Container(color: Colors.grey,height: 1,width: MediaQuery.of(context).size.width,),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.numbers,size: 30,),
                  Text("${data["age"]}",style: TextStyle(fontSize: 30),),
                ],
              ),
              SizedBox(height: 20,),
              Container(color: Colors.grey,height: 1,width: MediaQuery.of(context).size.width,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.mail_lock,size: 30,),
                  Text("${data["email"]}",style: TextStyle(fontSize: 30),),
                ],
              ),
              SizedBox(height: 20,),
              Container(color: Colors.grey,height: 1,width: MediaQuery.of(context).size.width,)


            ],
            ),
        );
      }
      return Text("Yükleniyor");
    }));
  }
}
