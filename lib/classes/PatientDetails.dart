import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Patientdetails {
  Patientdetails({
    required this.name,
    //   required this.age,
    required this.phone,
    //   required this.address,
    required this.medicine,
    //   required this.place,
    this.takhdeer,
    required this.date,
    required this.id,
    required this.symptome,
    //   required this.doctor,
  });
  final String name;
  // final age;
  final phone;
  // final String address;
  final String medicine;
  // final String place;
  final String? takhdeer;
  final DateTime date;
  final String id;
  final String symptome;
  // final String doctor;

  // static void fromJson(decode) {}

  // // String get formatteddate {
  // //   return formatter.format(date);
  // // }
}
