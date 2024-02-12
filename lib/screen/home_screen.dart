import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_results/bloc/journal_bloc.dart';
import 'package:soccer_results/model/journal/journal.dart';
import 'package:soccer_results/repositories/journal_repository.dart';
import 'package:soccer_results/repositories/journal_repository_impl.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late JournalBloc _journalBloc;
  late JournalRepository journalRepository;
  int dropdownValue = season.first;

  @override
  void initState() {
    super.initState();
    journalRepository = JournalRepositoryImpl();
    _journalBloc = JournalBloc(journalRepository)
      ..add(JournalsFetchEvent(20, dropdownValue));
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
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                    _journalBloc.add(JournalsFetchEvent(20, dropdownValue));
                    //Navigator.pop(context);
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
    return BlocBuilder<JournalBloc, JournalState>(
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
                      .add(JournalsFetchEvent(20, dropdownValue));
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
}
