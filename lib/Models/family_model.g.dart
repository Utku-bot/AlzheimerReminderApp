// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyAdapter extends TypeAdapter<Family> {
  @override
  final int typeId = 0;

  @override
  Family read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Family(
      name: fields[0] as String?,
      picture: fields[2] as Uint8List?,
    )..age = fields[1] as int?;
  }

  @override
  void write(BinaryWriter writer, Family obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.picture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
