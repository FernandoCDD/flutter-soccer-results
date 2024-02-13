import 'package:flutter/material.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';

class DetailsScreen extends StatelessWidget {
  final Journal journalSelected;
  const DetailsScreen({super.key, required this.journalSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
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
              Center(
                child: Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        '${journalSelected.matchResults?[1].pointsTeam1!} : ${journalSelected.matchResults?[1].pointsTeam2!}',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(cambiarFormatoFecha(journalSelected.matchDateTime!),
                          style: TextStyle(fontSize: 10))
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
                        // Manejar el error de carga de la imagen aquí
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .grey, // O cualquier otro widget que desees mostrar en lugar de la imagen
                          child: const Icon(Icons
                              .error), // O cualquier otro widget que desees mostrar en lugar de la imagen
                        );
                      },
                    ),
                    Text(journalSelected.team2!.shortName!)
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
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
                child: ListView.builder(
                  itemCount: journalSelected.goals!.length,
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
                      .     add(JournalsFetchEvent(journalValue, seasonValue));
                        isPressed = false;
                        Navigator.pop(context);
                },
              );
            });
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      journalSelected.team2!.teamIconUrl!,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        // Manejar el error de carga de la imagen aquí
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors
                              .grey, // O cualquier otro widget que desees mostrar en lugar de la imagen
                          child: const Icon(Icons
                              .error), // O cualquier otro widget que desees mostrar en lugar de la imagen
                        );
                      },
                    ),
                    Text(journalSelected.team2!.shortName!)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

String cambiarFormatoFecha(String fecha) {
  // Parseamos la cadena de fecha a un objeto DateTime
  DateTime fechaObjeto = DateTime.parse(fecha);

  // Creamos una lista con los nombres de los meses en español
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

  // Obtenemos el nombre del mes correspondiente
  String nombreMes = nombresMeses[fechaObjeto.month - 1];

  // Formateamos la fecha en el nuevo formato
  String nuevoFormato = '${fechaObjeto.day}$nombreMes ${fechaObjeto.year}';

  return nuevoFormato;
}
