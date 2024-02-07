import 'dart:convert';

import 'package:soccer_results/model/journal/journal.dart';
import 'package:soccer_results/model/journal/journal_list.dart';
import 'package:soccer_results/repositories/journal_repository.dart';
import 'package:http/http.dart';

class JournalRepositoryImpl extends JournalRepository {
  final Client _client = Client();

  @override
  Future<List<Journal>> fetchBundesJournal(int num) async {
    final response = await _client
        .get(Uri.parse('https://api.openligadb.de/getmatchdata/bl1/2023/$num'));
    if (response.statusCode == 200) {
      return JournalList.fromJson(json.decode(response.body)).journals!;
    } else {
      throw Exception('Fail to load Journals');
    }
  }
}
