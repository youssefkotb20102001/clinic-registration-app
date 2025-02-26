import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Whatsapp {
  static const platform = MethodChannel('com.example.whatsapp/channel');

  Future<void> logMessage(String phoneNumber, String message) async {
    final timestamp = DateTime.now();
    await FirebaseFirestore.instance.collection('message_logs').add({
      'phoneNumber': phoneNumber,
      'message': message,
      'timestamp': timestamp,
    });
  }

  Future<void> openWhatsApp(
    String phoneNumber,
    String message,
  ) async {
    if (phoneNumber.substring(0, 1) != '+') {
      phoneNumber = '+2$phoneNumber';
    }

    try {
      await platform.invokeMethod('sendToWhatsAppBusiness', {
        'phoneNumber': phoneNumber,
        'message': message,
      });
      await logMessage(phoneNumber, message);
    } on PlatformException catch (e) {
      print("Error sending message to WhatsApp Business: ${e.message}");
    }
  }
  // void openWhatsApp(String number, String message, BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Choose App'),
  //         content: const Text('Which app do you want to use?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               _launchWhatsApp('com.whatsapp', number, message, context);
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('WhatsApp'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _launchWhatsApp('com.whatsapp.w4b', number, message, context);
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('WhatsApp Business'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void openWhattsApp(String number, String message) {
    _launchWhatsApp("com.whatsapp.w4b", number, message);
  }

  Future<void> _launchWhatsApp(
      String packageName, String phoneNumber, String message) async {
    if (phoneNumber.substring(0, 1) != '0') {
      phoneNumber = '0$phoneNumber';
    }
    phoneNumber = '+2$phoneNumber';
    final encodedPhoneNumber = Uri.encodeComponent(phoneNumber);
    final encodedMessage = Uri.encodeComponent(message);
    final url =
        "whatsapp://send?phone=$encodedPhoneNumber&text=$encodedMessage";
    //whatsapp://send?phone=$encodedPhoneNumber/?text=$encodedMessage
    //https:/wa.me/$encodedPhoneNumber/?text=$encodedMessage

    final uri = Uri.parse(url);

    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: WebViewConfiguration(
          headers: {'packageName': packageName},
        ),
      );
    } catch (e) {
      throw "aaa";
    }
  }
}
