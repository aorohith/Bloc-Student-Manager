import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/main.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentInitial());
  void addStudent(StudentModel student) {
    studentDB.add(student);
    emit(StudentState(students: studentDB.values.toList()));
  }

  void editStudent({
    required StudentModel student,
    required int index,
  }) {
    studentDB.putAt(index, student);
    emit(StudentState(students: studentDB.values.toList()));
  }

  void deleteStudent(int index) {
    studentDB.deleteAt(index);
    emit(StudentState(students: studentDB.values.toList()));
  }

  void updatePhoto(XFile imagePath){
    emit(StudentState(students: studentDB.values.toList(), photo: imagePath));
  }
}
