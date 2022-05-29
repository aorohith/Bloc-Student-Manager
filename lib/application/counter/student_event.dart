part of 'student_bloc.dart';

class StudentEvent {}

class GetAllStudnets extends StudentEvent{}

class AddStudent extends StudentEvent {
  StudentModel student;
  AddStudent({required this.student});
  
  
}

class RemoveStudent extends StudentEvent{}

class EditStudent extends StudentEvent{}
