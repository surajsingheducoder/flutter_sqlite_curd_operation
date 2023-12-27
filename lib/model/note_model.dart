import 'dart:convert';

NoteModel noteModelFromMap(String str) => NoteModel.fromMap(json.decode(str));

String noteModelToMap(NoteModel data) => json.encode(data.toMap());

class NoteModel {
  final int? noteId;
  final String noteTitle;
  final String noteContent;
  final String createAt;

  NoteModel({
    this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.createAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
    noteId: json["noteId"],
    noteTitle: json["noteTitle"],
    noteContent: json["noteContent"],
    createAt: json["createAt"],
  );

  Map<String, dynamic> toMap() => {
    "noteId": noteId,
    "noteTitle": noteTitle,
    "noteContent": noteContent,
    "createAt": createAt,
  };
}
