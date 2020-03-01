import 'package:flutter/material.dart';
import 'package:notes/model/note.dart';
import 'package:notes/utils/database_helper.dart';



class NoteScreen extends StatefulWidget{
  final Note note;
  NoteScreen(this.note);

  @override
   _NoteScreen createState() => new _NoteScreen();
}





class _NoteScreen extends State<NoteScreen>{


  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _titleController;
  TextEditingController _bodyController;
  TextEditingController _timeController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = new TextEditingController(text: widget.note.title);
    _bodyController = new TextEditingController(text: widget.note.body);
    _timeController = new TextEditingController(text: widget.note.time);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note DB') ,

      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            TextField(
              controller: _bodyController ,
              decoration: InputDecoration(labelText: 'Body'),
            ),
          /*  Padding(padding: EdgeInsets.all(5.0)),TextField(
              controller: _timeController ,
              decoration: InputDecoration(labelText: 'Time'),
            ),*/
            Padding(padding: EdgeInsets.all(5.0)),



            RaisedButton(
              child: (widget.note.id != null) ? Text(
                'update',style: TextStyle(color: Colors.white),
              ) : Text('save',style: TextStyle(color: Colors.white),) ,
              color: Colors.deepPurpleAccent,
              onPressed: () {
                if(widget.note.id != null){
                  db.updateNote(Note.fromMap({
                    'id' : widget.note.id,
                    'title' : _titleController.text,
                    'body' : _bodyController.text,
                    'time': _timeController.text,
                  })).then((_){
                    Navigator.pop(context, 'update');
                  }) ;
                } else {
                  db.saveNote(Note(
                      _titleController.text,
                      _bodyController.text,
                      _timeController.text,
                  )).then((_){
                    Navigator.pop(context, 'save');
                  });
                }


              },
            ),

          ],
        ),
      ),
    );
  }
}

