import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../models/programtypes.dart';

Future<List<MonthlyUpdateItem>> fetchMonthlyUpdateItems() async {

  List<MonthlyUpdateItem> monthlyUpdateItems = <MonthlyUpdateItem>[];
  var db = FirebaseFirestore.instance;
  await db.collection("Postings").get().then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      var theData = docSnapshot.data();
      var valuesList = theData.values.toList();

      // tilegraphic, pdfffile, publisheddate
      var tilegraphic = valuesList[0];
      var pdffile = valuesList[1] as String;
      var publishedDate = valuesList[2] as String;
      var theTitle = "Monthly Update for " + publishedDate;

      MonthlyUpdateItem anItem = MonthlyUpdateItem(title: theTitle,
          pdfUrl: pdffile, jpgUrl: tilegraphic, postedDate: publishedDate);
      monthlyUpdateItems.add(anItem);

    }
  });
  return monthlyUpdateItems;
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

Future<bool> fetchUserByEmail(String checkThisEmail) async {
  var userExists = false;
  var db = FirebaseFirestore.instance;
  await db.collection("TPSRegistered").get().then((querySnapshot) {
    for (var docSnapshot in querySnapshot.docs) {
      var theData = docSnapshot.data();
      var valuesList = theData.values.toList();

      // registered, email
      var descStr = valuesList[0];
      var existingEmail = valuesList[1] as String;
      if (existingEmail == checkThisEmail) {
        userExists = true;
        break;
      }
    }
  });
  return userExists;
}
