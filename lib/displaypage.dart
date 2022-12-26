import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayRemotePage extends StatefulWidget {
  final String theTitle;
  final String theUrl;

  const DisplayRemotePage(
      {required this.theTitle,
        required this.theUrl});

  @override
  _DisplayRemotePageState createState() => _DisplayRemotePageState();
}

class _DisplayRemotePageState extends State<DisplayRemotePage> {

  bool isLoading = true;
  final _key = UniqueKey();

  DisplayRemotePageState(String title, String url) {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: Text(
              widget.theTitle, style: TextStyle(fontWeight: FontWeight.w700)),
          centerTitle: true
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.theUrl,
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