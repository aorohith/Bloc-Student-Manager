part of 'student_cubit.dart';

class StudentState {
  List<StudentModel> students;
  String? photo;
  List<StudentModel> searchResult;
  StudentState({required this.students, this.photo,this.searchResult=const[]});
}

class StudentInitial extends StudentState {
  StudentInitial(): super(students: studentDB.values.toList());
  
}
