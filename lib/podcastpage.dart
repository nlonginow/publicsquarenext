import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_bottom_navigation.dart';
import 'programlisting.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage();

  @override
  _PodcastPageState createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
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
    tabItem('Programs', Icons.podcasts_sharp),
    tabItem('Publications2', Icons.document_scanner_sharp),
    tabItem('AudioBook', Icons.audiotrack),
    tabItem('More', Icons.more),
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
            title: Text("Podcasts"),
            brightness: Brightness.dark),
        body: MyPodcastGridView());
  }
}

class MyPodcastGridView extends StatefulWidget {
  const MyPodcastGridView();

  @override
  State<StatefulWidget> createState() {
    return _MyPodcastGridViewState();
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
      title: 'Christmas in America', iconImageName: "assets/images/cia.jpg"),
  const Choice(
      title: 'The Pine Podcast',
      iconImageName: "assets/images/ridingthepine.png"),
];

class _MyPodcastGridViewState extends State<MyPodcastGridView> {
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
                    case PodcastCardTypes.TPS60:
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
                    case PodcastCardTypes.TPS2:
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
                    case PodcastCardTypes.TPSExpress:
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
                    case PodcastCardTypes.Christmas:
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
                    case PodcastCardTypes.ThePine:
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
                    default:
                      {
                        //statements;
                      }
                      break;
                  }
                },
                child: new PodcastChoiceCard(
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
class PodcastCardTypes {
  static const TPS60 = 0;
  static const TPS2 = 1;
  static const TPSExpress = 2;
  static const Christmas = 3;
  static const ThePine = 4;
}

class PodcastChoiceCard extends StatelessWidget {
  const PodcastChoiceCard({required Key key, required this.choice})
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
