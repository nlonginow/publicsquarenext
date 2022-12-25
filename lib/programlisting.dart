import 'dart:convert';
import 'dart:io';
import 'package:eof_podcast_feed/eof_podcast_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'playermain.dart';
import 'package:intl/intl.dart';

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
    case "Monthly Update":
      List<MonthlyUpdateItem> monthlyUpdateItems = await fetchMonthlyUpdateItems();
      for (int i = 0; i < monthlyUpdateItems.length; i++) {
        String theDescription = 'Your Monthly Update is a regular service from the American Policy Roundtable.';
        String sUrl = monthlyUpdateItems[i].pdfUrl;
        String postedDate = monthlyUpdateItems[i].postedDate;
        String title = 'Your Monthly Update for ' + postedDate;
        PodcastItem anItem = PodcastItem(
            title: title,
            description: theDescription,
            pubDate: postedDate,
            url: sUrl,
            cover: monthlyUpdateItems[i].jpgUrl);
        thePrograms.add(anItem);
      }
      break;
    case "CIA":
      List<ChristmasItem> ciaItems = await fetchChristmasItems();
      for (int i = 0; i < ciaItems.length; i++) {
        String theDescription = ciaItems[i].program_description;
        String sUrl = 'https://www.aproundtable.org/app/' + ciaItems[i].program_url;
        String title = ciaItems[i].title;
          PodcastItem anItem = PodcastItem(
              title: title,
              description: theDescription,
              pubDate: ciaItems[i].program_date,
              url: sUrl,
              cover: 'https://configuremyapp.com/wp-content/uploads/2022/12/fireplace.png');
          thePrograms.add(anItem);
      }
      break;
    case "ThePine":
      var podcast = await EOFPodcast.fromFeed('https://thepine.libsyn.com/rss');
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
    default:
  }
  return thePrograms;
}

class MonthlyUpdateItem {
  final String title;
  final String pdfUrl;
  final String jpgUrl;
  final String postedDate;

  const MonthlyUpdateItem({
    required this.title,
    required this.pdfUrl,
    required this.jpgUrl,
    required this.postedDate,
  });

  factory MonthlyUpdateItem.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(json['cct_modified']);
    String formattedDate = DateFormat('MMM dd, yyyy (hh:mm)').format(dateTime);

    return MonthlyUpdateItem(
      title: 'Your Monthly Update',
      pdfUrl: json['pdffile']['url'],
      jpgUrl: json['tilegraphic']['url'],
      postedDate: formattedDate,
    );
  }
}

class ChristmasItem {
  final String title;
  final String program_url;
  final String program_date;
  final String program_description;

  const ChristmasItem({
    required this.title,
    required this.program_url,
    required this.program_date,
    required this.program_description,
  });

  factory ChristmasItem.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(json['cct_modified']);
    String formattedDate = DateFormat('MMM dd, yyyy (hh:mm)').format(dateTime);

    return ChristmasItem(
      title: json['title'],
      program_url: json['program_url'],
      program_date: formattedDate,
      program_description: json['program_description'],
    );
  }

}

Future<List<MonthlyUpdateItem>> fetchMonthlyUpdateItems() async {
  String API_USERNAME = "Admin";
  String API_PASSWORD = "pUQJ cKPv ku0q itbP 2Q5y Xasx";
  final bytes = utf8.encode(API_USERNAME + ":" + API_PASSWORD);
  final base64Str = base64.encode(bytes);
  String AUTH = "Basic " + base64Str;

  final response = await http.get(
    Uri.parse('https://configuremyapp.com/wp-json/jet-cct/tpsmonthlyupdate'),
    headers: {
      HttpHeaders.authorizationHeader: AUTH,
    },);
  if (response.statusCode == 200) {
    List<dynamic> list = json.decode(response.body);
    var item;
    var myList = <MonthlyUpdateItem>[];
    for (item in list) {
      MonthlyUpdateItem aMonthlyUpdateItem = MonthlyUpdateItem.fromJson(item);
      myList.add(aMonthlyUpdateItem);
    }
    return myList;
  } else {
    throw Exception("Failed to fetch Monthly Update items");
  }
}

Future<List<ChristmasItem>> fetchChristmasItems() async {
  String API_USERNAME = "Admin";
  String API_PASSWORD = "pUQJ cKPv ku0q itbP 2Q5y Xasx";
  final bytes = utf8.encode(API_USERNAME + ":" + API_PASSWORD);
  final base64Str = base64.encode(bytes);
  String AUTH = "Basic " + base64Str;

  final response = await http.get(
    Uri.parse('https://configuremyapp.com/wp-json/jet-cct/podcast'),
    headers: {
      HttpHeaders.authorizationHeader: AUTH,
    },);
  if (response.statusCode == 200) {
    List<dynamic> list = json.decode(response.body);
    var item;
    var myList = <ChristmasItem>[];
    for (item in list) {
      ChristmasItem aChristmasItem = ChristmasItem.fromJson(item);
      myList.add(aChristmasItem);
    }
    return myList;
  } else {
    throw Exception("Failed to fetch CIA items");
  }
}



