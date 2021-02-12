import 'package:flutter/material.dart';
import '../theme.dart';
import '../Player/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SoundListPage extends StatefulWidget {
  final String catId;

  SoundListPage({
    @required this.catId,
  });

  @override
  _SoundListPageState createState() => _SoundListPageState();
}

class _SoundListPageState extends State<SoundListPage> {
  String currentSoundPlaying;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      //color: backgroundColor,
      //width: ,
      //height: MediaQuery.of(context).size.height-30,
      child: Container(
        padding: EdgeInsets.all(30),
        color: backgroundColor,
        child: Expanded(
                  child: Column(
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
                            child: Text(
                              widget.catId.toString().toUpperCase(),
                              style: TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          )
                        ]),
                  )),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('sounds')
                    .doc(widget.catId.toLowerCase())
                    .collection('sound')
                    .snapshots(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot sounds = snapshot.data.documents[index];
                        return ListTile(
                          onTap: () {
                            setState(() {
                              currentSoundPlaying = sounds.get('soundUrl');
                            });
                          },
                          title: Text(sounds.get('title'), style: (currentSoundPlaying == sounds.get('soundUrl')) ? soundSelectedColor
                                    : soundDefaultColor,)
                        );
                      },
                    ),
                  );
                },
              ),
              PlayerPage(soundUrl: currentSoundPlaying, )
            ],
          ),
        ),
      ),
    );
  }
}
