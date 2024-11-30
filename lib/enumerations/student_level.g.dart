// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentLevelAdapter extends TypeAdapter<StudentLevel> {
  @override
  final int typeId = 1;

  @override
  StudentLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StudentLevel.primary;
      case 1:
        return StudentLevel.secondary;
      case 2:
        return StudentLevel.highSchool;
      case 3:
        return StudentLevel.college;
      case 4:
        return StudentLevel.university;
      default:
        return StudentLevel.primary;
    }
  }

  @override
  void write(BinaryWriter writer, StudentLevel obj) {
    switch (obj) {
      case StudentLevel.primary:
        writer.writeByte(0);
        break;
      case StudentLevel.secondary:
        writer.writeByte(1);
        break;
      case StudentLevel.highSchool:
        writer.writeByte(2);
        break;
      case StudentLevel.college:
        writer.writeByte(3);
        break;
      case StudentLevel.university:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
