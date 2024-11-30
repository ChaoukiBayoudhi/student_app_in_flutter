// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_guard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentGuardAdapter extends TypeAdapter<StudentGuard> {
  @override
  final int typeId = 2;

  @override
  StudentGuard read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return StudentGuard.excellent;
      case 1:
        return StudentGuard.good;
      case 2:
        return StudentGuard.average;
      case 3:
        return StudentGuard.poor;
      default:
        return StudentGuard.excellent;
    }
  }

  @override
  void write(BinaryWriter writer, StudentGuard obj) {
    switch (obj) {
      case StudentGuard.excellent:
        writer.writeByte(0);
        break;
      case StudentGuard.good:
        writer.writeByte(1);
        break;
      case StudentGuard.average:
        writer.writeByte(2);
        break;
      case StudentGuard.poor:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentGuardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
