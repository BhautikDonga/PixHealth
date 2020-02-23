import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageList extends StatefulWidget {
  ImageList(this.listOfImages);

  var listOfImages;

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  void initState() {
    for (var url in widget.listOfImages) {
      images.add(Image.network(url));
      print(url);
    }
  }

  List<Widget> images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: images.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Data loading...'),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: images,
              ),
            ),
    );
  }
}
