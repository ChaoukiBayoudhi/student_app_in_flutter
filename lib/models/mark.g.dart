// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarkAdapter extends TypeAdapter<Mark> {
  @override
  final int typeId = 3;

  @override
  Mark read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mark(
      score: fields[0] as double,
      subject: fields[1] as String,
      date: fields[2] as DateTime,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Mark obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
