import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/pages/popupscreen.dart';
import 'package:clinic/widgets/GridItemDetails.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PatientDetailsscreen extends StatelessWidget {
  PatientDetailsscreen({
    super.key,
    required this.patient,
  });
  Patientdetails patient;

  void _OpenAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: ((ctx) {
          return PopUpScreen(
            patient: patient,
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double fontSize = screenWidth * 0.05;

    final double horizontalPadding = screenWidth * 0.15;
    final double verticalPadding = screenHeight * 0.05;
    var phonenumber = patient.phone.toString();
    if (phonenumber.substring(0, 1) != '0') {
      phonenumber = '0' + phonenumber;
    }
    return Scaffold(
        body: Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: verticalPadding),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Patients details',
                  style: TextStyle(
                      color: Color.fromARGB(255, 2, 61, 86),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.familyName)),
            ],
          ),
        ),
        Expanded(
          child: GridView(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 5 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              GridItemDetails(
                icon: Icon(
                  Icons.person,
                  size: fontSize,
                  color: const Color.fromARGB(255, 2, 61, 86),
                ),
                patientitem: patient.name,
              ),
              // GridItemDetails(
              //   icon: Icon(
              //     Icons.calendar_today,
              //     size: fontSize,
              //     color: const Color.fromARGB(255, 2, 61, 86),
              //   ),
              //   patientitem: patient.age,
              // ),
              InkWell(
                onTap: () {
                  _OpenAddExpenseOverlay(context);
                },
                child: GridItemDetails(
                  icon: Icon(
                    Icons.phone,
                    size: fontSize,
                    color: const Color.fromARGB(255, 2, 61, 86),
                  ),
                  patientitem: phonenumber.toString(),
                ),
              ),
              GridItemDetails(
                icon: Icon(
                  Icons.date_range,
                  size: fontSize,
                  color: const Color.fromARGB(255, 2, 61, 86),
                ),
                patientitem: patient.date.toString().substring(0, 10),
              ),
              // GridItemDetails(
              //   icon: Icon(
              //     Icons.location_on,
              //     size: fontSize,
              //     color: const Color.fromARGB(255, 2, 61, 86),
              //   ),
              //   patientitem: patient.address,
              // ),
              GridItemDetails(
                icon: Icon(
                  Icons.medication_liquid_rounded,
                  size: fontSize,
                  color: const Color.fromARGB(255, 2, 61, 86),
                ),
                patientitem: 'medicine: ' + patient.medicine,
              ),
              // GridItemDetails(
              //   icon: Icon(
              //     Icons.location_city,
              //     size: fontSize,
              //     color: Color.fromARGB(255, 2, 61, 86),
              //   ),
              //   patientitem: patient.place,
              // ),
              GridItemDetails(
                icon: Icon(
                  Icons.note_alt_outlined,
                  size: fontSize,
                  color: const Color.fromARGB(255, 2, 61, 86),
                ),
                patientitem: patient.symptome,
              ),
              // GridItemDetails(
              //   icon: Icon(
              //     Icons.person,
              //     size: fontSize,
              //     color: const Color.fromARGB(255, 2, 61, 86),
              //   ),
              //   patientitem: patient.doctor,
              // ),
              GridItemDetails(
                icon: Icon(
                  Icons.local_hospital,
                  size: fontSize,
                  color: const Color.fromARGB(255, 2, 61, 86),
                ),
                patientitem: patient.takhdeer,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
