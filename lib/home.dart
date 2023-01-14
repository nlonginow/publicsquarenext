import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publicsquarenext/register.dart';

import 'audiobook.dart';
import 'programlisting.dart';

class PrimaryApp extends StatefulWidget {
  const PrimaryApp();

  @override
  _PrimaryAppState createState() => _PrimaryAppState();
}

class _PrimaryAppState extends State<PrimaryApp> {
  var selectedItem = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: const Text('The Public Square',
                  style: TextStyle(color: Colors.white)),
              actions: [
                PopupMenuButton(onSelected: (value) {
                  // your logic
                  setState(() {
                    selectedItem = value.toString();
                  });
                  print(value);
                  Navigator.pushNamed(context, value.toString());
                }, itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      child: Text("Register"),
                      value: '/register',
                    ),
                    PopupMenuItem(
                      child: Text("Support"),
                      value: '/support',
                    ),
                    PopupMenuItem(
                      child: Text("About"),
                      value: '/about',
                    ),
                  ];
                })
              ],
              backgroundColor: Colors.black,
            ),
            body: MyGridView()),
      routes: {
        '/register': (context) => Register(sourcePage: 'HOME'),
      },
    );
  }
}

class MyGridView extends StatefulWidget {
  const MyGridView();

  @override
  State<StatefulWidget> createState() {
    return _MyGridViewState();
  }
}

class Choice {
  const Choice({required this.title, required this.iconImageName});

  final String title;
  final String iconImageName;
}

const List<Choice> choices = const [
  const Choice(
      title: '60 Minute Program', iconImageName: "assets/images/tps60.jpg"),
  const Choice(
      title: '2 Minute Program', iconImageName: "assets/images/short.jpg"),
  const Choice(
      title: 'TPS Express Program', iconImageName: "assets/images/express.jpg"),
  const Choice(
      title: 'For The Common Good Blog',
      iconImageName: "assets/images/blog.jpg"),
  const Choice(
      title: 'Your Monthly Update',
      iconImageName: "assets/images/monthly.jpg"),
  const Choice(
      title: 'Christmas in America',
      iconImageName: "assets/images/cia.jpg"),
  const Choice(
      title: 'The Pine Podcast', iconImageName: "assets/images/ridingthepine.png"),
  const Choice(
      title: 'Audio Book', iconImageName: "assets/images/gilbertandjack.jpg"),
];

class _MyGridViewState extends State<MyGridView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.animateTo(2);
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
                        case CardTypes.TPS60:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'TPS60',
                                      )), //FinisherLessons(user: _currentUser, currentPage: 1,)),
                            );
                          }
                          break;
                        case CardTypes.TPS2:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'TPS2',
                                      )),
                            );
                          }
                          break;
                        case CardTypes.TPSExpress:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'TPSExpress',
                                      )),
                            );
                          }
                          break;
                        case CardTypes.CommonGood:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'Common Good Blog',
                                      )),
                            );
                          }
                          break;
                        case CardTypes.MonthlyUpdate:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'Monthly Update',
                                      )),
                            );
                          }
                          break;
                        case CardTypes.Christmas:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'CIA',
                                      )),
                            );
                          }
                          break;
                        case CardTypes.ThePine:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProgramListing(
                                        podcastname: 'The Pine Podcast',
                                      )),
                            );
                          }
                          break;
                        case CardTypes.GilbertAndJack:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AudioBook()),
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
                    child: new ChoiceCard(
                      choice: choices[index],
                      key: Key("title"),
                    ),
                  ),
                );
              }),
            ),
            // ...... other list children.
          ],
    );
  }
}

//
// Card details
//
class CardTypes {
  static const TPS60 = 0;
  static const TPS2 = 1;
  static const TPSExpress = 2;
  static const CommonGood = 3;
  static const MonthlyUpdate = 4;
  static const Christmas = 5;
  static const ThePine = 6;
  static const GilbertAndJack = 7;
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({required Key key, required this.choice}) : super(key: key);

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

const SnackBar notYetImplementedSnackBar = SnackBar(
    duration: Duration(seconds: 2),
    backgroundColor: Colors.amberAccent,
    content: ListTile(
      title: Text(
        "This page is not yet implemented.",
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
      ),
    ));
