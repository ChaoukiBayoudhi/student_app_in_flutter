// lib/screens/student_list.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/student.dart';
import 'add_student.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late Box<Student> _studentsBox;

  @override
  void initState() {
    super.initState();
    _studentsBox = Hive.box<Student>('students');
  }

  void _addStudent(Student student) {
    final existingIndex = _studentsBox.values.toList().indexWhere((s) => s.id == student.id);
    if (existingIndex != -1) {
      // Update existing student
      _studentsBox.putAt(existingIndex, student);
    } else {
      // Add new student
      _studentsBox.add(student);
    }
  }

  void _deleteStudent(int id) {
    final index = _studentsBox.values.toList().indexWhere((student) => student.id == id);
    if (index != -1) {
      _studentsBox.deleteAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _studentsBox.listenable(),
        builder: (context, Box<Student> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No students yet'),
            );
          }
          
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final student = box.getAt(index);
              if (student == null) return const SizedBox.shrink();
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(student.photo ?? ''),
                    onBackgroundImageError: (_, __) {
                      // Handle image load error
                    },
                  ),
                  title: Text(
                    '${student.name} ${student.familyName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Level: ${student.level.toString().split('.').last}'),
                      Text('Guard: ${student.guard.toString().split('.').last}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddStudentForm(
                                onAddStudent: _addStudent,
                                initialStudent: student,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteStudent(student.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddStudentForm(
                onAddStudent: _addStudent,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
