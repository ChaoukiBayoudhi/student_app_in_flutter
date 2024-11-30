// lib/screens/add_student.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/enumerations/student_guard.dart';
import 'package:student_app/enumerations/student_level.dart';
import '../models/student.dart';

class AddStudentForm extends StatefulWidget {
  final Function(Student) onAddStudent;
  final Student? initialStudent;

  const AddStudentForm({super.key, required this.onAddStudent, this.initialStudent});

  @override
  _AddStudentFormState createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _familyNameController;
  late TextEditingController _birthdayController;
  late StudentLevel _selectedLevel;
  late StudentGuard _selectedGuard;
  late TextEditingController _photoController;
  late Box<Student> _studentsBox;

  @override
  void initState() {
    super.initState();
    _studentsBox = Hive.box<Student>('students');

    // Initialize controllers with existing student data if in edit mode
    final student = widget.initialStudent;
    _nameController = TextEditingController(text: student?.name ?? '');
    _familyNameController = TextEditingController(text: student?.familyName ?? '');
    _birthdayController = TextEditingController(
        text: student?.birthday.toString().split(' ')[0] ?? '');
    _selectedLevel = student?.level ?? StudentLevel.university;
    _selectedGuard = student?.guard ?? StudentGuard.average;
    _photoController = TextEditingController(text: student?.photo ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _familyNameController.dispose();
    _birthdayController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final student = Student.generate(
        id: widget.initialStudent?.id,
        name: _nameController.text,
        familyName: _familyNameController.text,
        birthday: DateTime.parse(_birthdayController.text),
        level: _selectedLevel,
        guard: _selectedGuard,
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
      appBar: AppBar(
        title: Text(widget.initialStudent == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _familyNameController,
                decoration: const InputDecoration(labelText: 'Family Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a family name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthdayController,
                decoration: const InputDecoration(labelText: 'Birthday'),
                readOnly: true,
                onTap: _pickDate,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please select a birthday' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<StudentLevel>(
                value: _selectedLevel,
                decoration: const InputDecoration(labelText: 'Level'),
                items: StudentLevel.values.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLevel = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<StudentGuard>(
                value: _selectedGuard,
                decoration: const InputDecoration(labelText: 'Guard'),
                items: StudentGuard.values.map((guard) {
                  return DropdownMenuItem(
                    value: guard,
                    child: Text(guard.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGuard = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _photoController,
                decoration: const InputDecoration(labelText: 'Photo URL'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a photo URL' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
