import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill, required this.total});

  final double fill;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: Color.fromARGB(255, 2, 61, 86),
            ),
            child: Center(
                child: Text(
              total.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
