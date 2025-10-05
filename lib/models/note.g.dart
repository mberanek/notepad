// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) =>
    Note(title: json['title'] as String, text: json['text'] as String);

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
  'title': instance.title,
  'text': instance.text,
};
