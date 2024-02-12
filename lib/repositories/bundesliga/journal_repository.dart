import 'package:soccer_results/model/bundes/journal/journal.dart';

abstract class JournalRepository {
  Future<List<Journal>> fetchBundesJournal(int journal, int season);
}
