// lib/screens/add_student.dart
import 'package:flutter/material.dart';
import 'package:student_app/enumerations/student_guard.dart';
import 'package:student_app/enumerations/student_level.dart';
import '../models/student.dart';

class AddStudentForm extends StatefulWidget {
  final Function(Student) onAddStudent;
  final Student? initialStudent; // New parameter for edit functionality

  AddStudentForm({required this.onAddStudent, this.initialStudent});

  @override
  _AddStudentFormState createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _familyNameController;
  late TextEditingController _birthdayController;
  late TextEditingController _levelController;
  late TextEditingController _guardController;
  late TextEditingController _photoController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing student data if in edit mode
    final student = widget.initialStudent;
    _nameController = TextEditingController(text: student?.name ?? '');
    _familyNameController = TextEditingController(text: student?.familyName ?? '');
    _birthdayController = TextEditingController(text: student?.birthday?.toString().split(' ')[0] ?? '');
    _levelController = TextEditingController(text: student?.level?.toString() ?? '');
    _guardController = TextEditingController(text: student?.guard?.toString() ?? '');
    _photoController = TextEditingController(text: student?.photo ?? '');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final student = Student.generate(
        name: _nameController.text,
        familyName: _familyNameController.text,
        birthday: DateTime.parse(_birthdayController.text),
        level: StudentLevel.values.firstWhere(
        (l) => l.toString() == "Student.Level.${_levelController.text}",
        orElse: () => StudentLevel.university,
      ),
        guard: StudentGuard.values.firstWhere(
        (l) => l.toString() == "Student.guard.${_guardController.text}",
        orElse: () => StudentGuard.average,
      ),
        photo: _photoController.text,
      );

      widget.onAddStudent(student);
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.initialStudent == null ? 'Add Student' : 'Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _familyNameController,
                decoration: const InputDecoration(labelText: 'Family Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a family name' : null,
              ),
              TextFormField(
                controller: _birthdayController,
                decoration: const InputDecoration(labelText: 'Birthday (YYYY-MM-DD)'),
                readOnly: true,
                onTap: _pickDate,
              ),
              TextFormField(
                controller: _levelController,
                decoration: const InputDecoration(labelText: 'Level'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a level' : null,
              ),
              TextFormField(
                controller: _guardController,
                decoration: const InputDecoration(labelText: 'Guard'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a guard' : null,
              ),
              TextFormField(
                controller: _photoController,
                decoration: const InputDecoration(labelText: 'Photo URL'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a photo URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
