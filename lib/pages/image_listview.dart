import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageList extends StatefulWidget {
  ImageList(this.url);

  String url;

  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  void initState() {
    images.add(FadeInImage.assetNetwork(
      placeholder: 'images/giphy3.gif',
      image: widget.url,
    ));
  }

  List<Widget> images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.95,
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
          : PageView(
              children: images,
            ),
    );
  }
}
