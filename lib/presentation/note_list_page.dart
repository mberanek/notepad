import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/presentation/note_edit_page.dart';
import 'package:notepad/providers/notes_provider.dart';

//Home page with list of notes
class NoteListPage extends ConsumerStatefulWidget {
  const NoteListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteListPageState();
}

class _NoteListPageState extends ConsumerState<NoteListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(
            context,
          ).colorScheme.onPrimary, // change back button color here
        ),
        title: Text(
          "Poznámky",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: _noteList(),
      floatingActionButton: _addNoteButton(),
    );
  }

  Widget _noteList() {
    List<Note> notes = ref.watch(notesProvider);
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: notes.length,
      itemBuilder: (context, index) => _noteWidget(index, notes[index]),
    );
  }

  //Single note box
  Widget _noteWidget(int index, Note note) {
    return Container(
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: BoxBorder.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => _editNote(index),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  note.getTitleText(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                onPressed: () =>
                    ref.read(notesProvider.notifier).deleteNote(index),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addNoteButton() {
    return IconButton.filled(
      onPressed: _createNewNote,
      icon: Icon(Icons.add),
      color: Theme.of(context).colorScheme.onPrimary,
      padding: EdgeInsets.all(16),
    );
  }

  void _editNote(int index) async {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NoteEditPage(noteIndex: index)),
    );
  } 

  void _createNewNote() {
    ref.read(notesProvider.notifier).addNote(Note(title: "", text: ""));
    _editNote(ref.watch(notesProvider).length - 1);
  }
}
