import 'dart:convert';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:publicsquarenext/fetchUtils/firebasefetch.dart';
import 'package:publicsquarenext/themore/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'themore/askToRegister.dart';

const List<Color> _kDefaultRainbowColors = const [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple,
];

class DisplayRemotePDF extends StatefulWidget {
  final String title;
  final String theUrl;
  final String theTitle;

  DisplayRemotePDF(
      {required this.title, required this.theUrl, required this.theTitle});

  @override
  _DisplayRemotePDFState createState() => _DisplayRemotePDFState();
}

class _DisplayRemotePDFState extends State<DisplayRemotePDF> {
  bool _userIsRegistered = false;
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      Uri aUrl = Uri.parse(widget.theUrl);
      var data = await http.get(aUrl);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  Future<bool> userIsRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> items = [];
    var userExists = false;
    // no local registration? then must register...
    var email = prefs.getString('email') ?? '';
    if (email == null || email == '') {
      return false;
    }
    else {
      userExists = await fetchUserByEmail(email);
    }
    return userExists;
  }

  @override
 void initState() {
    // download the PDF... even if they dont register, it will be here for when they do.
    // its a hit on their storage, but simplifies the code here
    getFileFromUrl(widget.theUrl).then(
          (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    userIsRegistered().then((result) {
      print("userisregistered result: $result");
      _userIsRegistered = result;
      if (result == false) {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => AskToRegister()));
      }
      FirebaseAnalytics analytics = FirebaseAnalytics.instance;
      FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
      analytics.setCurrentScreen(screenName: 'MonthlyUpdatePage');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(urlPDFPath);
    if (loaded) {
      return Scaffold(
        appBar: new AppBar(
            title: Text(widget.title,
                style: TextStyle(fontWeight: FontWeight.w700)),
            centerTitle: true),
        body: PDFView(
          filePath: urlPDFPath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          swipeHorizontal: true,
          nightMode: false,
          onError: (e) {
            //Show some error message or UI
          },
          onRender: (_pages) {
            setState(() {
              _totalPages = _pages!;
              pdfReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            setState(() {
              _pdfViewController = vc;
            });
          },
          onPageChanged: (int? page, int? total) {
            print('page change: $page/$total');
            setState(() {
              _currentPage = page!;
            });
          },
          onPageError: (page, e) {},
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return Scaffold(
          appBar: AppBar(
            title: Text("loading..."),
          ),
          body: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 75, left: 20, right: 20),
              child: LoadingIndicator(
                indicatorType: Indicator.ballScaleMultiple,
                colors: _kDefaultRainbowColors,
                strokeWidth: 4.0,
                pathBackgroundColor: Colors.black45,
              )),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            title: Text("loading..."),
          ),
          body: Text(
            "PDF Not Available",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
