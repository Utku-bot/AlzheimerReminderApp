

import 'package:hive/hive.dart';
part 'todo_model.g.dart';


@HiveType(typeId: 1)
class Todo extends HiveObject{


  @HiveField(0)
  String? todo;

  @HiveField(1)
  bool done = false;



  Todo({
    required this.todo, required this.done,
  });



}