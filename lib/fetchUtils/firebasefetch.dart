import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<ChristmasItem> ciaItems = <ChristmasItem>[];
  var db = FirebaseFirestore.instance;
  await db.collection("CIAPrograms").get().then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      var theData = docSnapshot.data();
      var valuesList = theData.values.toList();
      // description, timestamp, mp3, title
      var descStr = valuesList[0];
      var timeStampVal = valuesList[1] as Timestamp;
      var programDate = timeStampVal.toDate().toString();
      var theMp3 = 'https://www.aproundtable.org/app/' + valuesList[2];
      var theTitle = valuesList[3];

      ChristmasItem anItem = ChristmasItem(
          title: theTitle,
          program_url: theMp3,
          program_date: programDate,
          program_description: descStr);
      ciaItems.add(anItem);
    }
  });
  return ciaItems;
}

