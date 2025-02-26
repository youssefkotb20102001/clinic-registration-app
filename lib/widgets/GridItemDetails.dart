import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridItemDetails extends StatelessWidget {
  GridItemDetails({super.key, required this.icon, required this.patientitem});
  var patientitem;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    Widget screen = Container(
      decoration: BoxDecoration(
        color: Colors.white, // Card background color
        borderRadius: BorderRadius.circular(16), // Rounded edges
        border: Border.all(
          color: const Color.fromARGB(255, 2, 61, 86), // Border color
          width: 2, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures the card adjusts to content
          children: [
            icon,
            const SizedBox(
              height: 16,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Text(
                  patientitem.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 2, 61, 86),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: AutofillHints.familyName,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // If the patientitem is null, display an empty text
    if (patientitem == null) {
      screen = const Text(
        '',
      );
    }

    return screen;
  }
}
