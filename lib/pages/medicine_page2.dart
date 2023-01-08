import 'package:flutter/material.dart';
import 'package:flutter_alarm_background_trigger/flutter_alarm_background_trigger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hatirla/Models/medicine_model.dart';
import 'package:hatirla/utils/colors.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import '../Services/alarm_services.dart';
import '../notifications/noti.dart';
import '../widgets/my_button.dart';
import '../widgets/widget_text_field.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


class MedicinePage2 extends StatefulWidget {
  MedicinePage2({Key? key}) : super(key: key);

  @override
  State<MedicinePage2> createState() => _MedicinePage2State();
}

class _MedicinePage2State extends State<MedicinePage2> {
  final medicineNameController = TextEditingController();
  final medicineUsageController = TextEditingController();
  DateTime dateTimeSelected = DateTime.now();

  AlarmItem? _alarmItem;
  DateTime? time;
  List<AlarmItem> alarms = [];

  var alarmPlugin = FlutterAlarmBackgroundTrigger();

  @override
  void initState() {
    Noti.initialize(flutterLocalNotificationsPlugin);
    reloadAlarms();

    AlarmService.instance.onForegroundAlarmEventHandler((alarmItem) {

      reloadAlarms();

    });





    super.initState();


  }
  reloadAlarms() {
    AlarmService.instance.getAllAlarms().then((alarmsList) => setState(() {
      alarms = alarmsList;

    }));

  }

  void createAlarm(String title,DateTime time,String usage) async {
    await AlarmService.instance
        .addAlarm(dateTimeSelected, uid: UniqueKey().toString(), payload: {"holy": "Moly"});

     alarmPlugin.requestPermission().then((isGranted){
      if(isGranted){
        alarmPlugin.onForegroundAlarmEventHandler((alarm){
         Noti.showBigTextNotification(title:  "İlaç Vakti", body: "${time.hour} ${time.minute} saatli $title ilacını $usage karnına almanız gerekmektedir", fln: flutterLocalNotificationsPlugin);

        });
      }
    });
    reloadAlarms();



  }

  void _openTimePickserSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        initialDateTime: DateTime.now(),

        sheetTitle: 'İlaç Zamanını Giriniz',
        minuteTitle: 'Dakika',
        hourTitle: 'Saat',
        saveButtonText: 'Kaydet',
        minuteInterval: 1,
        saveButtonColor: Colors.grey,
        sheetCloseIconColor: myColorScaffold,
      ),
    );

    if (result != null) {
      setState(() {
        dateTimeSelected = result;
        super.setState(() {});
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    Box<MedicineModel> medBox =
    Hive.box<MedicineModel>("medicine");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColorScaffold,
        title: Text("İlaç Listem"),
        centerTitle: true,
        actions: [
          MaterialButton(onPressed: (){
           medBox.clear();
          }, child: const Text("Tüm Listeyi Sil",style: TextStyle(fontSize: 10),),color: Colors.greenAccent,),
        ],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: myColorScaffold,
        tooltip: "İlaç Ekle",
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                titleTextStyle: Theme.of(context).textTheme.headline2,
                title: Text('İlaç Ekle'),
                actions: <Widget>[
                  Column(
                    children: [
                      WidgetTextField(
                        obscure: false,
                        controller: medicineNameController,
                        textLabel: 'İlaç İsmi',
                        icon: const Icon(Icons.person),
                      ),
                      WidgetTextField(
                        obscure: false,
                        controller: medicineUsageController,
                        textLabel: 'Aç/Tok',
                        icon: const Icon(Icons.person),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: MyButton(
                          height: 50,
                          width: 300,
                          color: myColorButton,
                          text: "İlaç Saatini Şeç",
                          onTap: () async {
                            _openTimePickserSheet(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyButton(
                        height: 50,
                        width: 300,
                        text: "Ekle",
                        color: myColorButton,
                        onTap: () {
                          setState(() {
                            String medName = medicineNameController.text.trim();
                            String medUsage =
                                medicineUsageController.text.trim();


                            medBox.add(MedicineModel(
                                time: dateTimeSelected,
                                name: medName,
                                usage: medUsage));

                            medicineNameController.clear();
                            medicineUsageController.clear();
                            createAlarm(medName,dateTimeSelected,medUsage);
                            Navigator.of(context).pop();
                          });
                        },
                      ),
                    ],
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          // implement GridView.builder
          child: ValueListenableBuilder(
            valueListenable: Hive.box<MedicineModel>("medicine").listenable(),
            builder: (context, box, _) {
              if (box.values.isEmpty) {
                return const Center(
                  child: Text("Liste Boş"),
                );
              } else {
                return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (BuildContext ctx, index) {
                      MedicineModel? res = box.getAt(index);
                      MedicineModel? response = res;

                      return Dismissible(
                        onDismissed: (direction){
                          res?.delete();
                          box.delete(res?.key);


                        },
                        key: UniqueKey(),
                        child: Card(
                          elevation: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          child: Container(

                            decoration: const BoxDecoration(color: myColorButton),
                            child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: BoxDecoration(
                                      border:  Border(
                                          right:  BorderSide(width: 1.0, color: Colors.white24))),
                                  child: const Icon(Icons.health_and_safety, color: Colors.white),
                                ),
                                title:  Text(
                                  "${response?.name}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Row(
                                  children:  <Widget>[
                                    Text("${response?.usage} karnına", style: TextStyle(color: Colors.white))
                                  ],
                                ),
                                trailing:
                                 Text("${response?.time?.hour} ${response?.time?.minute}")),
                          ),
                        ),
                      );
                    });
              }
            },
          )),
    );
  }
}

