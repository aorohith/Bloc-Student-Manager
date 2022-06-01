import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/application/student/student_cubit.dart';
import 'package:student/core/constants.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/main.dart';
import 'package:student/presentation/add_student.dart';
import 'package:student/presentation/edit_student.dart';
import 'package:student/presentation/search_screen.dart';
import 'package:student/presentation/student_details.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddStudentScreen()));
        },
      ),
      appBar: AppBar(
        title: const Text('All Students'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            // print(state.students);

            return ListView.separated(
              itemBuilder: (context, index) {
                // state as StudentInitial;
                StudentModel student = state.students[index];
                print(student.photo);
                return Card(
                  child: ListTile(
                    leading: student.photo == null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://e7.pngegg.com/pngimages/78/788/png-clipart-computer-icons-avatar-business-computer-software-user-avatar-child-face.png'),
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                FileImage(File(student.photo.toString())),
                            radius: 50,
                          ),
                    title: Text(student.name),
                    subtitle: Text(student.division),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentDetailPage(
                                    index: index,
                                  )));
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => kHeight,
              itemCount: state.students.length,
            );
          },
        ),
      ),
    );
  }
}
