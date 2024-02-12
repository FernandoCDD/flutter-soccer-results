import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_results/bloc/journal_bloc.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository.dart';
import 'package:soccer_results/repositories/bundesliga/journal_repository_impl.dart';
import 'package:soccer_results/widget/result_card.dart';

const List<int> season = <int>[
  2023,
  2022,
  2021,
  2020,
  2019,
  2018,
  2017,
  2016,
  2015
];

const List<int> journal = <int>[
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late JournalBloc _journalBloc;
  late JournalRepository journalRepository;
  int seasonValue = season.first;
  int journalValue = journal.first;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    journalRepository = JournalRepositoryImpl();
    _journalBloc = JournalBloc(journalRepository)
      ..add(JournalsFetchEvent(journalValue, seasonValue));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          child: BlocBuilder<JournalBloc, JournalState>(
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
                            .watch<JournalBloc>()
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
