import 'package:flutter/material.dart';
import 'package:newdb/model/note.dart';
import 'package:newdb/util/database_heiper.dart';

import 'note_screen.dart';

class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}
class _ListViewNoteState extends State<ListViewNote> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    super.initState();

    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSA ListView Demo',
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Basic Example'),
          centerTitle: true,
          backgroundColor: Colors.blue,

        ),
        body: Center(
          child: ListView.builder(

              itemCount: items.length,
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 2.0),
                    ListTile(
                      title: Text(
                        '${items[position].name}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].age}',
                        style: new TextStyle(
                          fontSize: 11.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      leading: Column(

                        mainAxisSize: MainAxisSize.max,

                             children: <Widget>[
                               Expanded(
                                 child:
                               CircleAvatar(
                                 backgroundColor: Colors.blueAccent,
                                radius:10,
                                 child: Text(
                                   '${items[position].id}',
                                   style: TextStyle(
                                     fontSize: 8.0,
                                     color: Colors.white,
                                   ),
                                 ),
                               ),
                               ),
                               IconButton(
                                   icon: const Icon(Icons.remove_circle_outline,size: 20,),
                                   onPressed: () =>
                                       _deleteNote(
                                           context, items[position], position)),
                             ],
                                  ),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),
                  ],
                );
              }
              ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
      ),
    );
  }
  void _deleteNote(BuildContext context, Note note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
  void _navigateToNote(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', ''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
}