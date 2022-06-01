import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/presentation/student_details.dart';

import '../application/student/student_cubit.dart';
import '../core/constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<StudentCubit>().search("");
    return Scaffold(
      appBar: AppBar(title: Text("Search Here")),
      body: SafeArea(child: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: _search,
                    onChanged: (text) =>
                        context.read<StudentCubit>().search(text),
                    decoration: InputDecoration(
                      hintText: "Enter Search Text",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      // state as StudentInitial;
                      StudentModel student = state.searchResult[index];
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
                    itemCount: state.searchResult.length,
                  ),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
