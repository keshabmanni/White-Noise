import 'package:flutter/material.dart';
import '../theme.dart';
import 'list_page_widget.dart';
import 'sound_list_model.dart';
import '../services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  final int catId;
  ListPage({
    @required this.catId,
  });

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int currentSoundIndex = -1;
  bool isSelected = false;

  CollectionReference sounds = FirebaseFirestore.instance.collection('sounds');
  //AnimationController _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  /*@override
  void initState() {
    fsMethodsObj.getData().then((results) {
      setState(() {
        sounds = results;
      });
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      padding: EdgeInsets.all(20),
      width: (MediaQuery.of(context).size.width) - sideNavWidth,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "White Noise",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              )),
          Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              elevation: 5,
              shadowColor: Colors.white,
              child: Container(
                height: 150,
                width: 200,
                child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(widget.catId.toString(),
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      )
                    ]),
              )),
          Container(width: 120, height: 150, child: _listItems()),
          Expanded(
            child: ListView.separated(
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
              itemCount: soundListItems.length,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, counter) {
                return Divider(
                  height: 10,
                );
              },

              //
              itemBuilder: (context, counter) {
                return InkWell(
                    onTap: () {
                      setState(() {
                        currentSoundIndex = counter;
                      });
                    },
                    enableFeedback: true,
                    child: Container(
                        height: 60,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              soundListItems[counter].soundTitle,
                              style: (currentSoundIndex == counter)
                                  ? soundSelectedColor
                                  : soundDefaultColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  soundListItems[counter].duration,
                                  style: (currentSoundIndex == counter)
                                      ? dndSelectedColor
                                      : dndDefaultColor,
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  soundListItems[counter].dateCreated,
                                  style: (currentSoundIndex == counter)
                                      ? dndSelectedColor
                                      : dndDefaultColor,
                                )
                              ],
                            ),
                          ],
                        )));
              },
            ),
          ),
          //player
          Text(currentSoundIndex.toString() + " Tapped"),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Icon(Icons.play_arrow, color: Colors.white70,),
                Slider(value: 5, onChanged: null)
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget _listItems() {
    return StreamBuilder<QuerySnapshot>(
      stream: sounds.snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something Wrong");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        } else {
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return ListTile(
                title: Text(document.data()['docId']),
                subtitle: Text(document.data()['title']),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
