import 'package:flutter/material.dart';
import 'package:hatirla/utils/colors.dart';
import 'package:hive_flutter/adapters.dart';

import '../Models/todo_model.dart';
import '../widgets/my_button.dart';
import '../widgets/widget_text_field.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final todoController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Box<Todo> todoBox = Hive.box<Todo>("todo");
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(onPressed: (){
            todoController.clear();
          }, child: const Text("Tüm Listeyi Sil",style: TextStyle(fontSize: 10),),color: myColorScaffold2,),
        ],
        backgroundColor: myColorScaffold,
        title: Text("Görevlerim"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: myColorScaffold,
        tooltip: "Görev Ekle",
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                titleTextStyle: Theme.of(context).textTheme.headline2,
                title: Text('Görev Ekle'),
                actions: <Widget>[
                  Column(
                    children: [
                      WidgetTextField(
                        obscure: false,
                        controller: todoController,
                        textLabel: 'Görev',
                        icon: const Icon(Icons.person),
                      ),


                      SizedBox(height: 20,),
                      MyButton(
                        height: 50,
                        width: 300,
                        text: "Ekle",
                        color: myColorButton,
                        onTap: () {
                          setState(() {
                            String todo = todoController.text.trim();


                            todoBox.add(Todo(
                                todo: todo,
                              done: false

                            ));

                            todoController.clear();
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
            valueListenable: Hive.box<Todo>("todo").listenable(),
            builder: (context, box, _) {
              if (box.values.isEmpty) {
                return const Center(
                  child: Text("Liste Boş"),
                );
              } else {
                return ListView.builder(

                    itemCount: box.values.length,
                    itemBuilder: (BuildContext ctx, index) {
                      Todo? res = box.getAt(index);
                      Todo? response = res;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          onDismissed: (direction) {
                            res?.delete();
                          },
                          key: UniqueKey(),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: myColorButton,
                              borderRadius:const BorderRadius.all(Radius.elliptical(20,40)),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              Text("${response?.todo}"),
                                IconButton(onPressed: (){
                                 setState(() {

                                   if (res?.done==true) {
                                     res?.done=false;
                                   } else {
                                     res?.done=true;

                                   }

                                   Hive.box<Todo>('todo').putAt(index, res!);

                                 });
                                }, icon: response?.done == true
                                    ? Icon(Icons.done_all)
                                    : Icon(Icons.done))

                            ],)
                          )
                        ),
                      );
                    });
              }
            },
          )),
    );
  }
}



