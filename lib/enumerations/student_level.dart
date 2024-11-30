import 'package:hive/hive.dart';

part 'student_level.g.dart';

@HiveType(typeId: 1)
enum StudentLevel{
  @HiveField(0)
  primary,
  @HiveField(1)
  secondary,
  @HiveField(2)
  highSchool,
  @HiveField(3)
  college,
  @HiveField(4)
  university,
}