import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:publicsquarenext/home.dart';
import 'package:publicsquarenext/main.dart';
import 'package:publicsquarenext/themore/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../publications.dart';

class AskToRegister extends StatefulWidget {
  late String userIsRegisteredMessage = "Not Registered.";
  late bool userRegisteredState = false;
  late Color userRegistrationColor = Colors.black;

  @override
  _AskToRegisterState createState() => _AskToRegisterState();
}

class _AskToRegisterState extends State<AskToRegister> {
  bool isLoading = true;

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register(sourcePage: 'ASKTOREGISTER')),
    );

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print('did update called');
  }

  @override
  void initState() {
    // if got here, it's because displayPdf checked and found not registered
    // no need to check again...
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(
                      )),
                );
              },
              icon:Icon(Icons.arrow_back),//replace with our own icon data.
            ),
            title:
            Text("Registration Required", style: TextStyle(fontWeight: FontWeight.w700)),
            centerTitle: true),
        body:  Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 20.0, bottom: 25.0),
                        child: new Text(
                          'Please register to stay connected with The Public Square. We value your partnership. Your email is never sold, marketed or used to create email spam. '
                              'Any email you might receive from us will include an unsubscribe link.',
                          style: new TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Roboto',
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                new Wrap(
                  children: <Widget>[
                    new ElevatedButton(
                        onPressed: ()  {

                            _navigateAndDisplaySelection(context);

//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                              builder: (context) => Register()
//                          )
//                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith<
                              EdgeInsetsGeometry>(
                                (Set<MaterialState> states) {
                              return EdgeInsets.only(
                                  left: 40.0,
                                  right: 40.0,
                                  top: 10.0,
                                  bottom: 10.0);
                            },
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
