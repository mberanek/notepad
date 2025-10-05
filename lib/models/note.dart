import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';


//Note model
@freezed
@JsonSerializable()
class Note with _$Note {
  @override
  String title;
  @override
  String text;

  Note({required this.title, required this.text});

  factory Note.fromJson(Map<String, Object?> json) => _$NoteFromJson(json);

  Map<String, Object?> toJson() => _$NoteToJson(this);

  String getTitleText() {
    if (title.isNotEmpty) {
      return title;
    }
    if (text.isNotEmpty) {
      return text;
    }
    return "Bez názvu";
  }
}
