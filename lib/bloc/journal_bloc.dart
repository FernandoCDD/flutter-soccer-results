import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';

import 'package:soccer_results/repositories/bundesliga/journal_repository.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class BundesJournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalRepository journalRepository;

  BundesJournalBloc(this.journalRepository) : super(JournalInitial()) {
    on<JournalsFetchEvent>(_onBundesJournalFetchList);
  }

  void _onBundesJournalFetchList(
      JournalsFetchEvent event, Emitter<JournalState> emit) async {
    try {
      final matchList = await journalRepository.fetchBundesJournal(
          event.numJournal, event.season);
      emit(JournalFetched(matchList));
      return;
    } on Exception catch (e) {
      emit(JournalFetchError(e.toString()));
    }
  }
}

class LaLigaJournalBloc extends Bloc<JournalEvent, JournalState> {
  final JournalRepository journalRepository;

  LaLigaJournalBloc(this.journalRepository) : super(JournalInitial()) {
    on<JournalsFetchEvent>(_onLaLigaJournalFetchList);
  }

  void _onLaLigaJournalFetchList(
      JournalsFetchEvent event, Emitter<JournalState> emit) async {
    try {
      final matchList = await journalRepository.fetchLaLigaJournal(
          event.numJournal, event.season);
      emit(JournalFetched(matchList));
      return;
    } on Exception catch (e) {
      emit(JournalFetchError(e.toString()));
    }
  }
}
