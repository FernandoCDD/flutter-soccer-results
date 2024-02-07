import 'dart:convert';

import 'package:soccer_results/model/journal/journal.dart';

class JournalList {
  List<Journal>? journals;

  JournalList({this.journals});

  factory JournalList.fromMap(Map<String, dynamic> data) => JournalList(
      journals: (data['journals'] as List<dynamic>?)
          ?.map((e) => Journal.fromMap(e as Map<String, dynamic>))
          .toList()); // Convertir Iterable a List

  Map<String, dynamic> toMap() =>
      {'journals': journals?.map((e) => e.toMap()).toList()};

  factory JournalList.fromJson(List<dynamic> json) {
    List<Journal> journals = json.map((e) => Journal.fromJson(e)).toList();
    return JournalList(journals: journals);
  }

  String toJson() => json.encode(toMap());
}
