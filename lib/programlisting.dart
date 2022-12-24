import 'package:eof_podcast_feed/eof_podcast_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'playermain.dart';

class ProgramListing extends StatefulWidget {
  final String podcastname;

  const ProgramListing({required this.podcastname});

  @override
  _ProgramListingState createState() => _ProgramListingState();
}

class _ProgramListingState extends State<ProgramListing> {
  String _title = "Podcast Title Original";
  String _imageName = 'assets/images/long.jpg';

  @override
  void initState() {
    if (widget.podcastname == null) {
      _title = "Podcast Title";
    } else {
      _title = widget.podcastname;
    }
    if (widget.podcastname == 'TPS60') {
      _imageName = 'assets/images/long.jpg';
    } else if (widget.podcastname == 'TPS2') {
      _imageName = 'assets/images/short.jpg';
    } else if (widget.podcastname == 'TPSExpress') {
      _imageName = 'assets/images/express.png';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(_title + " Programs"),
          backgroundColor: Colors.black,
        ),
        body: FutureBuilder<List<PodcastItem>>(
            future: getShowsForProgram(widget.podcastname),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                    title: Text("Error"),
                    content: Text('An error has occurred...'),
                  ),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: CustomListItem(
                          thumbnail: Container(
                              width: 50,
                              height: 95,
                              child: ClipRect(
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    widthFactor: 0.8,
                                    heightFactor: 1.0,
                                    child: Image.asset(_imageName,
                                        //just change my image with your image
                                        height: 60),
                                  ),
                                ),
                              )),
                          title: snapshot.data?[index].title == null
                              ? "title"
                              : snapshot.data![index].title,
                          description: snapshot.data?[index].description == null
                              ? "comment"
                              : snapshot.data![index].description,
                          publishDate: snapshot.data?[index].pubDate == null
                              ? "date"
                              : snapshot.data![index].pubDate.toString(),
                          url: snapshot.data?[index].url == null
                              ? "URL"
                              : snapshot.data![index].url,
                          cover: snapshot.data?[index].cover == null
                              ? "COVER"
                              : snapshot.data![index].cover,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerMain(
                                      theTitle:
                                          snapshot.data?[index].title == null
                                              ? "title"
                                              : snapshot.data![index].title,
                                      theUrl: snapshot.data?[index].url == null
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
                        },
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
            }));
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    Key? key,
    required this.title,
    required this.author,
    required this.publishDate,
  }) : super(key: key);

  final String title;
  final String author;
  final String publishDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DefaultTextStyle(
                  style: TextStyle(),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.indigo,
                    ),
                  )),
              const Padding(padding: EdgeInsets.only(top: 2.0, bottom: 2.0)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DefaultTextStyle(
                  style: TextStyle(),
                  child: Text(
                    "The American Policy Roundtable",
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              DefaultTextStyle(
                  style: TextStyle(),
                  child: Text(
                    publishDate,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              Divider(
                height: 15.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.title,
    required this.description,
    required this.publishDate,
    required this.url,
    required this.cover,
    required this.thumbnail,
  }) : super(key: key);

  final String title;
  final String description;
  final String publishDate;
  final String url;
  final String cover;
  final Widget thumbnail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 50.0,
                height: 50.0,
                color: Colors.grey,
                alignment: Alignment.topCenter,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: thumbnail,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 0.0),
                child: _ArticleDescription(
                    title: title,
                    author: "American Policy Roundtable",
                    publishDate: publishDate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PodcastItem {
  final String title;
  final String description;
  final String pubDate;
  final String url;
  final String cover;

  const PodcastItem({
    required this.title,
    required this.description,
    required this.pubDate,
    required this.url,
    required this.cover,
  });
}

Future<List<PodcastItem>> getShowsForProgram(String theName) async {
  print('getting shows for ' + theName);
  List<PodcastItem> thePrograms = <PodcastItem>[];
  switch (theName) {
    case "TPS60":
      var podcast =
          await EOFPodcast.fromFeed('https://thepublicsquare.libsyn.com/rss');
      var episodes = podcast.episodes;
      for (int i = 0; i < episodes.length; i++) {
        String theDescription = episodes[i].description;
        int idx = theDescription.lastIndexOf("Topic:");
        if (idx >= 0) {
          theDescription = theDescription.substring(0, idx);
        }
        String sUrl = episodes[i].url;
        int idxMp3 = sUrl.lastIndexOf(".mp3");
        String strippedUrl = sUrl.substring(0, idxMp3 + 4);
        String title = episodes[i].title;
        idx = title.indexOf('TPS Express');
        // Exclude all TPS Express titles...
        if (idx < 0) {
          PodcastItem anItem = PodcastItem(
              title: episodes[i].title,
              description: theDescription,
              pubDate: episodes[i].pubDate,
              url: strippedUrl,
              cover: episodes[i].cover);
          thePrograms.add(anItem);
        }
      }
      break;
    case "TPS2":
      var podcast = await EOFPodcast.fromFeed(
          'http://thepublicsquare2minute.libsyn.com/rss');
      var episodes = podcast.episodes;
      for (int i = 0; i < episodes.length; i++) {
        String theDescription = episodes[i].description;
        int idx = theDescription.lastIndexOf("Topic:");
        if (idx >= 0) {
          theDescription = theDescription.substring(0, idx);
        }
        String sUrl = episodes[i].url;
        int idxMp3 = sUrl.lastIndexOf(".mp3");
        String strippedUrl = sUrl.substring(0, idxMp3 + 4);
        PodcastItem anItem = PodcastItem(
            title: episodes[i].title,
            description: theDescription,
            pubDate: episodes[i].pubDate,
            url: strippedUrl,
            cover: episodes[i].cover);
        thePrograms.add(anItem);
      }
      break;
    case "TPSExpress":
      var podcast =
      await EOFPodcast.fromFeed('https://thepublicsquare.libsyn.com/rss');
      var episodes = podcast.episodes;
      for (int i = 0; i < episodes.length; i++) {
        String theDescription = episodes[i].description;
        int idx = theDescription.lastIndexOf("Topic:");
        if (idx >= 0) {
          theDescription = theDescription.substring(0, idx);
        }
        String sUrl = episodes[i].url;
        int idxMp3 = sUrl.lastIndexOf(".mp3");
        String strippedUrl = sUrl.substring(0, idxMp3 + 4);
        String title = episodes[i].title;
        idx = title.indexOf('TPS Express');
        // include only TPS Express titles...
        if (idx >= 0) {
          PodcastItem anItem = PodcastItem(
              title: episodes[i].title,
              description: theDescription,
              pubDate: episodes[i].pubDate,
              url: strippedUrl,
              cover: episodes[i].cover);
          thePrograms.add(anItem);
        }
      }
      break;
    default:
  }
  return thePrograms;
}
