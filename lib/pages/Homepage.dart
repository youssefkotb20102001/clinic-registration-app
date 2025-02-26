import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/classes/database.dart';
import 'package:clinic/pages/States.dart';
import 'package:clinic/pages/Table.dart';
import 'package:clinic/pages/Today.dart';
import 'package:clinic/pages/TomorrowsList.dart';
import 'package:clinic/pages/overlay.dart';
import 'package:clinic/widgets/CardList.dart';
import 'package:clinic/widgets/SortingRow.dart';
import 'package:flutter/material.dart';

//import 'package:intl/intl.dart';
class Homepage extends StatefulWidget {
  State<Homepage> createState() {
    return _HomepageState();
  }
}

List<Patientdetails> loadedItems = [];
bool loading = true;
Database db = new Database();

class _HomepageState extends State<Homepage> {
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 2, 61, 86),
            ),
            child: Text(
              'Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('HomePage'),
            onTap: () {
              //   _refreshApp(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_graph_rounded),
            title: const Text('States'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => States(patients: loadedItems)));
              //Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.table_chart_sharp),
            title: const Text('Table'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => OpenGoogleSheet()));
            },
          ),
        ],
      ),
    );
  }

  void loadData() async {
    Database db = new Database();
    var list = await db.loaddata();
    setState(() {
      loadedItems = list;
    });
  }

  int pageindex = 0;
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void showerrormessage() {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: const Text('No Internet Connection'),
              content: const Text(
                  'Please check your internet connection and try again'),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(ctx);
                    }),
                    child: const Text('Close'))
              ],
            )));
  }

  DateTime getdate(String id) {
    int day = int.parse(id.substring(8, 10));
    int year = int.parse(id.substring(0, 4));
    int month = int.parse(id.substring(5, 7));

    return DateTime(year, month, day);
  }

  void _selectpage(int index) {
    setState(() {
      pageindex = index;
    });
  }

  String formatdate(DateTime date) {
    return formatter.format(date);
  }

  void removepatient() {
    // final expenseindex = loadedItems.indexOf(patient);
    // setState(() {
    //   loadedItems.remove(patient);
    // });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Patient deleted'),
      ),
    );
  }

  void _refreshApp(BuildContext context) async {
    loadedItems = [];
    Database db = new Database();
    var list = await db.loaddata();
    setState(() {
      loadedItems = list;
    });
    // This code restarts the entire Flutter app
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage(),
      ),
    );
  }

  void _OpenAddExpenseOverlay() {
    showModalBottomSheet(
        //useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        builder: ((ctx) {
          return OverlayScreens();
        }));
  }

  void SortByDate() {
    setState(() {
      loadedItems.sort((a, b) => b.date.compareTo(a.date));
    });
  }

  void SortByName() {
    setState(() {
      loadedItems.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void sort(String text) {
    if (text == "Date") {
      SortByDate();
    } else {
      SortByName();
    }
  }

  @override
  Widget build(BuildContext context) {
    loading = true;
    Widget activescreen;
    if (loadedItems.isNotEmpty) {
      activescreen = Expanded(
          child: Todaylist(
              allpatients: loadedItems, removepatient: removepatient));
    } else {
      if (loading == true) {
        activescreen = const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        activescreen = const Center(child: Text('No patients yet'));
      }
    }

    if (pageindex == 2) {
      if (loadedItems.isNotEmpty) {
        activescreen = Expanded(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text("All patient's",
                    style: TextStyle(
                        color: Color.fromARGB(255, 2, 61, 86),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: AutofillHints.familyName)),
              ),
              SortingRow(method: sort, list: const ["Date", "AZ"]),
              Expanded(
                child: CardList(
                  list: loadedItems,
                  removepatient: removepatient,
                ),
              ),
            ],
          ),
        );
      } else {
        if (loading == true) {
          activescreen = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          activescreen = const Center(child: Text('No patients yet'));
        }
      }
    } else if (pageindex == 1) {
      if (loadedItems.isNotEmpty) {
        activescreen = Expanded(
            child: Tomorrowslist(
          allpatients: loadedItems,
          removepatient: removepatient,
        ));
      } else {
        if (loading == true) {
          activescreen = const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          activescreen = const Center(child: Text('No patients yet'));
        }
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Patients Form",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 2, 61, 86),
          actions: [
            IconButton(
                onPressed: () {
                  _OpenAddExpenseOverlay();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        drawer: _buildDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: const Color.fromARGB(255, 2, 61, 86),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          currentIndex:
              pageindex, //this made the selected category highlighted...
          onTap: _selectpage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.today), label: 'Today'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Tomorrow'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'All list'),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    children: [
                      const Text('Hi Amr',
                          style: TextStyle(
                              color: Color.fromARGB(255, 2, 61, 86),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: AutofillHints.familyName)),
                      Text(formatdate(DateTime.now()),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 2, 61, 86),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: AutofillHints.familyName))
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      _refreshApp(context);
                    },
                    icon: const Icon(Icons.refresh),
                    color: const Color.fromARGB(255, 2, 61, 86),
                  )
                ],
              ),
            ),
            activescreen,
          ],
        ));
  }
}
