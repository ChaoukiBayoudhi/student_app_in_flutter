// lib/screens/student_list.dart
import 'package:flutter/material.dart';
import '../models/student.dart';
import 'add_student.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<Student> _students = [];

  void _addStudent(Student student) {
    setState(() {
      // Check if student already exists (edit mode)
      int index = _students.indexWhere((s) => s.id == student.id);
      if (index != -1) {
        _students[index] = student;
      } else {
        _students.add(student);
      }
    });
  }

  void _deleteStudent(int id) {
    setState(() {
      _students.removeWhere((student) => student.id == id);
    });
  }

  void _updateStudent(Student student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddStudentForm(
          onAddStudent: _addStudent,
          initialStudent: student,
        ),
      ),
    );
  }

  void _navigateToAddStudentScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddStudentForm(
          onAddStudent: _addStudent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(student.photo!),
              ),
              title: Text('${student.name} ${student.familyName}'),
              subtitle: Text('Level: ${student.level}, Guardian: ${student.guard}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _updateStudent(student),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteStudent(student.id),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudentScreen,
        child: Icon(Icons.add),
      ),
    );
  }
}
