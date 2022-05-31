part of 'student_cubit.dart';

class StudentState {
  List<StudentModel> students;
  XFile? photo;
  StudentState({required this.students, this.photo});
}

class StudentInitial extends StudentState {
  StudentInitial(): super(students: studentDB.values.toList());
  
}
