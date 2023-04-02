import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Support extends StatefulWidget {

  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {

  bool isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text(
              "Support us", style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: 'https://thepublicsquare.com/donate/',
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