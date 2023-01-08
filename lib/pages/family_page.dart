import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import '../Models/family_model.dart';
import '../widgets/my_button.dart';
import '../widgets/widget_text_field.dart';

class FamilyPage extends StatefulWidget {
  FamilyPage({Key? key}) : super(key: key);

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  final nameController = TextEditingController();
  late File dosya;
  late var dosya2;


  final ageController = TextEditingController();

  void _secimYukle(ImageSource source) async {
    final picker = ImagePicker();
    final secilen = await picker.pickImage(source: source);


    setState(() {
      if (secilen != null) {
     dosya = File(secilen.path);
     dosya2 = dosya.readAsBytesSync();

      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColorScaffold,
        title: Text("Ailem"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: myColorScaffold,
        tooltip: "Kişi Ekle",
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                titleTextStyle: Theme.of(context).textTheme.headline2,
                title: Text('Kişi Ekle'),
                actions: <Widget>[
                  Column(
                    children: [
                      WidgetTextField(
                        obscure: false,
                        controller: nameController,
                        textLabel: 'Kişi Adı',
                        icon: const Icon(Icons.person),
                      ),

                      MyButton(color: myColorButton, text: "Fotograf Ekle", width: 300, height: 50,onTap: (){

                        _secimYukle(ImageSource.gallery);
                      }

                        ,),
                      SizedBox(height: 20,),
                      MyButton(
                        height: 50,
                        width: 300,
                        text: "Ekle",
                        color: myColorButton,
                        onTap: () {
                          setState(() {
                            String name = nameController.text.trim();


                            Box<Family> familyBox = Hive.box<Family>("family");
                            familyBox.add(Family(
                                name: name,

                                picture: dosya2

                            ));

                            nameController.clear();

                            ageController.clear();

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
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          // implement GridView.builder
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Family>("family").listenable(),
            builder: (context, box, _) {
              if (box.values.isEmpty) {
                return const Center(
                  child: Text("Liste Boş"),
                );
              } else {
                return ListView.builder(

                    itemCount: box.values.length,
                    itemBuilder: (BuildContext ctx, index) {
                      Family? res = box.getAt(index);
                      final response = res;
                      var bitList = response?.picture;
                      return Dismissible(
                          onDismissed: (direction) {
                            res?.delete();
                          },
                          key: UniqueKey(),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.asset("assets/png/frame.png",width: 300,height: 300,),
                                Container( width: 240,height: 130,
                                    child:
                                    Image.memory(bitList!, fit: BoxFit.fitWidth ),

                                    
                                ),

                            ],
                            ),
                              Text("${response?.name}",style: Theme.of(context).textTheme.headline4,),

                              Divider(color: Colors.grey,height: 12,)

                            ],

                          ),
                      );
                    });
              }
            },
          )),
    );
  }
}

