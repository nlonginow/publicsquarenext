import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publicsquarenext/themore/register.dart';
import 'package:publicsquarenext/themore/support.dart';

import 'about.dart';
import '../app_bottom_navigation.dart';
import 'contact.dart';
import '../programlisting.dart';

class MorePage extends StatefulWidget {
  const MorePage();

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text("More"),
            brightness: Brightness.dark),
        body: MyMoreGridView());
  }
}

class MyMoreGridView extends StatefulWidget {
  const MyMoreGridView();

  @override
  State<StatefulWidget> createState() {
    return _MyMoreGridViewState();
  }
}

class Choice {
  const Choice({required this.title, required this.iconImageName});

  final String title;
  final String iconImageName;
}

const List<Choice> choices = const [
  const Choice(
      title: 'Register', iconImageName: "assets/images/register.png"),
  const Choice(
      title: 'About', iconImageName: "assets/images/about.png"),
  const Choice(
      title: 'Support', iconImageName: "assets/images/support.png"),
  const Choice(
      title: 'Contact', iconImageName: "assets/images/contact.png"),
];

class _MyMoreGridViewState extends State<MyMoreGridView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(5.0)),
        GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          // to disable GridView's scrolling
          shrinkWrap: true,
          // You won't see infinite size error
          children: List.generate(choices.length, (index) {
            return Center(
              child: InkWell(
                onTap: () {
                  switch (index) {
                    case MoreCardTypes.Register:
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register(sourcePage: 'MANUALREGISTER')
                          ),
                        );
                      }
                      break;
                    case MoreCardTypes.About:
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => About(
                              )),
                        );
                      }
                      break;
                    case MoreCardTypes.Support:
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Support()),
                        );
                      }
                      break;
                    case MoreCardTypes.Contact:
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Contact()),
                        );
                      }
                      break;
                    default:
                      {
                        //statements;
                      }
                      break;
                  }
                },
                child: new MoreChoiceCard(
                  choice: choices[index],
                  key: Key("title"),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class MoreCardTypes {
  static const Register = 0;
  static const About = 1;
  static const Support = 2;
  static const Contact = 3;
}

class MoreChoiceCard extends StatelessWidget {
  const MoreChoiceCard({required Key key, required this.choice})
      : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(choice.iconImageName)))),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  choice.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                // put some space at the bottom of the Card
              ]),
        ));
  }
}
