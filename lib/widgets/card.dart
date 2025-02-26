import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/pages/PatientScreen.dart';
import 'package:clinic/pages/popupscreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Cards extends StatelessWidget {
  const Cards({super.key, required this.patient});
  final Patientdetails patient;

  void opendetailedscreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => PatientDetailsscreen(
                  patient: patient,
                )));
  }

  // ignore: non_constant_identifier_names
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

  void openErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cannot open the dial app'),
          content: const Text(
              'Either you dont have an installed app to support this action or you can contact the creator to fix the bug'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialNumber(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    await launchUrl(phoneUri);

    //print("Could not launch dialer");
  }

  @override
  Widget build(BuildContext context) {
    //Color cardcolor = const Color.fromARGB(255, 3, 92, 130);
    var cardcolor = const Color.fromARGB(255, 136, 199, 138);
    if (patient.takhdeer == 'تخدير كلي بسيط بمهديء و مسكن قوي') {
      cardcolor = const Color.fromARGB(255, 173, 65, 58);
    }

    Color textcolor = const Color.fromARGB(255, 251, 250, 250);
    // if (patient.place == 'فيكتوريا') {
    //   cardcolor = const Color.fromARGB(251, 3, 196, 250);
    //   textcolor = Colors.black;
    // }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // final double fontSize = screenWidth * 0.05;

    final double horizontalPadding = screenWidth * 0.03;
    final double verticalPadding = screenHeight * 0.03;

    Widget secondrow = Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            try {
              await _dialNumber(patient.phone.toString());
            } catch (e) {
              openErrorMessage(context);
            }
          },
          child: Row(
            children: [
              Text("Call", style: TextStyle(color: cardcolor)),
              Icon(
                Icons.phone_android,
                color: cardcolor,
              )
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {
              // String x = patient.phone.toString();
              // String message =
              //     'ميعاد الحضور غدا الساعه :      صباحا .\n\n\n برجاء عدم التأخر في الوصول \nالعنوان : المركز العالمى للأشعة\n.217 طريق الحرية -الابراهيمية.اعلي بنك التجاري وفا\n\nموقع المركز علي جوجل  \n\n  https://maps.app.goo.gl/SpDgPfbtgiBL9WVY8 \n\nحالات التخدير الكلي :\n\n صيام ٦ ساعات اكل و شرب قبل الموعد المحدد  و تناول ادويه الضغط و السكر ( إن وجدت ) قبل الصيام .\n\nحالات التخدير الموضعي :\n بدون صيام .\n\n احضار الاشعه و اسطوانتها، التحاليل و جواب الطبيب المعالج.\nملحوظه لحالات سحب العينه: دور المركز هو سحب العينه و نقوم بتسليمها اليكم لتوصيلها بمعرفتكم  الي معمل متخصص  (سنحدد لكم عنوانه) لتحليلها';
              // openWhatsApp(x, message);
              _OpenAddExpenseOverlay(context);
            },
            child: Row(
              children: [
                Text(
                  "Whatsapp",
                  style: TextStyle(color: cardcolor),
                ),
                Icon(
                  Icons.call,
                  color: cardcolor,
                )
              ],
            )),
      ],
    );

    return InkWell(
      onTap: () {
        opendetailedscreen(context);
      },
      child: Card(
          color: cardcolor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      patient.name,
                      style: TextStyle(color: textcolor, fontSize: 18),
                    ),

                    //Text(patient.date.substring(0, 10)),
                  ],
                ),
                Text(
                  patient.phone,
                  style: TextStyle(color: textcolor, fontSize: 18),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      patient.symptome,
                      style: TextStyle(color: textcolor),
                    ),
                    Spacer(),
                    Icon(
                      Icons.calendar_month,
                      color: textcolor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      patient.date.toString().substring(0, 10),
                      style: TextStyle(color: textcolor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text(
                    //   'Age: ${patient.age}',
                    //   style: TextStyle(color: textcolor),
                    // ),
                    const Spacer(
                      flex: 3,
                    ),
                    secondrow
                  ],
                )
              ],
            ),
          )),
    );
  }
}
