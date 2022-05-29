part of 'student_bloc.dart';

class StudentState {
  List<StudentModel> students;
  StudentState({required this.students,});
}

class StudentInitial extends StudentState {
  StudentInitial():super(students: studentDB.values.toList());
  
}
