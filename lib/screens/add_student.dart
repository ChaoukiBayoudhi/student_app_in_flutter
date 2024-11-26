// lib/screens/add_student.dart
import 'package:flutter/material.dart';
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
  late TextEditingController _guardianController;
  late TextEditingController _photoController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing student data if in edit mode
    final student = widget.initialStudent;
    _nameController = TextEditingController(text: student?.name ?? '');
    _familyNameController = TextEditingController(text: student?.familyName ?? '');
    _birthdayController = TextEditingController(text: student?.birthday?.toString().split(' ')[0] ?? '');
    _levelController = TextEditingController(text: student?.level ?? '');
    _guardianController = TextEditingController(text: student?.guardian ?? '');
    _photoController = TextEditingController(text: student?.photo ?? '');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final student = Student.generate(
        name: _nameController.text,
        familyName: _familyNameController.text,
        birthday: DateTime.parse(_birthdayController.text),
        level: _levelController.text,
        guardian: _guardianController.text,
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
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _familyNameController,
                decoration: InputDecoration(labelText: 'Family Name'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a family name' : null,
              ),
              TextFormField(
                controller: _birthdayController,
                decoration: InputDecoration(labelText: 'Birthday (YYYY-MM-DD)'),
                readOnly: true,
                onTap: _pickDate,
              ),
              TextFormField(
                controller: _levelController,
                decoration: InputDecoration(labelText: 'Level'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a level' : null,
              ),
              TextFormField(
                controller: _guardianController,
                decoration: InputDecoration(labelText: 'Guardian'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a guardian' : null,
              ),
              TextFormField(
                controller: _photoController,
                decoration: InputDecoration(labelText: 'Photo URL'),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a photo URL' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
