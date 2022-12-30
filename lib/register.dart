import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
  late String chosenState = 'AL';
  late String firstName;
  late String lastName;
  late String email;
  late String state;
  late String userIsRegisteredMessage = "Not Registered.";
  late bool userRegisteredState = false;
  late Color userRegistrationColor = Colors.black;
}

class _RegisterState extends State<Register> {
  late TextEditingController _firstNameTextFieldController;
  late TextEditingController _lastNameTextFieldController;
  late TextEditingController _emailTextFieldController;
  bool isLoading = true;

  Future<void> getLocalRegistrationData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> items = [];
    widget.firstName = prefs.getString('firstName') ?? '';
    widget.lastName = prefs.getString('lastName') ?? '';
    widget.email = prefs.getString('email') ?? '';
    widget.state = prefs.getString('state') ?? '';
    _firstNameTextFieldController.text = widget.firstName;
    _lastNameTextFieldController.text = widget.lastName;
    _emailTextFieldController.text = widget.email;
    print('email is' + widget.email);
    userIsRegistered(widget.email);
  }

  // return 200 only if registered, else 404 (not found)
  Future<bool> userIsRegistered(String email) async {
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

    print('got the value from check register');
    print(userExists);
    var regMessage = '';
    var regState = false;
    var regColor = Colors.amber;

    if (userExists == true) {
      regMessage = 'You are already registered.';
      regState = true;
      regColor = Colors.teal;
    }
    else {
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

    return userExists;
  }


// save user registration locally (not stored to Firebase, etc)
  Future<void> saveDataLocally(String firstName, String lastName, String email,
      String state) async {
// obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // update local values

    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('state', state);
  }

  @override
  void initState() {
    _firstNameTextFieldController = new TextEditingController(text: '');
    _lastNameTextFieldController = new TextEditingController(text: '');
    _emailTextFieldController = new TextEditingController(text: '');
    widget.chosenState = 'AL';

    getLocalRegistrationData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title:
            Text("Register", style: TextStyle(fontWeight: FontWeight.w700)),
            centerTitle: true),
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20.0, bottom: 10.0),
                        child: isLoading ?
                        Center(child: CircularProgressIndicator()) :
                        new Text(
                          widget.userIsRegisteredMessage,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.userRegistrationColor,
                            fontSize: 16.0,
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
                            top: 20.0, left: 20.0, bottom: 25.0),
                        child: new TextField(
                          controller: _firstNameTextFieldController,
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: 'First name',
                              border: OutlineInputBorder()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16.0,
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
                        padding:
                        const EdgeInsets.only(left: 20.0, bottom: 25.0),
                        child: new TextField(
                          controller: _lastNameTextFieldController,
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: 'Last name',
                              border: OutlineInputBorder()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16.0,
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
                        padding:
                        const EdgeInsets.only(left: 20.0, bottom: 25.0),
                        child: new TextField(
                          controller: _emailTextFieldController,
                          autocorrect: false,
                          decoration: InputDecoration(
                              labelText: 'Email', border: OutlineInputBorder()),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                    children: <Widget>[
                      new Expanded(

                          child: new Center(

                            child: new Text("State",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ))
                    ]),
                Divider(
                  height: 24.0,
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    new Container(
                        padding: const EdgeInsets.only(left: 75, right: 25),
                        height: 25,
                        width: 250,
                        child: new WheelChooser(
                          horizontal: true,
                          onValueChanged: (s) =>
                          {
                            widget.chosenState = s.toString()
                          },
                          unSelectTextStyle: TextStyle(color: Colors.grey),
                          datas: [
                            "AL",
                            "AK",
                            "AZ",
                            "AR",
                            "CA",
                            "CO",
                            "CT",
                            "DE",
                            "FL",
                            "GA",
                            "HI",
                            "ID",
                            "IL",
                            "IN",
                            "IA",
                            "KS",
                            "KY",
                            "LA",
                            "ME",
                            "MD",
                            "MA",
                            "MI",
                            "MN",
                            "MS",
                            "MO",
                            "MT",
                            "NE",
                            "NV",
                            "NH",
                            "NJ",
                            "NM",
                            "NY",
                            "NC",
                            "ND",
                            "OH",
                            "OK",
                            "OR",
                            "PA",
                            "RI",
                            "SC",
                            "SD",
                            "TN",
                            "TX",
                            "UT",
                            "VT",
                            "VA",
                            "WA",
                            "WV",
                            "WI",
                            "WY"
                          ],
                        ))
                  ],
                ),
                Divider(
                  height: 34.0,
                  color: Colors.black54,
                ),

                new Wrap(
                  children: <Widget>[
                    new ElevatedButton(
                        onPressed: () async {
                          print(_firstNameTextFieldController.text + ' ' +
                              _lastNameTextFieldController.text + ' ' +
                              _emailTextFieldController.text + ' ' +
                              widget.chosenState);
                          if (widget.userRegisteredState == false) {
                            int statusCode = await sendRegistration(
                                _firstNameTextFieldController.text,
                                _lastNameTextFieldController.text,
                                _emailTextFieldController.text,
                                widget.chosenState);
                            print(statusCode);
                            if (statusCode == 200) {
                              widget.userIsRegisteredMessage =
                              "Registration successful.";
                            }
                            else if (statusCode == 202) {
                              widget.userIsRegisteredMessage = "User already registered.";
                            }
                            else {
                              widget.userIsRegisteredMessage =
                              "Unable to complete Registration. Please try again.";
                            }
                            saveDataLocally(_firstNameTextFieldController.text,
                                _lastNameTextFieldController.text,
                                _emailTextFieldController.text,
                                widget.chosenState);
                            ScaffoldMessenger.of(context).showSnackBar(
                                registrationSavedSnackBar);
                            //Navigator.of(context).pop();
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                alreadyRegisteredSnackBar);
                          }
                        },
                        child: Text(
                          "Register Now",
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
        ));
  }
}

class AppUserItem {
  final String first_name;
  final String last_name;
  final String email;

  const AppUserItem({
    required this.first_name,
    required this.last_name,
    required this.email,
  });

  factory AppUserItem.fromJson(Map<String, dynamic> json) {
    return AppUserItem(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
    );
  }
}

int sendRegistration(String firstName, String lastName,
    String email, String chosenState) {
  String API_USERNAME = "Admin";
  String API_PASSWORD = "pUQJ cKPv ku0q itbP 2Q5y Xasx";
  final bytes = utf8.encode(API_USERNAME + ":" + API_PASSWORD);
  final base64Str = base64.encode(bytes);
  String AUTH = "Basic " + base64Str;
  DateTime now = new DateTime.now();
  int statusCodeResponse = 404;

  print('starting send reg');
  http.Response aResponse = http.get(
      Uri.parse('https://configuremyapp.com/wp-json/jet-cct/appusers'),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': AUTH
      }) as http.Response;

  bool userExists = false;
  if (aResponse.statusCode == 200) {
    List<dynamic> list = json.decode(aResponse.body);
    var item;
    for (item in list) {
      AppUserItem anAppUserItem = AppUserItem.fromJson(item);
      print('compare: ' + anAppUserItem.email + ' to ' + email);
      if (anAppUserItem.email == email) {
        print('***** found it');
        userExists = true;
        statusCodeResponse = 200;
        break;
      }
    }
    print('user exists extra check ' + userExists.toString());
    if (userExists == false) {
      String uriStr = "https://configuremyapp.com/wp-json/jet-cct/appusers/";
      print("POSTING to " + uriStr);
      http.Response response = http.post(
        Uri.parse(uriStr),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'authorization': AUTH
        },
        body: jsonEncode(<String, String>{
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'state': chosenState,
          'app_version': 'Flutter Android',
          'date_registered': now.toString(),
        }),
      ) as http.Response;
      statusCodeResponse = response.statusCode;
    }
    else {
      print('already registered, did not do another');
      statusCodeResponse = 202;
    }
  }
  return statusCodeResponse;
}

  const SnackBar registrationSavedSnackBar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.deepOrange,
      content: ListTile(
        title: Text(
          "Registration successful",
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
      ));

  const SnackBar alreadyRegisteredSnackBar = SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.deepOrange,
      content: ListTile(
        title: Text(
          "You are already registered.",
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal),
        ),
      ));

