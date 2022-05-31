import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/constants.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/presentation/edit_student.dart';

import '../application/student/student_cubit.dart';

class StudentDetailPage extends StatelessWidget {
  int index;
  StudentDetailPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        StudentModel student = state.students[index];
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditStudentScreen(
                          index: index,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit))
            ]),
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 250,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: FileImage(
                                File(
                                  student.photo.toString(),
                                ),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        kHeight20,
                        StudentDetailCard(
                            keys: 'Name : ', values: student.name),
                        StudentDetailCard(keys: 'Age : ', values: student.age),
                        StudentDetailCard(
                            keys: 'Standard : ', values: student.standard),
                        StudentDetailCard(
                            keys: 'Division : ', values: student.division),
                      ],
                    ))));
      },
    );
  }
}

class StudentDetailCard extends StatelessWidget {
  String keys;
  String values;
  StudentDetailCard({Key? key, required this.keys, required this.values})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              keys,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            Text(
              values,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
