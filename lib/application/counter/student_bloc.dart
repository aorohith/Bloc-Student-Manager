import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student/infrastructure/student_model.dart';
import 'package:student/main.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    
    on<AddStudent>((event, emit){
      return emit(state);
    });
  }
}
