import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/infrastructure/student_model.dart';

import '../application/student/student_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<StudentCubit>().search("");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _search,
            ),
            ElevatedButton(
              onPressed: () {
                if (_search.text.trim().isEmpty) {
                  return;
                }
                context.read<StudentCubit>().search(_search.text.trim());
              },
              child: Icon(
                Icons.search,
              ),
            ),
            BlocBuilder<StudentCubit, StudentState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.searchResult.length,
                    itemBuilder: (context, index) {
                      StudentModel student = state.searchResult[index];
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text(student.division),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
