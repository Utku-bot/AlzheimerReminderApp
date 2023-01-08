import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'family_model.g.dart';


@HiveType(typeId: 0)
class Family extends HiveObject{


@HiveField(0)
  String? name;

@HiveField(1)
  int? age;

@HiveField(2)
 Uint8List? picture;

 Family({
  required this.name,required this.picture

});



}