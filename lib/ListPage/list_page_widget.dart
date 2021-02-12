import 'package:flutter/material.dart';
import '../theme.dart';

class ListPageTile extends StatefulWidget {
  final String soundTitle;
  final String soundImage;
  final String dateCreated;
  final String duration;
  final bool isSelected;
  final Function onTap;

  ListPageTile(
      {@required this.soundTitle,
      @required this.dateCreated,
      @required this.duration,
      @required this.soundImage,
      this.isSelected = false,
      this.onTap});

  @override
  _ListPageTileState createState() => _ListPageTileState();
}

class _ListPageTileState extends State<ListPageTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Text(widget.soundImage),
                
              ]), //Image URL
            Column(
              children: <Widget>[
                Text("hi"),
                Text(
                  widget.soundTitle,
                  style: TextStyle(
                    fontSize: 20.0,
                  )
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(widget.duration, style: TextStyle(fontSize: 15),),
                    Text(widget.dateCreated, style: TextStyle(fontSize: 15),)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
