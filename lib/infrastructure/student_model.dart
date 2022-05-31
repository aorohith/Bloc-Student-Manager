import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String standard;

  @HiveField(3)
  final String division;

  @HiveField(4)
  final String? photo;

  StudentModel({
    required this.name,
    required this.age,
    required this.standard,
    required this.division,
    this.photo,
  });
}
