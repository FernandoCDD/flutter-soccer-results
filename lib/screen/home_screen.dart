import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soccer_results/bloc/journal_bloc.dart';
import 'package:soccer_results/model/journal/journal.dart';
import 'package:soccer_results/repositories/journal_repository.dart';
import 'package:soccer_results/repositories/journal_repository_impl.dart';
import 'package:soccer_results/widget/result_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late JournalRepository journalRepository;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    journalRepository = JournalRepositoryImpl();
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
    return BlocProvider(
      create: (context) {
        return JournalBloc(journalRepository)..add(JournalsFetchEvent(11));
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Match List'),
            centerTitle: true,
          ),
          body: _matchView(context),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/LALIGA_logotipo.jpg',
                    height: 80,
                    width: 80,
                  ),
                  label: 'LA LIGA'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/Logo Bundes.png',
                    height: 80,
                    width: 80,
                  ),
                  label: 'BUNDESLIGA'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          )),
    );
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
                  context.watch<JournalBloc>().add(JournalsFetchEvent(20));
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
