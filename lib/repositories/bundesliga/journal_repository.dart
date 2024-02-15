import 'package:soccer_results/bloc/group/group_bloc.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';
import 'package:soccer_results/model/group_response/group_response.dart';

abstract class JournalRepository {
  Future<List<GroupResponse>> fetchGroup(String liga, int season);

  Future<List<Journal>> fetchBundesJournal(int journal, int season);

  Future<List<Journal>> fetchLaLigaJournal(int journal, int season);

  add(GroupsFetchEvent groupsFetchEvent) {}
}
