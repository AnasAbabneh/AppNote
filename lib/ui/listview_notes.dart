import 'package:flutter/material.dart';
import 'package:notes/model/note.dart';
import 'package:notes/ui/note_info.dart';
import 'package:notes/ui/notes_screen.dart';
import 'package:notes/utils/database_helper.dart';
import 'package:intl/intl.dart';


class ListNotes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListNotes();
  }
}


  class _ListNotes extends State<ListNotes>  {

  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAllNotes().then((notes){
     setState(() {
       notes.forEach((note){
         items.add(Note.fromMap(note));
       });
     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All Notes',
      home: Scaffold(
        appBar: AppBar(
          title: Text('All Notes ::'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding:const EdgeInsets.all(15.0),
              itemBuilder: (context , position){
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0,),
                    Row(
                      children: <Widget>[

                        new Expanded(
                            child: ListTile(
                              title: Text('${items[position].title}',
                                style: TextStyle(fontSize: 22.0,color: Colors.redAccent
                                ),
                              ),
                              subtitle: Text('${items[position].body} - ${items[position].time} ',
                                style: TextStyle(fontSize: 14.0,fontStyle: FontStyle.italic,
                                ),
                              ),
                              leading: Column(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(1.0)),
                                  CircleAvatar(
                                    backgroundColor: Colors.amber,
                                    radius: 18.0,
                                    child: Text('${items[position].id}',
                                      style: TextStyle(fontSize: 22.0,color: Colors.white
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              onTap: () => _navigateToNoteInfo(context,items[position]),
                            )
                        ),

                        IconButton(icon: Icon(Icons.edit,color: Colors.blueAccent,),
                          onPressed: () => _navigateToNote(context , items[position]),
                        ),

                        IconButton(icon: Icon(Icons.delete,color: Colors.red,),
                            onPressed: () => _deleteNote(context,items[position],position)
                        )
                      ],
                    ),



                  ],

                );
              }
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.deepOrange,
            onPressed: () => _createNewNote(context)),
      ),
    );
  }




  _deleteNote(BuildContext context,Note note,int position) async{
    db.deleteNote(note.id).then((notes){
      setState(() {
        items.removeAt(position);
      });
    });
  }


  void  _navigateToNote(BuildContext context ,Note note)async{
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => NoteScreen(note)),
    );

    if(result == 'update'){
      db.getAllNotes().then((notes){
        setState(() {
          items.clear();
          notes.forEach((note){
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }




  void  _navigateToNoteInfo(BuildContext context ,Note note)async{
    await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => NoteInfo(note)),
    );


  }



  void _createNewNote(BuildContext context) async{

 String T=new DateFormat.jm().format(new DateTime.now());

    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => NoteScreen(
          Note('', '', '$T'))),
    );

    if(result == 'save'){
      db.getAllNotes().then((notes){
        setState(() {
          items.clear();
          notes.forEach((note){
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }

  }