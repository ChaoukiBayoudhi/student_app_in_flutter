// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/enumerations/student_guard.dart';
import 'package:student_app/enumerations/student_level.dart';
import 'package:student_app/models/mark.dart';
import 'package:student_app/screens/list_student.dart';
import './models/student.dart';

void main() async {
  // Ensures Flutter bindings are initialized before running the app.
  // This is necessary when performing asynchronous operations before runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter.
  // This sets up Hive to use the file system for storage in a Flutter environment.
  await Hive.initFlutter();

  // Register custom adapters with Hive.
  // Adapters are responsible for serializing and deserializing custom objects.
  // Adapters are responsible for serializing and deserializing custom objects.
// Hive, as a key-value database, stores data in a binary format for efficiency.
// While Hive can natively handle simple data types like int, String, bool, etc.,
// it requires adapters to handle custom objects (e.g., your `Student` class).
//
// Serialization: Converts your custom Dart objects (e.g., `Student`) into a binary format
//                that Hive can store in its database.
// Deserialization: Converts the binary data back into Dart objects when retrieving it
//                   from the Hive database.
//
// Example: For the `Student` class:
// 1. Serialization: 
//    - The `Student` object is converted into a format like a list or map with fields 
//      and values (e.g., [id, name, birthday, etc.]) and then into binary data.
// 2. Deserialization: 
//    - The binary data stored in Hive is converted back into a `Student` object
//      by reconstructing its fields and values.
//
// Without registering an adapter, Hive won't know how to interpret your custom class.
// This step is essential to make your class compatible with Hive's storage and retrieval process.

  Hive.registerAdapter(StudentAdapter()); // Adapter for the `Student` class.
  Hive.registerAdapter(StudentLevelAdapter()); // Adapter for the `StudentLevel` enum.
  Hive.registerAdapter(StudentGuardAdapter()); // Adapter for the `StudentGuard` class.
  Hive.registerAdapter(MarkAdapter()); // Adapter for the `Mark` class.

  // Open a Hive box to store and retrieve `Student` objects.
  // A "box" in Hive is a persistent data store, similar to a table in a database.
  // The box is identified by its unique name ('students' in this case).

  // Open the box
// ------------------
// This line opens a Hive box named 'students'. A "box" in Hive is similar to a table in traditional databases 
// or a collection in NoSQL databases. It serves as a storage unit where you can save, retrieve, update, 
// and delete objects or data.
//
// Key Details:
// 1. **Box Name:** 
//    - The name 'students' is a unique identifier for the box. It is used to reference the box 
//      throughout the application whenever you need to perform CRUD (Create, Read, Update, Delete) operations.
//
// 2. **Generic Type <Student>:**
//    - The `<Student>` type ensures that the box only works with objects of the `Student` class.
//    - This adds type safety, meaning you can only store and retrieve `Student` objects from this box.
//
// 3. **Asynchronous Operation:**
//    - Opening a box is an asynchronous operation because Hive initializes the storage system in the 
//      background and ensures the box is ready for use. This is why we use `await` here.
//
// 4. **When is a Box Opened?**
//    - Typically, you open a box once during the application's startup (like in the `main()` function).
//    - Once opened, the box remains available throughout the app's lifecycle and doesn't need to 
//      be reopened unless the app restarts.
//
// 5. **Data Persistence:**
//    - Hive stores data persistently on the device, meaning all data in the 'students' box will 
//      remain intact even after the app is closed and reopened.
//
// Example Usage:
// After opening the box, you can:
// - Add a `Student` object: 
//   ```dart
//   var box = Hive.box<Student>('students');
//   box.add(Student(...)); // Adds a new student.
//   ```
// - Retrieve a `Student` object: 
//   ```dart
//   var student = box.getAt(0); // Retrieves the first student in the box.
//   ```
// - Update a `Student` object: 
//   ```dart
//   box.putAt(0, updatedStudent); // Updates the student at index 0.
//   ```
// - Delete a `Student` object: 
//   ```dart
//   box.deleteAt(0); // Removes the student at index 0.
//   ```
//
// Important Notes:
// - A box must be opened before performing any operations on it.
// - Ensure the box name ('students') matches the name used during registration and usage throughout the app.
// - Using `await` is crucial because it ensures the box is fully initialized before proceeding with operations.

  await Hive.openBox<Student>('students');

  // Start the Flutter application by calling the `runApp()` function.
  // `MyApp` is the root widget of the app, typically defined in a separate file.
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentListScreen(),
    );
  }
}
