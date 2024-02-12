part of 'journal_bloc.dart';

@immutable
sealed class JournalEvent {}

final class JournalsFetchEvent extends JournalEvent {
  final int numJournal;
  final int season;
  JournalsFetchEvent(this.numJournal, this.season);
}
