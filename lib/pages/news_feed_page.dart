import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pix_health/pages/newsfeed_data.dart';

class NewsFeed extends StatefulWidget {
  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  List<NewsFeedData> news = [];

  Widget UI(String heading, String url) {
    return Card(
      elevation: 10.0,
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: Theme.of(context).textTheme.title,
            ),
            Text(url),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("News").once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
//      print('Data : ${snap.value}');
//      print('keys : ${keys}');
      news.clear();
      for (var key in keys) {
        NewsFeedData d = NewsFeedData(data[key]['Heading'], data[key]['Url']);
        news.add(d);
      }
      setState(() {
        print('Length: ${news.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'News Around',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: news.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Data loading...'),
                  ],
                ))
              : ListView.builder(
                  itemCount: news.length,
                  itemBuilder: (_, index) {
                    return UI(news[index].heading, news[index].url);
                  },
                ),
        ),
      ),
    );
  }
}
