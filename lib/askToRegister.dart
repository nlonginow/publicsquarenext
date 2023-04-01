import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:publicsquarenext/home.dart';
import 'package:publicsquarenext/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> userIsRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email') ?? '';
    if (email == null || email == '') {
      return false;
    }

    bool userExists = false;
    var db = FirebaseFirestore.instance;
    await db.collection("TPSAppRegistered").get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        var theData = docSnapshot.data();

        var valuesList = theData.values.toList();
        var existingEmail = valuesList[4] as String;
        if (existingEmail == email) {
          userExists = true;
          break;
        }
      }
    });
    var regMessage = '';
    var regState = false;
    var regColor = Colors.amber;

    if (userExists == true) {
      regMessage = 'You are already registered.';
      regState = true;
      regColor = Colors.teal;
    } else {
      regMessage = 'Not Registered.';
      regState = false;
      regColor = Colors.red;
    }
    setState(() {
      isLoading = false;
      widget.userIsRegisteredMessage = regMessage;
      widget.userRegisteredState = regState;
      widget.userRegistrationColor = regColor;
    });

    setState(() {
      isLoading = false;
    });

    return userExists;
  }

  @override
  void initState() {
    userIsRegistered().then((result) {
      print("userisregistered result: $result");
      if (result == true) {  // then we got here as a Pop from Register page; pop back to the PDF page
        Navigator.of(context).pop();
      }
    }
    );
    super.initState();
  }

  //
  //  add the isloading indicator row
  // add the text to say "not registered" if not so.
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrimaryApp(
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
                            top: 2.0, left: 20.0, bottom: 2.0),
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : new Text(
                          widget.userIsRegisteredMessage,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.userRegistrationColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 20.0, bottom: 25.0),
                        child: new Text(
                          'Please register to stay connected with The Public Square. We value your partnership. Your email is never sold, marketed or used to create email spam. '
                              'Any email you might receive from us will include an unsubscribe link.',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 14.0,
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
