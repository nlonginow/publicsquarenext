import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOfGridsPage extends StatefulWidget {
  const ListOfGridsPage();

  @override
  _ListOfGridsPageState createState() => _ListOfGridsPageState();
}

class _ListOfGridsPageState extends State<ListOfGridsPage> {


  @override
  void initState() {
    super.initState();
  }
  List<int> generateNumbers() => List<int>.generate(90, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of Grids'),
        ),
      body: new ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          new SizedBox(height: 20.0),
          new Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      color: Colors.green,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(Icons.format_list_numbered,
                              color: Colors.white),
                          new Padding(
                              padding: const EdgeInsets.only(right: 5.0)),
                          new Text('List Item $index',
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    new Container(
                      height: 150.0,
                      child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return new Card(
                            elevation: 5.0,
                            child: new Container(
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.center,
                              child: new Text('Item $index'),
                            ),
                          );
                        },
                      ),
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