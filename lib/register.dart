import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController _titleTextFieldController;
  late TextEditingController _commentTextFieldController;

  @override
  void initState() {
//    _titleTextFieldController = new TextEditingController(text: widget.theTitle);
//    _commentTextFieldController = new TextEditingController(text: widget.theComment);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text(
                "Register", style: TextStyle(fontWeight: FontWeight.w700)),
            centerTitle: true
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(2),
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, bottom: 25.0),
                        child: new TextField(
                          decoration: InputDecoration(labelText: 'First name'),
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
                Divider(
                  height: 24.0,
                  color: Colors.blue,
                ),
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, bottom: 25.0),
                        child: new TextField(
                          decoration: InputDecoration(labelText: 'Last name'),
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
                Divider(
                  height: 24.0,
                  color: Colors.blue,
                ),
                Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, bottom: 25.0),
                        child: new TextField(
                          decoration: InputDecoration(labelText: 'Email'),
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

                Divider(
                  height: 24.0,
                  color: Colors.blue,
                ),
                new Wrap(
                  children: <Widget>[
                    new ElevatedButton(
                        onPressed: () async {
                          print('pressed!');
                          // ScaffoldMessenger.of(context).showSnackBar(testimonialSavedSnackBar);
                          Navigator.of(context).pop();
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
        ));
  }
}