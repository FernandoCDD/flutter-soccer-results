part of 'group_bloc.dart';

@immutable
sealed class GroupEvent {}

final class GroupsFetchEvent extends GroupEvent {
  final String liga;
  final int season;
  GroupsFetchEvent(this.liga, this.season);
}
