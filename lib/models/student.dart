import 'package:hive/hive.dart';
import 'package:student_app/enumerations/student_guard.dart';
import 'package:student_app/enumerations/student_level.dart';
import 'package:student_app/models/mark.dart';
import 'dart:math';
// The 'student.g.dart' file is an auto-generated Dart file created using the build_runner package.
// It is part of the Flutter code generation system, which automates repetitive tasks 
// like writing serialization and deserialization logic.
//
// This line links the generated file ('student.g.dart') to the 'student.dart' file.
// The `part` keyword tells Dart that 'student.dart' and 'student.g.dart' are part of the same library.
// This allows the generated code to seamlessly access and extend the classes and annotations 
// defined in 'student.dart'.
//
// The 'student.g.dart' file is created and updated by running the build_runner command:
//   flutter pub run build_runner build
//
// It typically contains:
// 1. Implementation of a TypeAdapter for the 'Student' class (when using Hive):
//    - Handles how to serialize (convert objects to binary data) and deserialize (convert binary 
//      data back to objects) the 'Student' class for storage in Hive.
// 2. Boilerplate code for serialization and deserialization logic (if using JsonSerializable).
//
// Important Notes:
// - This file should not be edited manually. Any changes will be overwritten the next time the 
//   build_runner command is executed.
// - If you make changes to the 'student.dart' file (e.g., add or modify fields or annotations), 
//   you need to regenerate the 'student.g.dart' file by re-running the build_runner command.
//
// Example build_runner commands:
// - To generate the file: 
//   flutter pub run build_runner build
// - To continuously watch for changes and regenerate files automatically: 
//   flutter pub run build_runner watch
//
// Ensure that the 'student.g.dart' file is always in sync with 'student.dart' to avoid runtime 
// errors when working with libraries like Hive or JsonSerializable.

part 'student.g.dart';

@HiveType(typeId: 0)
class Student{
  @HiveField(0)
  final int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String familyName;
  @HiveField(3)
  DateTime birthday;
  @HiveField(4)
  StudentLevel level;
  @HiveField(5)
  List<Mark>? marks;
  @HiveField(6)
  String? photo;
  @HiveField(7)
  StudentGuard guard;
  Student({
    required this.id,
    required this.name,
    required this.familyName,
    required this.birthday,
    this.level=StudentLevel.university,
    this.marks,
    this.photo,
    this.guard=StudentGuard.average
  });
 //generate a random id for the student instance
 factory Student.generate({
    required String name,
    required String familyName,
    required DateTime birthday,
    StudentLevel? level,
    List<Mark>? marks,
    String? photo,
    StudentGuard? guard,
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
    guard: guard ?? StudentGuard.average,

  );
 }

  //from JSON to Student object
  // Factory Constructor: Student.fromJson
// ---------------------------------------
// This line defines a **factory constructor** named `fromJson` for the `Student` class.
// It is responsible for creating an instance of the `Student` class from a JSON object 
// (a `Map<String, dynamic>` in Dart).
//
// Key Details:
//
// 1. **Factory Constructor:**
//    - A factory constructor in Dart does not create a new instance directly. Instead, 
//      it can return an existing instance, a new instance, or a subtype instance.
//    - Here, it is used to parse a JSON object and return a `Student` instance.
//
// 2. **Input Parameter:**
//    - The parameter `json` is a `Map<String, dynamic>`, which represents a JSON object 
//      where keys are strings (e.g., "id", "name") and values are dynamic (e.g., int, String).
//    - This format matches the typical JSON data structure received from APIs or local files.
//
// 3. **Purpose:**
//    - Converts raw JSON data into a Dart object (`Student`) for easier manipulation and use in the app.
//    - This is essential when working with APIs that return data in JSON format.
//
// 4. **Usage Example:**
//    - Suppose you receive the following JSON data from an API:
//      ```json
//      {
//        "id": 1,
//        "name": "John",
//        "familyName": "Doe",
//        "birthday": "2000-01-01T00:00:00.000",
//        "level": "Beginner",
//        "marks": [80, 85, 90],
//        "photo": "path/to/photo.jpg",
//        "guard": {"name": "Jane Doe", "relation": "Mother"}
//      }
//      ```
//    - You can create a `Student` object like this:
//      ```dart
//      Map<String, dynamic> json = // JSON object as a Dart map;
//      Student student = Student.fromJson(json);
//      ```
  factory Student.fromJon(Map<String,dynamic> json)=>
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