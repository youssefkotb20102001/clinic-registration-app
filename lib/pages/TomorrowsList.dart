import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/widgets/CardList.dart';
import 'package:flutter/material.dart';

class Tomorrowslist extends StatelessWidget {
  Tomorrowslist(
      {super.key, required this.allpatients, required this.removepatient});
  final List<Patientdetails> allpatients;
  final void Function() removepatient;

  final List<Patientdetails> filteredlist = [];

  bool removepastpatients(Patientdetails patient) {
    int day = int.parse(patient.id.substring(8, 10));
    print(day);
    DateTime selectedday =
        DateTime(DateTime.now().year, DateTime.now().month, day);
    DateTime sevenDaysEarlier =
        DateTime.now().subtract(const Duration(days: 6));
    bool difference = selectedday.isBefore(sevenDaysEarlier);
    return difference;
  }

  bool remove(Patientdetails patient) {
    int day = int.parse(patient.id.substring(8, 10));
    int year = int.parse(patient.id.substring(0, 4));
    int month = int.parse(patient.id.substring(5, 7));

    DateTime selectedday = DateTime(year, month, day);
    DateTime today = DateTime.now();

    if (today.day == selectedday.day &&
        today.month == selectedday.month &&
        today.year == selectedday.year) {
      return true;
    }

    return false;
  }

  // List<Patientdetails> filteringtomorrowsList(
  //     List<Patientdetails> allpatients) {
  //   DateTime now = DateTime.now();
  //   // Format the current date to get the day name
  //   String dayName = DateFormat('EEEE').format(now);
  //   for (final patient in allpatients) {
  //     if (dayName == 'Friday' &&
  //         patient.date == 'السبت' &&
  //         removepastpatients(patient) == false) {
  //       filteredlist.add(patient);
  //     } else if (dayName == 'Saturday' &&
  //         patient.date == 'الاحد' &&
  //         removepastpatients(patient) == false) {
  //       filteredlist.add(patient);
  //     } else if (dayName == 'Sunday' &&
  //         patient.date == 'الاثنين' &&
  //         removepastpatients(patient) == false) {
  //       filteredlist.add(patient);
  //     } else if (dayName == 'Monday' &&
  //         patient.date == 'الثلاثاء' &&
  //         removepastpatients(patient) == false) {
  //       filteredlist.add(patient);
  //     } else if (dayName == 'Wednesday' &&
  //         patient.date == 'الخميس' &&
  //         removepastpatients(patient) == false) {
  //       filteredlist.add(patient);
  //     }
  //   }
  //   return filteredlist;
  // }

  List<Patientdetails> filteringtomorrowsList(
      List<Patientdetails> allpatients) {
    for (final patient in allpatients) {
      if (remove(patient) == true) {
        filteredlist.add(patient);
      }
    }
    return filteredlist;
  }

  @override
  Widget build(BuildContext context) {
    filteringtomorrowsList(allpatients);

    Widget screen = Expanded(
        child: CardList(
      list: filteredlist,
      removepatient: removepatient,
      alllist: allpatients,
    ));
    if (filteredlist.isEmpty) {
      screen = const Padding(
        padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
        child: Center(child: Text("No patients for tomorrow")),
      );
    }
    return Scaffold(
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Tomorrow's Patients",
              style: TextStyle(
                  color: Color.fromARGB(255, 2, 61, 86),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: AutofillHints.familyName)),
        ),
        screen,
      ]),
    );
  }
}
