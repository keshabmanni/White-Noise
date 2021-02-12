import 'package:flutter/material.dart';
import '../theme.dart';

class SideNavTile extends StatefulWidget {
  final String category;
  final bool isSelected;
  final Function onTap;

  SideNavTile(
      {@required this.category,
      this.isSelected = false,
      this.onTap});

  @override
  _SideNavTileState createState() => _SideNavTileState();
}

class _SideNavTileState extends State<SideNavTile> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Colors.transparent,
        ),
        width: sideNavWidth,
        child: Column(
          children: <Widget>[
            RotatedBox(
              child: Text(widget.category.toUpperCase(),
                    style: widget.isSelected
                        ? listTitleSelectedTextStyle
                        : listTitleDefaultTextStyle),
              quarterTurns: -1,  
            ),
            SizedBox(height: 10,),
            Icon(
              Icons.brightness_1,
              color: widget.isSelected ? selectedColor : Colors.white10,
              size: 7.0,
            ),
            SizedBox(height: 30,),
          ],
        ),
      ),

    );
  }
}
