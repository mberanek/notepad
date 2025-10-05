import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/providers/notes_provider.dart';

//Note modification page
class NoteEditPage extends ConsumerStatefulWidget {
  final int noteIndex;
  const NoteEditPage({super.key, required this.noteIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends ConsumerState<NoteEditPage> {
  String _title = "";
  String _text = "";

  @override
  void initState() {
    super.initState();
    Note note = ref.read(notesProvider)[widget.noteIndex];
    _title = note.title;
    _text = note.text;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        ref
            .read(notesProvider.notifier)
            .editNote(Note(title: _title, text: _text), widget.noteIndex);
      },
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                onChanged: (value) => _title = value,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Název',
                ),
              ),
              TextFormField(
                initialValue: _text,
                onChanged: (value) => _text = value,
                maxLines: null,
                decoration: const InputDecoration(labelText: "Text"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmButton() {
    return IconButton(
      onPressed: Navigator.of(context).pop,
      icon: Icon(Icons.check),
    );
  }

  AppBar _appBar() {
    return AppBar(
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
      actions: [_confirmButton()],
    );
  }
}
