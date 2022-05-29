import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/main.dart';
import 'package:student/presentation/add_student.dart';

import '../application/counter/student_bloc.dart';

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
              print(studentDB.values.length);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            // print(state.students);

            return state.students.isEmpty
                ? const Text("No data found")
                : ListView.separated(
                    itemBuilder: (context, index) {
                      StudentModel student = state.students[index];
                      return ListTile(
                        title: Text(student.name),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.students.length,
                  );
          },
        ),
      ),
    );
  }
}
