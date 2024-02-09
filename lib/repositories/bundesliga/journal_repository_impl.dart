import 'dart:convert';

import 'package:soccer_results/model/journal/journal.dart';
import 'package:soccer_results/repositories/journal_repository.dart';
import 'package:http/http.dart';

class JournalRepositoryImpl extends JournalRepository {
  final Client _client = Client();

  @override
  Future<List<Journal>> fetchBundesJournal(int num) async {
    final response = await _client
        .get(Uri.parse('https://api.openligadb.de/getmatchdata/bl1/2023/$num'));
    if (response.statusCode == 200) {
      //final data = json.decode(response.body).map((x) => Journal.fromMap(x));
      //return data;
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Journal> journals =
          jsonData.map((x) => Journal.fromMap(x)).toList();
      return journals;
    } else {
      throw Exception('Fail to load Journals');
    }
  }
}
