import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTeamId = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTeamId = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soccer Results'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedTeamId,
        children: <Widget>[
          Image.network(
              'https://1000marcas.net/wp-content/uploads/2020/03/logo-German-Bundesliga.png'),
          Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/LaLiga_2023_Horizontal_Logo.svg/1200px-LaLiga_2023_Horizontal_Logo.svg.png')
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG4ayqrZg1P0IXNHnaUetdhiqyaXIrFxaP8pwBgzJ88IVgriuqGA8hHqMgqYE2UcQ3p50&usqp=CAU',
              fit: BoxFit.cover,
            ),
            label: 'Bundesliga',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'https://somosgravita.com/wp-content/uploads/2023/06/LALIGA_logotipo.jpg',
              fit: BoxFit.cover,
            ),
            label: 'Bundesliga',
          ),
        ],
        currentIndex: _selectedTeamId,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
