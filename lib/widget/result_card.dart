import 'package:flutter/material.dart';
import 'package:soccer_results/model/bundes/journal/journal.dart';
import 'package:soccer_results/screen/details_match.dart';

class ResultCard extends StatefulWidget {
  final Journal journal;
  const ResultCard({super.key, required this.journal});

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
            color: Color.fromARGB(255, 177, 176, 176), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.network(
                          widget.journal.team1!.teamIconUrl!,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                      ),
                      Text(
                        widget.journal.team1!.shortName!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.journal.matchResults?[1].pointsTeam1!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.network(
                          widget.journal.team2!.teamIconUrl!,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                      ),
                      Text(
                        widget.journal.team2!.shortName!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.journal.matchResults?[1].pointsTeam2!}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 1, // Ancho de la barra
              height: 70, // Altura de la barra (ajusta según tus necesidades)
              color: Colors.grey, // Color de la barra
              margin: const EdgeInsets.symmetric(
                  horizontal: 8), // Margen horizontal
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 8.0)),
                Text(cambiarFormatoFecha(widget.journal.matchDateTime!),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                const Padding(padding: EdgeInsets.only(top: 8.0)),
                Text(
                    widget.journal.matchIsFinished!
                        ? 'Fin del partido'
                        : '${widget.journal.matchDateTime}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 138, 138, 138))),
                const Padding(padding: EdgeInsets.only(top: 8.0)),
              ],
            )
          ],
        ),
      ),
    );
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
/*
 return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  DetailsScreen(journalSelected: widget.journal),
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(widget.journal.group!.groupName!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              widget.journal.team1!.teamIconUrl!,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                          Text(widget.journal.team1!.shortName!)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          '${widget.journal.matchResults?[1].pointsTeam1!} : ${widget.journal.matchResults?[1].pointsTeam2!}',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              widget.journal.team2!.teamIconUrl!,
                              errorBuilder: (context, error, stackTrace) {
                                // Manejar el error de carga de la imagen aquí
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                          Text(widget.journal.team1!.shortName!)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ); 
*/

