import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_results/bloc/group/group_bloc.dart';
import 'package:soccer_results/bloc/journal/journal_bloc.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository_impl.dart';
import 'package:soccer_results/screen/home_screen.dart';
import 'package:soccer_results/widget/result_card.dart';

class BundesligaResultsPage extends StatefulWidget {
  const BundesligaResultsPage({super.key});

  @override
  State<BundesligaResultsPage> createState() => _BundesligaResultsPageState();
}

class _BundesligaResultsPageState extends State<BundesligaResultsPage> {
  late BundesJournalBloc _journalBloc;
  late JournalRepository journalRepository;
  int seasonValue = season.first;
  int journalValue = journal.first;
  bool isPressed = false;
  late GroupBloc _groupBloc;

  @override
  void initState() {
    super.initState();
    journalRepository = JournalRepositoryImpl();
    _journalBloc = BundesJournalBloc(journalRepository)
      ..add(JournalsFetchEvent(journalValue, seasonValue));
    _groupBloc =
        GroupBloc(journalRepository..add(GroupsFetchEvent("bl1", seasonValue)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _journalBloc,
      child: _matchView(context),
    );
  }

  Widget _matchView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPressed = !isPressed;
                        if (isPressed) {
                          _showBottomSheet(context);
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Jornada: $journalValue',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          isPressed
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                        ),
                      ],
                    ),
                  ),
                  DropdownButton<int>(
                    value: seasonValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? value) {
                      setState(() {
                        seasonValue = value!;
                      });
                      _journalBloc
                          .add(JournalsFetchEvent(journalValue, seasonValue));
                    },
                    items: season.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'BUNDESLIGA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<BundesJournalBloc, JournalState>(
            builder: (context, state) {
              if (state is JournalInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is JournalFetchError) {
                return Column(
                  children: [
                    Text(state.messageError),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .watch<BundesJournalBloc>()
                            .add(JournalsFetchEvent(journalValue, seasonValue));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              } else if (state is JournalFetched) {
                return _matchListView(context, state.matchList);
              } else {
                return const Text('Not support');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _matchListView(BuildContext context, List<Journal> journalList) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ResultCard(journal: journalList[index]);
      },
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      itemCount: journalList.length,
    );
  }

  void _showBottomSheet(BuildContext context) {
    _groupBloc.add(GroupsFetchEvent('bl1', seasonValue));
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: _groupBloc,
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is GroupFetched) {
                return ListView.builder(
                  itemCount: state.groupList.length,
                  itemBuilder: (context, index) {
                    int groupId = state.groupList[index].groupOrderId!;
                    return ListTile(
                      title: Text(
                        'Jornada $groupId',
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        setState(() {
                          journalValue = groupId;
                          isPressed = false;
                        });
                        _journalBloc.add(
                          JournalsFetchEvent(groupId, seasonValue),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
    );
  }
}
