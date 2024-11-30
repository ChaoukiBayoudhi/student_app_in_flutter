// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAdapter extends TypeAdapter<Student> {
  @override
  final int typeId = 0;

  @override
  Student read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Student(
      id: fields[0] as int,
      name: fields[1] as String,
      familyName: fields[2] as String,
      birthday: fields[3] as DateTime,
      level: fields[4] as StudentLevel,
      marks: (fields[5] as List?)?.cast<Mark>(),
      photo: fields[6] as String?,
      guard: fields[7] as StudentGuard,
    );
  }

  @override
  void write(BinaryWriter writer, Student obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.familyName)
      ..writeByte(3)
      ..write(obj.birthday)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.marks)
      ..writeByte(6)
      ..write(obj.photo)
      ..writeByte(7)
      ..write(obj.guard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
