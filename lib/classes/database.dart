import 'dart:convert';
import 'package:clinic/classes/PatientDetails.dart';
import 'package:clinic/pages/Homepage.dart';
import 'package:http/http.dart' as http;

class Database {
  DateTime getdate(String id) {
    int day = int.parse(id.substring(8, 10));
    int year = int.parse(id.substring(0, 4));
    int month = int.parse(id.substring(5, 7));

    return DateTime(year, month, day);
  }

  String simplify(String text) {
    if (text == "عينه بالابره") {
      return "عينة";
    } else if (text == "عينه بالابره") {
      return "بزل";
    } else if (text == "عينه بالابره") {
      return "قسترة";
    } else if (text == "عينه بالابره") {
      return "موجات صوتية";
    } else if (text == "عينه بالابره") {
      return "موجات صوتيه و عينه";
    } else if (text == "عينه بالابره") {
      return "استشاره";
    } else if (text == "عينه بالابره") {
      return "بورت كاث";
    } else if (text == "عينه بالابره") {
      return "الصفراء";
    } else if (text == "عينه بالابره") {
      return "حقن";
    } else {
      return text;
    }
  }

  Future<List<Patientdetails>> loaddata() async {
    List<Patientdetails> loadedItems = [];
    final Url = Uri.https('patient-database-d4e04-default-rtdb.firebaseio.com',
        'test-list1823m5taU7qHBB3sTyf9o-K8pKY2aR8uftxuWYNSymY4.json');

    try {
      final response = await http.get(Url);

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        //print(response.body);
        // Check if responseData is not null and is a valid JSON object
        if (responseData != null && responseData is Map<String, dynamic>) {
          final Map<String, dynamic> data = responseData;

          // Now you can iterate through each entry and process the data...
          for (final entry in data['Form Responses 1'].entries) {
            final Map<String, dynamic> item = entry.value;
            var symptome = simplify(item['الاجراء المطلوب عمله ']);
            var medicine =
                item['هل يتناول المريض اي ادويه سيوله بخلاف الاسبرين'];
            if (medicine == 'نعم') {
              medicine = item['برجاء كتب اسم دواء السيوله'];
            }
            if (symptome == 'اخري') {
              symptome = item['اجراءات اخري'];
            }
            String phone;
            try {
              phone = item['رقم للتواصل به واتساب'];
              if (phone.substring(0, 1) != '0') {
                phone = '0$phone';
              }
            } catch (e) {
              phone = item['رقم للتواصل به واتساب'].toString();
              if (phone.substring(0, 1) != '0') {
                phone = '0$phone';
              }
            }

            loadedItems.add(Patientdetails(
              name: item['الاسم'],
              phone: phone,
              medicine: medicine,
              takhdeer: item['نوع التخدير'],
              date: getdate(item['Timestamp']),
              id: item['Timestamp'],
              symptome: symptome,
            ));
          }
        } else if (responseData == null) {
          print("Response body is empty.");
        } else {
          print("Response body is not a valid JSON object.");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (error) {
      print("An error occurred: $error");
    }
    try {
      loadedItems.sort((a, b) => a.name.compareTo(b.name));
    } catch (error) {
      print("An error occurred:$error");
    }
    loading = false;
    if (loadedItems.isNotEmpty) {
      return loadedItems;
    }
    return [];
  }

  ///////////////////////////////////////////////////////////////////////////////////////

//   Future<List<String>> loaddeleteddata() async {
//     deleteditems = [];
//     final Url = Uri.https(
//         'test2-20d77-default-rtdb.firebaseio.com', 'Deleted_patients.json');

//     try {
//       final response_deleted = await http.get(Url);

//       // Check if the response status code is 200 (OK)
//       if (response_deleted.statusCode == 200) {
//         print(response_deleted.body);
//         final dynamic deletedData = json.decode(response_deleted.body);

//         // Check if responseData is not null and is a valid JSON object
//         if (deletedData != null && deletedData is Map<String, dynamic>) {
//           final Map<String, dynamic> data = deletedData;
//           for (final entry in data.entries) {
//             final Map<String, dynamic> deleteditem = entry.va
//           }
//         } else if (deletedData == null) {
//           print("Response body is empty.");
//         } else {
//           print("Response body is not a valid JSON object.");
//         }
//       } else {
//         print("Failed to fetch data: ${response_deleted.statusCode}");
//       }
//     } catch (error) {
//       print("An error occurred: $error");
//     }
//     return deleteditems;
//   }
}

//  final Url = Uri.https('test2-20d77-default-rtdb.firebaseio.com',
//         'test-list1tDnKF_ZMWMWZiEMCyj4ZFI7tSMHJuWtqDQ1zwbOxQAo.json');

//     try {
//       final response = await http.get(Url);

//       // Check if the response status code is 200 (OK)
//       if (response.statusCode == 200) {
//         final dynamic responseData = json.decode(response.body);
//         //print(response.body);
//         // Check if responseData is not null and is a valid JSON object
//         if (responseData != null && responseData is Map<String, dynamic>) {
//           final Map<String, dynamic> data = responseData;

//           // Now you can iterate through each entry and process the data...
//           for (final entry in data['Form Responses 1'].entries) {
//             final Map<String, dynamic> item = entry.value;
//             var symptome = item['الاجراء المطلوب عمله '];
//             var medicine =
//                 item['هل يتناول المريض اي ادويه سيوله بخلاف الاسبرين'];
//             if (medicine == 'نعم') {
//               medicine = item['برجاء كتب اسم دواء السيوله'];
//             }
//             if (symptome == 'اخري') {
//               symptome = item['اجراءات اخري'];
//             }

//             loadedItems.add(Patientdetails(
//               name: item['الاسم'],
//               phone: item['رقم للتواصل به واتساب'],
//               medicine: medicine,
//               takhdeer: item['نوع التخدير'],
//               date: getdate(item['Timestamp']),
//               id: item['Timestamp'],
//               symptome: symptome,
//             ));
//           }
//         } else if (responseData == null) {
//           print("Response body is empty.");
//         } else {
//           print("Response body is not a valid JSON object.");
//         }
//       } else {
//         print("Failed to fetch data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("An error occurred: $error");
//     }
//     try {
//       loadedItems =
//           loadedItems.where((item) => !deleteditems.contains(item.id)).toList();
//       loadedItems.sort((a, b) => a.name.compareTo(b.name));
//     } catch (error) {
//       print("An error occurred:$error");
//     }
//     loading = false;
//     if (loadedItems.isNotEmpty) {
//       return loadedItems;
//     }
//     return [];
