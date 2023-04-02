import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Contact extends StatefulWidget {

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  bool isLoading = true;
  final _key = UniqueKey();

  DisplayRemotePageState(String title, String url) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text(
              "Contact us", style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: 'https://thepublicsquare.com/contact/',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }
}