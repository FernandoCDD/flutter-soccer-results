import 'dart:convert';
import 'package:soccer_results/model/bundes/journal/journal.dart';
import 'package:http/http.dart';
import 'package:soccer_results/model/group_response/group_response.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository.dart';

class JournalRepositoryImpl extends JournalRepository {
  final Client _client = Client();

  @override
  Future<List<Journal>> fetchBundesJournal(int journal, int season) async {
    final response = await _client.get(Uri.parse(
        'https://api.openligadb.de/getmatchdata/bl1/$season/$journal'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Journal> journals =
          jsonData.map((x) => Journal.fromMap(x)).toList();
      return journals;
    } else {
      throw Exception('Fail to load Journals');
    }
  }

  @override
  Future<List<Journal>> fetchLaLigaJournal(int journal, int season) async {
    final response = await _client.get(Uri.parse(
        'https://api.openligadb.de/getmatchdata/laliga1/$season/$journal'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Journal> journals =
          jsonData.map((x) => Journal.fromMap(x)).toList();
      return journals;
    } else {
      throw Exception('Fail to load Journals');
    }
  }

  @override
  Future<List<GroupResponse>> fetchGroup(String liga, int season) async {
    final response = await _client.get(Uri.parse(
        'https://api.openligadb.de/getavailablegroups/$liga/$season/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<GroupResponse> groups =
          jsonData.map((x) => GroupResponse.fromMap(x)).toList();
      return groups;
    } else {
      throw Exception('Fail to load Groups');
    }
  }
}
