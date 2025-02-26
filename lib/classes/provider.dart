import 'package:flutter/material.dart';
import 'package:clinic/classes/PatientDetails.dart';

class PatientProvider extends ChangeNotifier {
  List<Patientdetails> _list = [];

  List<Patientdetails> get list => _list;

  void setList(List<Patientdetails> newList) {
    _list = newList;
    notifyListeners();
  }

  void removePatient(Patientdetails patient) {
    _list.remove(patient);
    notifyListeners();
  }

  void addPatient(Patientdetails patient) {
    _list.add(patient);
    notifyListeners();
  }

  void reorderPatients(int oldIndex, int newIndex) {
    final item = _list.removeAt(oldIndex);
    _list.insert(newIndex, item);
    notifyListeners();
  }
}
