import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_keeper/database/note_database.dart';
import 'package:note_keeper/pages/note_detail_page.dart';

import '../model/note.dart';
import '../widgets/note_card_widget.dart';
import 'add_edit_note_page.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool isLoading = false;
  late List<Note> notes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      body: Center(
        child: isLoading
        ? const CircularProgressIndicator()
        : notes.isEmpty
            ? const Text("Note Kosong", 
            style:  TextStyle(color: Colors.white),
            )
            : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            final route = MaterialPageRoute(builder: (context) => AddEditNotePage());
             await Navigator.push(context, route);
             refreshNote();
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
        ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    notes = await NoteDatabase.instance.getAllNotes();

    setState(() {
      isLoading = false;
    });
  }
  
  buildNotes() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return GestureDetector(
          onTap: () async {
            final Route = MaterialPageRoute(builder: (context) => NoteDetailPage(id: note.id));
            await Navigator.push(context, Route);
            refreshNote();
          },
          child: NoteCardWidget(note: note, index: index,));
      });
  }
}