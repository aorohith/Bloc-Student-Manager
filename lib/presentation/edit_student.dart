import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/infrastructure/student_model.dart';

import '../application/student/student_cubit.dart';
import '../core/constants.dart';

class EditStudentScreen extends StatelessWidget {
  int index;
  EditStudentScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          StudentModel student = state.students[index];

          TextEditingController nameController =
              TextEditingController(text: student.name);
          TextEditingController ageController =
              TextEditingController(text: student.age);
          TextEditingController standardController =
              TextEditingController(text: student.standard);
          TextEditingController divisionController =
              TextEditingController(text: student.division);
          XFile? photo;
          final ImagePicker _picker = ImagePicker();
          String photoToSave = student.photo.toString();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      state.photo==null
                          ? CircleAvatar(
                              backgroundImage: FileImage(File(photoToSave)),//db image
                              radius: 50,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(File(state.photo.toString())),//img picker image
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
                                                .updatePhoto(photo!.path.toString());
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
                                                .updatePhoto(photo!.path.toString());
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
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  kHeight,
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  kHeight,
                  TextFormField(
                    controller: standardController,
                    decoration: InputDecoration(
                      labelText: "Standard",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  kHeight,
                  TextFormField(
                    controller: divisionController,
                    decoration: InputDecoration(
                      labelText: "Division",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String name = nameController.text.trim();
                      String age = ageController.text.trim();
                      String standard = standardController.text.trim();
                      String division = divisionController.text.trim();
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
                          photo: state.photo == null
                              ? state.students[index].photo
                              : state.photo,
                        );
                        context
                            .read<StudentCubit>()
                            .editStudent(student: student, index: index);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
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
