part of 'journal_bloc.dart';

@immutable
sealed class JournalState {
  final List<Journal> journals;

  const JournalState({
    this.journals = const <Journal>[],
  });
}

final class JournalInitial extends JournalState {}

final class JournalFetched extends JournalState {
  final Journal matchList;
  const JournalFetched(this.matchList);
}

final class JournalFetchError extends JournalState {
  final String messageError;
  const JournalFetchError(this.messageError);
}
