import 'dart:convert';

import 'package:notepad/models/note.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Provider containing all notes state
final notesProvider = NotifierProvider<NotesProvider, List<Note>>(
  NotesProvider.new,
);

class NotesProvider extends Notifier<List<Note>> {
  static const String _prefsString = "PREFS_NOTES";
  SharedPreferences? _sharedPreferences;
  @override
  List<Note> build() {
    _loadFromSharedPrefs();
    return [];
  }

  void addNote(Note note) {
    state = [...state, note];
    _saveToSharedPrefs();
  }

  void editNote(Note note, int index) {
    List<Note> notes = [...state];
    notes.removeAt(index);
    notes.insert(index, note);
    state = notes;
    _saveToSharedPrefs();
  }

  void deleteNote(int index) {
    List<Note> notes = [...state];
    notes.removeAt(index);
    state = notes;
    _saveToSharedPrefs();
  }

  void _saveToSharedPrefs() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    await _sharedPreferences!.setStringList(
      _prefsString,
      state.map((note) => jsonEncode(note.toJson())).toList(),
    );
  }

  void _loadFromSharedPrefs() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    List<String>? noteStrings = _sharedPreferences!.getStringList(_prefsString);
    if (noteStrings == null) {
      state = [];
      return;
    }

    List<Note> notes = noteStrings
        .map((str) => Note.fromJson(jsonDecode(str)))
        .toList();
    state = notes;
  }
}
