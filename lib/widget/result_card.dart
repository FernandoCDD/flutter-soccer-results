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
  }
}
