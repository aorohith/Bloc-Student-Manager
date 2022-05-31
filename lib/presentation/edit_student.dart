import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/main.dart';

import '../application/student/student_cubit.dart';
import '../core/constants.dart';

class EditStudentScreen extends StatelessWidget {
  StudentModel student;
  int index;
  EditStudentScreen({
    Key? key,
    required this.student,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController =
        TextEditingController(text: student.name);
    TextEditingController _ageController =
        TextEditingController(text: student.age);
    TextEditingController _standardController =
        TextEditingController(text: student.standard);
    TextEditingController _divisionController =
        TextEditingController(text: student.division);
    XFile? photo;
    final ImagePicker _picker = ImagePicker();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add New Student'),
      ),
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          String photoToSave = student.photo.toString();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      state.photo == null
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(photoToSave)),
                              radius: 50,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(File(photo!.path)),
                              radius: 50,
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
                                            if (photo == null) {}
                                            photo = await _picker.pickImage(
                                                source: ImageSource.camera);
                                            context
                                                .read<StudentCubit>()
                                                .updatePhoto(photo!);
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
                                                .updatePhoto(photo!);
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
                  kHeight20,
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
                    onPressed: () async{
                      String name = _nameController.text.trim();
                      String age = _ageController.text.trim();
                      String standard = _standardController.text.trim();
                      String division = _divisionController.text.trim();
                      // if (photo!.path.isNotEmpty) {
                      //   photoToSave = photo!.path;
                      // }
                      if (name.isEmpty ||
                          age.isEmpty ||
                          standard.isEmpty ||
                          division.isEmpty) {
                        return;
                      } else {
                        StudentModel student = StudentModel(
                          name: name,
                          age: age,
                          standard: standard,
                          division: division,
                          photo: state.photo==null?
                          state.students[index].photo 
                          : photo!.path
                          , 
                        );
                        context
                            .read<StudentCubit>()
                            .editStudent(student: student, index: index);
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
