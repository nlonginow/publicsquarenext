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
    super.initState();
  }

  List<int> generateNumbers() => List<int>.generate(90, (i) => i + 1);

  final gridTitleItems = [
    'TPS60',
    'TPS2',
    'TPS Express',
    'Christmas in America',
    'The Pine',
  ];

  final gridShowNames = [
    'TPS60',
    'TPS2',
    'TPSExpress',
    'CIA',
    'The Pine Podcast'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podcasts'),
      ),
      body: new ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          new Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: ScrollPhysics(),
              itemBuilder: (context, outerIndex) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      color: Colors.indigo,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Padding(
                              padding: const EdgeInsets.only(right: 5.0)),
                          new Text(gridTitleItems[outerIndex],
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    new Container(
                        height: 150.0, // this will have the future in it
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                alignment: Alignment.center,
                                                child: new Column(
                                                    children: <Widget>[
                                                      Container(
                                                          width: 75,
                                                          height: 75,
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
                                                      new Text(snapshot
                                                                  .data?[index]
                                                                  .title ==
                                                              null
                                                          ? "title"
                                                          : snapshot
                                                              .data![index]
                                                              .title),
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
