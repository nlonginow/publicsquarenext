import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:publicsquarenext/home.dart';
import 'package:publicsquarenext/register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AskToRegister extends StatefulWidget {
  @override
  _AskToRegisterState createState() => _AskToRegisterState();
}

class _AskToRegisterState extends State<AskToRegister> {

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Register(sourcePage: 'ASKTOREGISTER')),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    // don't really care who the caller was in the return... if we got here,
    // then it was from the ask to register page and we can pop back
    // to the prior page which will be the displaypdf.
    // tree
    // displaypdf (which already preloaded the pdf file)
    //   asktoregiser
    //     register (drops back to asktoregister)
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    print('did update called');
  }

  Future<bool> userIsRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> items = [];
    // no local registration? then must register...
    var email = prefs.getString('email') ?? '';
    if (email == null || email == '') {
      return false;
    }

    String API_USERNAME = "Admin";
    String API_PASSWORD = "pUQJ cKPv ku0q itbP 2Q5y Xasx";
    final bytes = utf8.encode(API_USERNAME + ":" + API_PASSWORD);
    final base64Str = base64.encode(bytes);
    String AUTH = "Basic " + base64Str;
    DateTime now = new DateTime.now();

    final response = await http.get(
        Uri.parse('https://configuremyapp.com/wp-json/jet-cct/appusers'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'authorization': AUTH
        });

    print('checking if already registered');
    bool userExists = false;
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      var item;
      var myList = <AppUserItem>[];
      for (item in list) {
        AppUserItem anAppUserItem = AppUserItem.fromJson(item);
        print('comparing ' + email + ' to ' + anAppUserItem.email);
        if (anAppUserItem.email == email) {
          userExists = true;
          break;
        }
      }
    }
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
