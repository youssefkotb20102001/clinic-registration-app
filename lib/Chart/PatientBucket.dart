import 'package:clinic/classes/PatientDetails.dart';

class ExpenseBucket {
  const ExpenseBucket(this.Patients, this.month);
  ExpenseBucket.forCategory(List<Patientdetails> AllPatients, this.month)
      : Patients = AllPatients.where((patient) =>
            patient.date.year == DateTime.now().year &&
            patient.date.month == month).toList();

  final int month;
  final List<Patientdetails> Patients;

  int get totalexpenses {
    int sum = 0;
    for (int i = 0; i < Patients.length; i++) {
      sum = sum + 1;
    }
    return sum;
  }
}
