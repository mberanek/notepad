import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notepad/presentation/note_list_page.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          elevation: 4.0,
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
      ),
      home: NoteListPage(),
    );
  }
}
