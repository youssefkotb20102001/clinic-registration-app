import 'dart:io';
import 'package:clinic/classes/whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenGoogleSheet extends StatelessWidget {
  // Replace this with your Google Sheet URL
  final String googleSheetUrl =
      'https://docs.google.com/spreadsheets/d/1YNy7PjN_-8dXK7DAHMHZBHBDnc1SAe0mmDAXJXeUHbg/edit';

  // Function to open the Google Sheet
  Future<void> _openGoogleSheet() async {
    await launch(googleSheetUrl);
  }

  Future<void> shareImageWithWhatsApp(String message, String assetPath) async {
    try {
      // Get the directory to store the copied file
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/doctor.png';

      // Load the image asset as byte data
      final byteData = await rootBundle.load(assetPath);
      final bytes = byteData.buffer.asUint8List();

      // Write the bytes to a file
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Share the file using the Share plugin
      if (await file.exists()) {
        Share.shareXFiles(
          [XFile(filePath)],
          text: message,
        );
      } else {
        throw 'File does not exist at $filePath';
      }
    } catch (e) {
      print("Error sharing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Whatsapp wp = new Whatsapp();
    return Scaffold(
      appBar: AppBar(title: const Text('Open Google Sheet')),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _openGoogleSheet();
            },
            child: const Text(
              'Open Google Form',
              style: TextStyle(
                color: Color.fromARGB(255, 2, 61, 86),
              ),
            )),
      ),
    );
  }
}
