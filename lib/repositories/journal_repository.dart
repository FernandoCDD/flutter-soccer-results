import 'package:soccer_results/model/journal/journal.dart';

abstract class JournalRepository {
  Future<Journal> fetchBundesJournal(int num);
}
