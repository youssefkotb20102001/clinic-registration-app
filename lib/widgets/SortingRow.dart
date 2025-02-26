import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SortingRow extends StatefulWidget {
  SortingRow({super.key, required this.method, required this.list});
  final void Function(String) method;
  List<String> list;
  State<SortingRow> createState() {
    return _SortingRowState();
  }
}

class _SortingRowState extends State<SortingRow> {
  var selectedIndex = -1;
  // var container_color = Colors.white;
  // void changeColor() {
  //   setState(() {
  //     if (container_color == Colors.white) {
  //       container_color = Colors.red;
  //       widget.sort(widget.text);
  //     } else {
  //       container_color = Colors.white;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
      child: Center(
        child: SizedBox(
          height: height * 0.09,
          child: Center(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length, // Your list length
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Color.fromARGB(255, 2, 61, 86),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.method(widget.list[index]);
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   width: width * 0.05,
                        // ),
                        Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: index == selectedIndex
                                  ? Color.fromARGB(255, 2, 61, 86)
                                  : Colors
                                      .white, // Change color based on selection

                              borderRadius: BorderRadius.circular(15),
                              border: index == selectedIndex
                                  ? Border.all(
                                      color: Color.fromARGB(255, 2, 61, 86),
                                    )
                                  : Border.all(
                                      color: Color.fromARGB(255, 2, 61, 86),
                                    ),
                            ),
                            child: SizedBox(
                              height: height * 0.05,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.list[index],
                                    style: TextStyle(
                                        color: index == selectedIndex
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                255, 2, 61, 86),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          width: width * 0.1,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
