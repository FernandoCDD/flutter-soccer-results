import 'package:soccer_results/model/journal/journal.dart';

abstract class JournalRepository {
  Future<List<Journal>> fetchBundesJournal(int num);
}
