import 'package:flutter/material.dart';
import 'package:soccer_results/screen/bundesliga_results.dart';
import 'package:soccer_results/screen/laliga_results_page.dart';

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

  static const List<Widget> _widgetOptions = <Widget>[
    BundesligaResultsPage(),
    LaLigaResultsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Results'),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/Logo Bundes.png',
              height: 30,
              width: 30,
            ),
            label: 'Bundesliga',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/laliga.png',
              height: 30,
              width: 30,
            ),
            label: 'La Liga',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
