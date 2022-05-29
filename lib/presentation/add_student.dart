import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/main.dart';

import '../application/counter/student_bloc.dart';
import '../core/constants.dart';

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({Key? key}) : super(key: key);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _standardController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              kHeight,
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),
              kHeight,
              TextFormField(
                controller: _standardController,
                decoration: InputDecoration(
                  labelText: "Standard",
                  border: OutlineInputBorder(),
                ),
              ),
              kHeight,
              TextFormField(
                controller: _divisionController,
                decoration: InputDecoration(
                  labelText: "Division",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addStudent(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addStudent(BuildContext context) {
    String _name = _nameController.text.trim();
    String _age = _ageController.text.trim();
    String _standard = _standardController.text.trim();
    String _division = _divisionController.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _standard.isEmpty ||
        _division.isEmpty) {
      return;
    } else {
      StudentModel student = StudentModel(
        name: _name,
        age: _age,
        standard: _standard,
        division: _division,
      );
      // studentDB.add(student);
      context.read<StudentBloc>().add(AddStudent(student: student));
    }
  }
}
