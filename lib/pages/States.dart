import 'package:clinic/Chart/Chart.dart';
import 'package:clinic/classes/PatientDetails.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class States extends StatefulWidget {
  States({super.key, required this.patients});
  List<Patientdetails> patients;
  State<States> createState() {
    return _StatesState();
  }
}

class _StatesState extends State<States> {
  void initState() {
    super.initState();
    edittext();
  }

  String note = "";
  int countpatients(int month) {
    int counter = 0;
    for (var patient in widget.patients) {
      if (DateTime.now().year == patient.date.year) {
        if (patient.date.month == month) {
          counter++;
        }
      }
    }
    return counter;
  }

  // ignore: non_constant_identifier_names

  void edittext() {
    var differance = countpatients(DateTime.now().month) -
        (countpatients(DateTime.now().month - 1));
    if (differance < 0) {
      differance = differance * -1;
      setState(() {
        note =
            "This month's patient are less than the past month by $differance";
      });
    } else if (differance > 0) {
      setState(() {
        note =
            "This month's patient are more than the past month by $differance";
      });
    } else {
      setState(() {
        note = "This month's patient are the same as the past month";
      });
    }
  }

  String avg() {
    var sum = 0;
    for (int i = 1; i <= 12; i++) {
      sum += countpatients(i);
    }

    double avg = (sum / DateTime.now().month);

    return avg.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    //final double Width = MediaQuery.of(context).size.width;
    final double Height = MediaQuery.of(context).size.height;
    var average = avg();
    return Scaffold(
      appBar: AppBar(
        title: const Text("States"),
        backgroundColor: const Color.fromARGB(255, 2, 61, 86),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Height * 0.04,
          ),
          const Text(
            "Monthly States",
            style: TextStyle(
                color: Color.fromARGB(255, 2, 61, 86),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          Chart(patients: widget.patients),
          // PieChart(PieChartData(sections: GetSections())),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: Height * 0.3,
              child: Card(
                color: const Color.fromARGB(255, 2, 61, 86),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Notes!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Height * 0.01,
                      ),
                      Text(
                        note,
                        style: const TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: Height * 0.01,
                      ),
                      Text(
                        "The average number of patients are $average",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
