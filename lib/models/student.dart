import 'package:student_app/enumerations/student_level.dart';
import 'package:student_app/models/mark.dart';
import 'dart:math';

class Student{
  final int id;
  String name;
  String familyName;
  DateTime birthday;
  StudentLevel level;
  List<Mark>? marks;
  String? photo;
  Student({
    required this.id,
    required this.name,
    required this.familyName,
    required this.birthday,
    this.level=StudentLevel.university,
    this.marks,
    this.photo,
  });
 //generate a random id for the student instance
 factory Student.generate({
    required String name,
    required String familyName,
    required DateTime birthday,
    StudentLevel? level,
    List<Mark>? marks,
    String? photo,
 })
 {
  return Student(
    id: Random().nextInt(100000),
    name: name,
    familyName: familyName,
    birthday: birthday,
    level:level ?? StudentLevel.university,
    marks:marks,
    photo: photo,

  );
 }

  //from JSON to Student object
  factory Student.toJon(Map<String,dynamic> json)=>
    Student(
      id:json["id"] as int,
      name:json["name"] as String,
      familyName:json["familyName"] as String,
      birthday:DateTime.parse((json["birthday"] as String)),
      level:StudentLevel.values.firstWhere(
        (l) => l.toString() == "Student.Level.${json["level"]}",
        orElse: () => StudentLevel.university,
      ),
      marks:(json["marks"] as List<dynamic>?)
            ?.map((markJson) => Mark.fromJson(markJson as Map<String, dynamic>))
            .toList(),
      photo:json["photo"] as String?,
    );
    //from Student to JSON
    Map<String,dynamic> toJson() =>
    {
      "id":id,
      "name":name,
      "familyName":familyName,
      "birthday":birthday.toIso8601String(),
      "level": level.toString().split('.').last,
      "marks": marks?.map((mark) => mark.toJson()).toList(),
      "photo":photo ?? "No photo",
    };

    @override
  String toString() {
    return '''
Student:
  ID: $id
  Name: $name $familyName
  Birthday: $birthday
  Level: $level
  Marks: ${marks?.map((m) => m.toString()).toList() ?? "No marks"}
  Photo: ${photo ?? "No photo"}
    ''';
  }

}