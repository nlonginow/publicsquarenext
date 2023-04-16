import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'programstab/page_manager.dart';

class AudioBook extends StatefulWidget {

  AudioBook();
  String theUrl = "";
  String theTitle = "Gilbert and Jack";
  String theCover = "https://configuremyapp.com/wp-content/uploads/2023/01/gilbertandjack.jpg";

  @override
  _AudioBookState createState() => _AudioBookState();
}

class _AudioBookState extends State<AudioBook> {
  late final PageManager _pageManager;

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    widget.theUrl = "https://s3.amazonaws.com/greatnorthsoftware.com/gilbertandjackforapp.mp3";
    super.initState();
    _pageManager = PageManager(theUrl: widget.theUrl);
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);
    analytics.setCurrentScreen(screenName: 'AudioBookPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gilbert and Jack AudioBook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            playerImageNow(),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.theTitle,
              style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
        Container(
          height: 200,
          width: 350,
          child:
            new Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                  child: Html(
                data: "Gilbert and Jack, an Audio Book from The Public Square",
                padding: EdgeInsets.all(8.0),
              )),
            )),
            const Spacer(),
            ValueListenableBuilder<ProgressBarState>(
              valueListenable: _pageManager.progressNotifier,
              builder: (_, value, __) {
                return ProgressBar(
                  progress: value.current,
                  buffered: value.buffered,
                  total: value.total,
                  onSeek: _pageManager.seek,
                );
              },
            ),
            ValueListenableBuilder<ButtonState>(
              valueListenable: _pageManager.buttonNotifier,
              builder: (_, value, __) {
                switch (value) {
                  case ButtonState.loading:
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 32.0,
                      height: 32.0,
                      child: const CircularProgressIndicator(),
                    );
                  case ButtonState.paused:
                    return IconButton(
                      icon: const Icon(Icons.play_arrow),
                      iconSize: 32.0,
                      onPressed: _pageManager.play,
                    );
                  case ButtonState.playing:
                    return IconButton(
                      icon: const Icon(Icons.pause),
                      iconSize: 32.0,
                      onPressed: _pageManager.pause,
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget playerImageNow() {
    return Container(
      width: 220,
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(widget.theCover),
      ),
    );
  }
}
