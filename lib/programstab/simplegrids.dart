import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publicsquarenext/playermain.dart';
import 'package:publicsquarenext/programlisting.dart';

class SimpleGridsPage extends StatefulWidget {
  const SimpleGridsPage();

  @override
  _SimpleGridsPageState createState() => _SimpleGridsPageState();
}

class _SimpleGridsPageState extends State<SimpleGridsPage> {
  @override
  void initState() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);
    analytics.setCurrentScreen(screenName: 'ProgramsPage');
    super.initState();
  }

  final gridTitleItems = [
    'TPS60',
    'TPS Express',
    'The Pine',
    'Christmas in America'
  ];

  final gridShowNames = [
    'TPS60',
    'TPSExpress',
    'The Pine Podcast',
    'CIA'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programs'),
      ),
      body: new ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          new Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: ScrollPhysics(),
              itemBuilder: (context, outerIndex) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      height: 35.0,
                      color: Colors.black,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(right: 5.0)),
                          new Text(gridTitleItems[outerIndex],
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    new Container(
                        height: 210.0, // this will have the future in it
                        child: FutureBuilder<List<PodcastItem>>(
                            future:
                                getShowsForProgram(gridShowNames[outerIndex]),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const AlertDialog(
                                    title: Text("Error"),
                                    content: Text('An error has occurred...'),
                                  ),
                                );
                              } else if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return new Card(
                                        elevation: 5.0,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlayerMain(
                                                          theTitle: snapshot
                                                                      .data?[
                                                                          index]
                                                                      .title ==
                                                                  null
                                                              ? "title"
                                                              : snapshot
                                                                  .data![index]
                                                                  .title,
                                                          theUrl: snapshot
                                                                      .data?[
                                                                          index]
                                                                      .url ==
                                                                  null
                                                              ? "url"
                                                              : snapshot
                                                                  .data![index]
                                                                  .url,
                                                          theCover: snapshot
                                                                      .data?[
                                                                          index]
                                                                      .cover ==
                                                                  null
                                                              ? "cover"
                                                              : snapshot
                                                                  .data![index]
                                                                  .cover,
                                                          theDescription: snapshot
                                                                      .data?[
                                                                          index]
                                                                      .description ==
                                                                  null
                                                              ? "description"
                                                              : snapshot
                                                                  .data![index]
                                                                  .description,
                                                        )),
                                              );
                                            },
                                            child: Container(
                                                height: 95,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.7,
                                                alignment: Alignment.center,
                                                child: new Column(
                                                    children: <Widget>[
                                                      new Padding(
                                                          padding: const EdgeInsets.only(top: 5.0)),
                                                      Container(
                                                          width: 115,
                                                          height: 115,
                                                          color: Colors.white,
                                                          child: ClipRect(
                                                            child: Container(
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  widthFactor:
                                                                      0.8,
                                                                  heightFactor:
                                                                      1.0,
                                                                  child: Container(
                                                                      //height: 120,
                                                                      //width: 120,
                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0), image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(snapshot.data![index].cover))))),
                                                            ),
                                                          )),
                                            SizedBox(
                                                width: 150,
                                                child:
                                                Flexible(
                                                        child: new Container(
                                                          padding: new EdgeInsets.only(left: 7.0, top: 5.0, right: 10.0),
                                                          child: new Text(
                                                              snapshot
                                                                  .data?[index]
                                                                  .title ==
                                                                  null
                                                                  ? "title"
                                                                  : snapshot
                                                                  .data![index]
                                                                  .title,
                                                            maxLines: 3,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: new TextStyle(
                                                              fontSize: 16.0,
                                                              fontFamily: 'Roboto',
                                                              color: new Color(0xFF212121),
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                    ]))),
                                      );
                                    });
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            })
                    ),
                    new SizedBox(height: 20.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
