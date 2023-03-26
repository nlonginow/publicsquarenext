import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../models/programtypes.dart';

Future<List<MonthlyUpdateItem>> fetchMonthlyUpdateItems() async {
  String API_USERNAME = "Admin";
  String API_PASSWORD = "pUQJ cKPv ku0q itbP 2Q5y Xasx";
  final bytes = utf8.encode(API_USERNAME + ":" + API_PASSWORD);
  final base64Str = base64.encode(bytes);
  String AUTH = "Basic " + base64Str;

  final response = await http.get(
    Uri.parse('https://configuremyapp.com/wp-json/jet-cct/tpsmonthlyupdate'),
    headers: {
      HttpHeaders.authorizationHeader: AUTH,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> list = json.decode(response.body);
    var item;
    var myList = <MonthlyUpdateItem>[];
    for (item in list) {
      MonthlyUpdateItem aMonthlyUpdateItem = MonthlyUpdateItem.fromJson(item);
      myList.add(aMonthlyUpdateItem);
    }
    return myList;
  } else {
    throw Exception("Failed to fetch Monthly Update items");
  }
}

Future<List<ChristmasItem>> fetchChristmasItems() async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "nicklonginow@gmail.com",
        password: "P@ssw0rd060504"
    );
  } on Exception catch  (e) {
    print('Error with authentication: ' + e.toString()  );
  }

  var myList = <ChristmasItem>[];
  var db = FirebaseFirestore.instance;
  db.collection("CIAPrograms").get().then(
        (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        List<dynamic> list = querySnapshot.docs.map((doc) => doc.data()).toList();
        var item;
        for (item in list) {
          ChristmasItem aChristmasItem = ChristmasItem.fromJson(item);
          myList.add(aChristmasItem);
        }
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
  return myList;
}