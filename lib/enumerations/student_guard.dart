import 'package:hive/hive.dart';

part 'student_guard.g.dart';
@HiveType(typeId: 2)
enum StudentGuard {
  @HiveField(0)
  excellent,
  @HiveField(1)
  good,
  @HiveField(2)
  average,
  @HiveField(3)
  poor,
}