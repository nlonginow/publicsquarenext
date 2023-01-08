import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:publicsquarenext/home.dart';
import 'package:publicsquarenext/register.dart';

class AskToRegister extends StatefulWidget {
  @override
  _AskToRegisterState createState() => _AskToRegisterState();
}

class _AskToRegisterState extends State<AskToRegister> {

  @override
  void initState() {
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => Register()
                          )
                          );
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
