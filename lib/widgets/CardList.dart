import 'dart:convert';
import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CardList extends StatefulWidget {
  CardList(
      {super.key,
      required this.list,
      required this.removepatient,
      this.alllist});
  List<Patientdetails> list;
  List<Patientdetails>? alllist;
  final void Function() removepatient;
  List<Patientdetails> filteredlist = [];
  State<CardList> createState() {
    return _HomepageState();
  }
}

// ignore: must_be_immutable
class _HomepageState extends State<CardList> {
  // void updatedata(Patientdetails patient) async {
  //   final url2 = Uri.https(
  //       'test2-20d77-default-rtdb.firebaseio.com', 'Deleted_patients.json');

  //   final response = await http.get(url2);
  //   final dynamic responseData = json.decode(response.body);
  //   final Map<String, dynamic> data = responseData;
  //   var counter = 0;
  //   for (final entry in data.entries) {
  //     if (patient.id == entry) {
  //       counter++;
  //     }
  //     if (counter > 0) {
  //       filteredlist.remove(patient);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: ((context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            // margin: EdgeInsets.symmetric(
            //     horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          key: ValueKey(widget.list[index]),
          onDismissed: ((direction) {
            //updatedata(list[index]);
            if (widget.alllist != null) {
              widget.alllist!.remove(widget.list[index]);
            }
            widget.list.remove(widget.list[index]);
            widget.removepatient;
          }),
          child: Cards(patient: widget.list[index]))),
    );
  }
}
