import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:soccer_results/model/group_response/group_response.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final JournalRepository journalRepository;

  GroupBloc(this.journalRepository) : super(GroupInitial()) {
    on<GroupsFetchEvent>(_onGroupFetchList);
  }

  void _onGroupFetchList(
      GroupsFetchEvent event, Emitter<GroupState> emit) async {
    try {
      final groupList =
          await journalRepository.fetchGroup(event.liga, event.season);
      emit(GroupFetched(groupList));
      return;
    } on Exception catch (e) {
      emit(GroupFetchError(e.toString()));
    }
  }
}
