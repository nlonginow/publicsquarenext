import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'page_manager.dart';

class PlayerMain extends StatefulWidget {
  final String theTitle;
  final String theUrl;
  final String theCover;
  final String theDescription;

  const PlayerMain(
      {required this.theTitle,
      required this.theUrl,
      required this.theCover,
      required this.theDescription});

  @override
  _PlayerMainState createState() => _PlayerMainState();
}

class _PlayerMainState extends State<PlayerMain> {
  late final PageManager _pageManager;

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("incoming values: " + widget.theTitle + " " + widget.theUrl);
    _pageManager = PageManager(theUrl: widget.theUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing'),
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
              height: 30,
            ),
        Container(
          height: 300,
          width: 350,
          child:
            new Expanded(
              flex: 1,
              child: new SingleChildScrollView(
                  child: Html(
                data: widget.theDescription,
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
