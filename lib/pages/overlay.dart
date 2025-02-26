import 'dart:io';

import 'package:clinic/classes/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class OverlayScreens extends StatefulWidget {
  const OverlayScreens({super.key});
  State<OverlayScreens> createState() {
    return _OverlayScreensState();
  }
}

class _OverlayScreensState extends State<OverlayScreens> {
  final _numbercontroller = TextEditingController();
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
  void dispose() {
    _numbercontroller.dispose();
    _timecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Whatsapp whatsapp = new Whatsapp();
    final keyboard_space = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      //final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboard_space + 16),
            child: Column(
              children: [
                const Text(
                  "Send Form To Patient",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 61, 86),
                  ),
                ),
                TextField(
                  maxLength: 50,
                  controller: _numbercontroller,
                  //onChanged: _savetitle,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "+2",
                    label: Text('Phone Number'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLength: 50,
                  controller: _timecontroller,
                  //onChanged: _savetitle,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Time'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      whatsapp.openWhatsApp(
                        _numbercontroller.value.text,
                        "ده رساله تأكيد استقبال ال form\n\nتم  تسجيل استماره  تأكيد الحجز  لعمل الاجراء غدا.\n سنرسل لكم اليوم  رساله  واتس اب  حوالي الساعه ١١ مساء ( او عند الانتهاء من ترتيب الجدول)   بها ميعاد حضوركم  غدا لعمل الاجراء .برجاء عدم الاتصال و انتظار الرساله علي واتس اب",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 2, 61, 86), //background color of button
                        //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    child: const Text(
                      "تاكيد الحجز",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      whatsapp.openWhatsApp(
                        _numbercontroller.value.text,
                        "https://docs.google.com/forms/d/e/1FAIpQLSd3zWxQZR7xFVT8E_eVpiO-DBA0wJLlMMSTWl5Jq-MhAJ0AmA/viewform?usp=dialog",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 2, 61, 86), //background color of button
                        //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    child: const Text(
                      "ارسال الاستماره لهذا المريض",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      whatsapp.openWhatsApp(
                        _numbercontroller.value.text,
                        "طريقه تسليك القسطره\nhttps://youtu.be/FWLrR6RRkaI\n\n\nطريقه عمل غيار علي القسطره\nhttps://youtu.be/25qtCsYBRbY",
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 2, 61, 86), //background color of button
                        //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    child: const Text(
                      "ارسال تعليمات (قسطرة)",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _shareImagesToWhatsApp();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 2, 61, 86), //background color of button
                        //border width and color
                        elevation: 3, //elevation of button
                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(20)),
                    child: const Text(
                      "ارسال تعليمات(عينة)",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
