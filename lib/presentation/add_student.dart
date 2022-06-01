import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/infrastructure/student_model.dart';

import '../application/student/student_cubit.dart';
import '../core/constants.dart';

class AddStudentScreen extends StatelessWidget {
  AddStudentScreen({Key? key}) : super(key: key);
  final ImagePicker _picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _standardController = TextEditingController();
  TextEditingController _divisionController = TextEditingController();
  XFile? photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add New Student'),
        actions: [
          IconButton(
              onPressed: () {
                print(photo!.path);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  BlocBuilder<StudentCubit, StudentState>(
                    builder: (context, state) {
                      return state.photo == null ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://e7.pngegg.com/pngimages/78/788/png-clipart-computer-icons-avatar-business-computer-software-user-avatar-child-face.png'),
                        radius: 50,
                      ):
                      CircleAvatar(
                        backgroundImage: FileImage(
                           File(state.photo!) ),
                        radius: 50,
                      )
                      ;
                    },
                  ),
                  Positioned(
                      top: 60,
                      left: 60,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  "Select from",
                                  textAlign: TextAlign.center,
                                ),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        photo = await _picker.pickImage(
                                            source: ImageSource.camera);
                                        context
                                            .read<StudentCubit>()
                                            .updatePhoto(photo!.path);
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.camera_alt),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        photo = await _picker.pickImage(
                                            source: ImageSource.gallery);
                                        context
                                            .read<StudentCubit>()
                                            .updatePhoto(photo!.path);
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.collections),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 30,
                          )))
                ],
              ),
              SizedBox(
                height: 20,
              ),
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
                onPressed: () async {
                  _addStudent(context, photo!);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addStudent(BuildContext context, XFile photo) {
    String _name = _nameController.text.trim();
    String _age = _ageController.text.trim();
    String _standard = _standardController.text.trim();
    String _division = _divisionController.text.trim();
    String image = photo.path;
    print(image);

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
        photo: image,
      );
      context.read<StudentCubit>().addStudent(student);
      Navigator.pop(context);
    }
  }
}
