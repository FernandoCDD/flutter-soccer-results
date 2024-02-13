import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_results/bloc/journal_bloc.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository_impl.dart';
import 'package:soccer_results/screen/home_screen.dart';
import 'package:soccer_results/widget/result_card.dart';

class LaLigaResultsPage extends StatefulWidget {
  const LaLigaResultsPage({super.key});

  @override
  State<LaLigaResultsPage> createState() => _LaLigaResultsPageState();
}

class _LaLigaResultsPageState extends State<LaLigaResultsPage> {
  late JournalRepository journalRepository;
  late LaLigaJournalBloc _journalBloc;
  int seasonValue = season.first;
  int journalValue = journal.first;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    journalRepository = JournalRepositoryImpl();
    _journalBloc = LaLigaJournalBloc(journalRepository)
      ..add(JournalsFetchEvent(journalValue, seasonValue));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _journalBloc,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Match List'),
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
          ),
          body: _matchView(context),
        ));
  }

  Widget _matchView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPressed = !isPressed;
                    if (isPressed) {
                      _showBottomSheet(context);
                    }
                  });
                },
                child: Icon(
                  isPressed ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<LaLigaJournalBloc, JournalState>(
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
                            .watch<LaLigaJournalBloc>()
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
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return ListView.builder(
            itemCount: journal.length,
            itemBuilder: (context, index) {
              int journalIndex = journal[index];
              return ListTile(
                title: Text(
                  'Jornada $journalIndex',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  setState(() {
                    journalValue = journalIndex;
                  });
                  _journalBloc
                      .add(JournalsFetchEvent(journalValue, seasonValue));
                  isPressed = false;
                  Navigator.pop(context);
                },
              );
            });
      },
    );
  }
}
