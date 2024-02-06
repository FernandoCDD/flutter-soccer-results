import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soccer_results/model/journal/journal.dart';
import 'package:soccer_results/repositories/journal_repository.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalRepository journalRepository;

  JournalBloc(this.journalRepository) : super(JournalInitial()) {
    on<JournalsFetchEvent>(_onJournalFetch);
  }

  void _onJournalFetch(
      JournalsFetchEvent event, Emitter<JournalState> emit) async {
    try {
      final matchList = await journalRepository.fetchBundesJournal(num as int);
      emit(JournalFetched(matchList));
      return;
    } on Exception catch (e) {
      emit(JournalFetchError(e.toString()));
    }
  }
}
