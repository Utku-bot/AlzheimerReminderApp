import 'package:flutter/material.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:hatirla/Models/db_connect.dart';
import 'package:hatirla/Models/family_model.dart';
import 'package:hatirla/Models/medicine_model.dart';
import 'package:hatirla/Models/todo_model.dart';
import 'package:hatirla/auth/main_page.dart';
import 'package:hatirla/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';





Future main() async{
  WidgetsFlutterBinding.ensureInitialized();

  FlutterAlarmBackgroundTrigger.initialize();
  await Hive.initFlutter();


  Hive.registerAdapter(FamilyAdapter());
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(MedicineModelAdapter());
  await Hive.openBox<Todo>("todo");
  await Hive.openBox<Family>("family");
  await Hive.openBox<MedicineModel>("medicine");
  await Firebase.initializeApp();

  var db  = DBconnect();

  db.fetchQuestions();


  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonColor: myColorButton2,
        cardColor: myColorCard,
        textTheme: TextTheme(
          headline3: const TextStyle(color: Colors.white),
            headline1: TextStyle(
                color: myColorScaffold2,
                fontSize: 70,
                fontWeight: FontWeight.normal),
            subtitle1: TextStyle(
                color: myColorScaffold2,
                fontSize: 15,
                fontWeight: FontWeight.normal)),
      ),
      home: const MainPage(),
    );
  }
}
