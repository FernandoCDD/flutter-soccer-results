part of 'group_bloc.dart';

@immutable
sealed class GroupState {
  final List<GroupResponse> groups;

  const GroupState({this.groups = const <GroupResponse>[]});
}

final class GroupInitial extends GroupState {}

final class GroupFetched extends GroupState {
  final List<GroupResponse> groupList;
  const GroupFetched(this.groupList);
}

final class GroupFetchError extends GroupState {
  final String messageError;
  const GroupFetchError(this.messageError);
}
