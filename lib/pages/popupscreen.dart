import 'dart:io';

import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/classes/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class PopUpScreen extends StatefulWidget {
  const PopUpScreen({super.key, required this.patient});

  final Patientdetails patient;
  @override
  State<PopUpScreen> createState() {
    return _PopUpScreenState();
  }
}

// ignore: must_be_immutable
class _PopUpScreenState extends State<PopUpScreen> {
  @override
  void dispose() {
    _timecontroller.dispose();
    super.dispose();
  }

  final _timecontroller = TextEditingController();
  List<File> _images = [];

  @override
  void initState() {
    super.initState();
    _loadAssetImages(); // Load the asset images on initialization
  }

  Future<void> _loadAssetImages() async {
    try {
      final List<String> assetPaths = [
        'assets/images/amr3.png',
        'assets/images/amr5.png',
        'assets/images/amr2.png',
      ];

      List<File> tempFiles = [];

      for (String assetPath in assetPaths) {
        // Get the byte data of each image
        final byteData = await rootBundle.load(assetPath);

        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();
        final fileName = assetPath.split('/').last;
        final file = File('${tempDir.path}/$fileName');

        // Write the byte data to the temporary file
        await file.writeAsBytes(byteData.buffer.asUint8List());
        tempFiles.add(file);
      }

      setState(() {
        _images = tempFiles;
      });
    } catch (e) {
      print("Error loading asset images: $e");
    }
  }

  Future<void> _shareImagesToWhatsApp() async {
    if (_images.isEmpty) {
      print("No images loaded");
      return;
    }

    try {
      // Convert files to XFile list for share_plus
      List<XFile> xFiles = _images.map((file) => XFile(file.path)).toList();

      // Share multiple images
      await Share.shareXFiles(
        xFiles,
      );
    } catch (e) {
      print("Error sharing images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Whatsapp whatsapp = Whatsapp();
    String time = "";
    final double screenHeight = MediaQuery.of(context).size.height;
    final double verticalPadding = screenHeight * 0.3;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double bottonpos = screenWidth * 0.05;
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
          height: verticalPadding,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 50),
            child: Column(
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: bottonpos,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  whatsapp.openWhatsApp(
                                    widget.patient.phone.toString(),
                                    "تم  تسجيل استماره  تأكيد الحجز  لعمل الاجراء غدا.\n سنرسل لكم اليوم  رساله  واتس اب  حوالي الساعه ١١ مساء ( او عند الانتهاء من ترتيب الجدول)   بها ميعاد حضوركم  غدا لعمل الاجراء .برجاء عدم الاتصال و انتظار الرساله علي واتس اب",
                                  );
                                },
                                child: const Text(
                                  'تاكيد الحجز',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 2, 61, 86),
                                  ),
                                )),
                            SizedBox(
                              width: bottonpos,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  time = _timecontroller.text;
                                  var timezone = "صباحا";
                                  if (time != "") {
                                    if (double.parse(time) >= 8 &&
                                        double.parse(time) < 12) {
                                      timezone = "صباحا";
                                    } else {
                                      timezone = "ظهرا";
                                    }
                                  }
                                  whatsapp.openWhatsApp(
                                    widget.patient.phone.toString(),
                                    ". ميعاد الحضور : غدا الساعة. *$time  $timezone* \n\nالعنوان\n\n*المركز العالمي للاشعه التداخلية*\n٢١٧ طريق الحرية. الإبراهيمية \nبعد مكتب بريد الحضره . \nأعلي بنك التجاري وفا.  \nالمدخل من الممر الجانبي \nالدور التاني\n  034258050 \n01229945263 \n01550656791 \nموقع المركز علي جوجل\nhttps://maps.app.goo.gl/SpDgPfbtgiBL9WVY8 \n\nحالات التخدير الكلي : صيام ٦ ساعات اكل و شرب قبل الموعد المحدد  مع تناول ادويه الضغط و السكر  (إن وجدت ) قبل الصيام. حالات التخدير الموضعي: الصيام غير مطلوب برجاء إحضار اسطوانه و تقرير و أفلام  الاشعه و جواب الطبيب المعالج",
                                  );
                                },
                                child: const Text(
                                  'موعد الاجراء',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 2, 61, 86),
                                  ),
                                )),
                            SizedBox(
                              width: bottonpos,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  _shareImagesToWhatsApp();
                                },
                                child: const Text(
                                  'ارسال تعليمات(عينه)',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 2, 61, 86),
                                  ),
                                )),
                            SizedBox(
                              width: bottonpos,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  whatsapp.openWhatsApp(
                                    widget.patient.phone,
                                    "طريقه تسليك القسطره\nhttps://youtu.be/FWLrR6RRkaI\n\n\nطريقه عمل غيار علي القسطره\nhttps://youtu.be/25qtCsYBRbY",
                                  );
                                },
                                child: const Text(
                                  'ارسال تعليمات(قسطرة)',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 2, 61, 86),
                                  ),
                                )),
                          ],
                        )
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLength: 50,
                  controller: _timecontroller,
                  //onChanged: _savetitle,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Time'),
                  ),
                ),
              ],
            ),
          )));
    });
  }
}
