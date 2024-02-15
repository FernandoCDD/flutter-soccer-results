import 'package:flutter/material.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';

class DetailsScreen extends StatelessWidget {
  final Journal journalSelected;
  const DetailsScreen({super.key, required this.journalSelected});

  @override
  Widget build(BuildContext context) {
    List<dynamic> goalsList = List.from(journalSelected.goals!);
    goalsList.sort((a, b) {
      var matchMinuteA = a['matchMinute'];
      var matchMinuteB = b['matchMinute'];

      // Manejar el caso de null
      if (matchMinuteA == null && matchMinuteB == null) {
        return 0;
      } else if (matchMinuteA == null) {
        return 0;
      } else if (matchMinuteB == null) {
        return 0;
      } else {
        return matchMinuteA.compareTo(matchMinuteB);
      }
    });

    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      journalSelected.team1!.teamIconUrl!,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                    Text(journalSelected.team1!.shortName!)
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    children: [
                      journalSelected.matchIsFinished!
                          ? Text(
                              '${journalSelected.matchResults?[1].pointsTeam1!} : ${journalSelected.matchResults?[1].pointsTeam2!}',
                              style: const TextStyle(fontSize: 40),
                            )
                          : Text(
                              journalSelected.matchDateTime!.substring(11, 16),
                              style: const TextStyle(fontSize: 30)),
                      Text(cambiarFormatoFecha(journalSelected.matchDateTime!),
                          style: const TextStyle(fontSize: 10))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      journalSelected.team2!.teamIconUrl!,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                    Text(journalSelected.team2!.shortName!)
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: goalsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: goalsList.length,
                        itemBuilder: (context, index) {
                          dynamic goal = goalsList[index];
                          int scoreTeam1 = goal['scoreTeam1'] ?? -1;
                          int scoreTeam2 = goal['scoreTeam2'] ?? -1;
                          int matchMinute = goal['matchMinute'] ?? 0;
                          String goalGetterName =
                              goal['goalGetterName'] ?? "unknown";

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$matchMinute\'',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.sports_soccer_rounded,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              goalGetterName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Resultado: $scoreTeam1 - $scoreTeam2',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No hay más información sobre el partido'),
                      )),
          ),
        ]));
  }
}

String cambiarFormatoFecha(String fecha) {
  DateTime fechaObjeto = DateTime.parse(fecha);

  List<String> nombresMeses = [
    'ENE.',
    'FEB.',
    'MAR.',
    'ABR.',
    'MAY.',
    'JUN.',
    'JUL.',
    'AGO.',
    'SEP.',
    'OCT.',
    'NOV.',
    'DIC.'
  ];

  String nombreMes = nombresMeses[fechaObjeto.month - 1];

  String nuevoFormato = '${fechaObjeto.day}$nombreMes ${fechaObjeto.year}';

  return nuevoFormato;
}
