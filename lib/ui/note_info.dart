import 'package:flutter/material.dart';
import 'package:notes/model/note.dart';
import 'package:notes/utils/database_helper.dart';


class NoteInfo extends StatefulWidget{
  final Note note;
  NoteInfo(this.note);
  @override
  _NoteInfo createState() => new _NoteInfo();

}

class _NoteInfo extends State<NoteInfo> {

  DatabaseHelper db = new DatabaseHelper();

  String title = '';
  String body = '';
  String time = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    title = widget.note.title;
    body = widget.note.body;
    time = widget.note.time;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Information') ,

      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
//         alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text('Title : $title',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 22.0,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text('body : $body',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 22.0,
              ),),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text('Time: $time',
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 22.0,
              ),),
            Padding(padding: EdgeInsets.only(top: 20.0)),




          ],
        ),
      ),
    );
  }
}