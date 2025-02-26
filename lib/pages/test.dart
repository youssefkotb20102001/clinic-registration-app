import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WhatsAppBusinessMessageSender extends StatelessWidget {
  final String phoneNumber =
      "01000950761"; // Add the full phone number with country code
  final String message = "Hello from Flutter!";

  static const platform = MethodChannel('com.example.whatsapp/channel');

  Future<void> sendBusinessMessage({
    required String phoneNumber,
    required String message,
  }) async {
    try {
      await platform.invokeMethod('sendToWhatsAppBusiness', {
        'phoneNumber': phoneNumber,
        'message': message,
      });
    } on PlatformException catch (e) {
      print("Error sending message to WhatsApp Business: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Business Sender'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await sendBusinessMessage(
                phoneNumber: phoneNumber,
                message: message,
              );
            } catch (e) {
              print('Error sending message: $e');
            }
          },
          child: Text('Send Message to WhatsApp Business'),
        ),
      ),
    );
  }
}
