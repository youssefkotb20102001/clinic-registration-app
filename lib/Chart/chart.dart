// ignore: file_names
import 'package:clinic/Chart/patientBucket.dart';
import 'package:clinic/classes/PatientDetails.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.patients});

  final List<Patientdetails> patients;

  List<ExpenseBucket> get StatesPerMonth {
    return [
      for (int i = 1; i <= DateTime.now().month; i++)
        ExpenseBucket.forCategory(patients, i),
    ];
  }

  int get maxTotalExpense {
    int maxTotalExpense = 0;

    for (final bucket in StatesPerMonth) {
      if (bucket.totalexpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalexpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 2, 61, 86),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in StatesPerMonth) // alternative to map()
                  ChartBar(
                    fill: bucket.totalexpenses == 0
                        ? 0
                        : bucket.totalexpenses / maxTotalExpense,
                    total: bucket.totalexpenses,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: StatesPerMonth.map(
              (bucket) => Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Center(
                        child: Text(
                      bucket.month.toString(),
                      style: const TextStyle(color: Colors.white),
                    ))),
              ),
            ).toList(),
          )
        ],
      ),
    );
  }
}
