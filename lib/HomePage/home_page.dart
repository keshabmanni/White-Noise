import 'package:flutter/material.dart';
import '../theme.dart';
import 'side_nav_widget.dart';
import '../ListPage/list_page.dart';
import 'categories_model.dart';
import '../ListPage/sound_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSelectedIndex = -1;
  String catId = "rain";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
      //color: backgroundColor,
      child: Row(
        children: <Widget>[
          Container( //side nav
            width: sideNavWidth,
            color: backgroundColor,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      //User Profile
                      Center(
                        child: IconButton(
                          icon: Icon(Icons.music_note_rounded , size: 30, color: Colors.white70,),
                          onPressed: (){},
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 40.0,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, counter) {
                      return Divider(
                        height: 12.0,
                      );
                    },
                    itemBuilder: (context, counter) {
                      return SideNavTile(
                        onTap: () {
                          setState(() {
                            catId = categoryItems[counter].category;
                            currentSelectedIndex = counter;
                          });
                        },
                        isSelected: currentSelectedIndex == counter,
                        category: categoryItems[counter].category,
                      );
                    },
                    itemCount: categoryItems.length,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 10,
            color: Colors.white,
          ),
          SoundListPage(catId: catId)
          //ListPage(catId: catId)
        ],
      ),
      
    );
  }
}
