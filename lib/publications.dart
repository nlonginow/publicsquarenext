import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_bottom_navigation.dart';
import 'programlisting.dart';

class PubsPage extends StatefulWidget {
  const PubsPage();

  @override
  _PubsPageState createState() => _PubsPageState();
}

class _PubsPageState extends State<PubsPage> {
  Map<int, Color> color = {
    50: const Color.fromRGBO(250, 202, 88, .1),
    100: const Color.fromRGBO(250, 202, 88, .2),
    200: const Color.fromRGBO(250, 202, 88, .3),
    300: const Color.fromRGBO(250, 202, 88, .4),
    400: const Color.fromRGBO(250, 202, 88, .5),
    500: const Color.fromRGBO(250, 202, 88, .6),
    600: const Color.fromRGBO(250, 202, 88, .7),
    700: const Color.fromRGBO(250, 202, 88, .8),
    800: const Color.fromRGBO(250, 202, 88, .9),
    900: const Color.fromRGBO(250, 202, 88, 1),
  };

  final arrBottomItems = [
    tabItem('Common Good Blog', Icons.podcasts_sharp),
    tabItem('Your Monthly Update', Icons.document_scanner_sharp),
  ];

  var selectedItem = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialColor colorCustom = MaterialColor(0xFFFACA58, color);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text("Publications"),
            brightness: Brightness.dark),
        body: MyPubsGridView());
  }
}

class MyPubsGridView extends StatefulWidget {
  const MyPubsGridView();

  @override
  State<StatefulWidget> createState() {
    return _MyPubsGridViewState();
  }
}

class Choice {
  const Choice({required this.title, required this.iconImageName});

  final String title;
  final String iconImageName;
}

const List<Choice> choices = const [
  const Choice(
      title: 'Common Good Blog', iconImageName: "assets/images/tps60.jpg"),
  const Choice(
      title: 'Your Monthly Update', iconImageName: "assets/images/short.jpg"),
];

class _MyPubsGridViewState extends State<MyPubsGridView> {
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
                    case PubsCardTypes.CommonGood:
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
                    case PubsCardTypes.MonthlyUpdate:
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
                    default:
                      {
                        //statements;
                      }
                      break;
                  }
                },
                child: new PubsChoiceCard(
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
class PubsCardTypes {
  static const CommonGood = 0;
  static const MonthlyUpdate = 1;
}

class PubsChoiceCard extends StatelessWidget {
  const PubsChoiceCard({required Key key, required this.choice})
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
