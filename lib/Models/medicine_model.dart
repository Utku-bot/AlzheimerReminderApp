import 'package:hive/hive.dart';
part 'medicine_model.g.dart';


@HiveType(typeId: 3)
class MedicineModel extends HiveObject{

  @HiveField(0)
  String? name;

  @HiveField(1)
  DateTime? time;

  @HiveField(3)
  String? usage;



MedicineModel({
    required this.time
  ,required this.name,
  required this.usage
});



}