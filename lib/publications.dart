import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publicsquarenext/playermain.dart';

import 'app_bottom_navigation.dart';
import 'displaypage.dart';
import 'displaypdfpage.dart';
import 'programlisting.dart';

class PubsPage extends StatefulWidget {
  const PubsPage();

  @override
  _PubsPageState createState() => _PubsPageState();
}

class _PubsPageState extends State<PubsPage> {
  final gridTitleItems = [
    'Your Monthly Update',
    'Common Good Blog',
  ];

  final gridShowNames = [
    'Update',
    'Common Good Blog'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publications'),
      ),
      body: new ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          new Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
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
                                              {
                                                if (outerIndex == 1) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DisplayRemotePDF(
                                                          theUrl:
                                                          snapshot.data?[index].url == null
                                                              ? "url"
                                                              : snapshot.data![index].url,
                                                          theTitle:
                                                          snapshot.data?[index].title == null
                                                              ? "title"
                                                              : snapshot.data![index].title,
                                                          title:
                                                          snapshot.data?[index].title == null
                                                              ? "title"
                                                              : snapshot.data![index].title,

                                                        )),
                                                  );
                                                }
                                                else if (outerIndex == 2) {
                                                  if (snapshot.data?[index].url != null) {
                                                    print('url is ' + snapshot.data![index].url);
                                                  }
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DisplayRemotePage(
                                                          theUrl:
                                                          snapshot.data?[index].url == null
                                                              ? "url"
                                                              : snapshot.data![index].url,
                                                          theTitle:
                                                          snapshot.data?[index].title == null
                                                              ? "title"
                                                              : snapshot.data![index].title,

                                                        )),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PlayerMain(
                                                          theTitle:
                                                          snapshot.data?[index].title == null
                                                              ? "title"
                                                              : snapshot.data![index].title,
                                                          theUrl:
                                                          snapshot.data?[index].url == null
                                                              ? "url"
                                                              : snapshot.data![index].url,
                                                          theCover:
                                                          snapshot.data?[index].cover == null
                                                              ? "cover"
                                                              : snapshot.data![index].cover,
                                                          theDescription: snapshot
                                                              .data?[index].description ==
                                                              null
                                                              ? "description"
                                                              : snapshot.data![index].description,
                                                        )),
                                                  );
                                                }
                                              }
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
                                                                  alignment: Alignment.center,
                                                                  widthFactor: 0.8,
                                                                  heightFactor: 1.0,
                                                                  child: Container(
                                                                    //height: 120,
                                                                    //width: 120,
                                                                      decoration:
                                                                      BoxDecoration(color: Colors.white,
                                                                          borderRadius: BorderRadius.circular(10.0),
                                                                          image: DecorationImage(fit: BoxFit.cover,
                                                                              image:
                                                                                  snapshot.data![index].cover.length > 25 ?
                                                                              NetworkImage(snapshot.data![index].cover) :
                                                                                  AssetImage(snapshot.data![index].cover) as ImageProvider
                                                                              ) ) )

                                                                  )),
                                                            ),
                                                          ),
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
