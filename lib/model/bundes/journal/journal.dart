import 'dart:convert';

import 'group.dart';
import 'match_result.dart';
import 'team1.dart';
import 'team2.dart';

class Journal {
  int? matchId;
  String? matchDateTime;
  String? timeZoneId;
  int? leagueId;
  String? leagueName;
  int? leagueSeason;
  String? leagueShortcut;
  String? matchDateTimeUtc;
  Group? group;
  Team1? team1;
  Team2? team2;
  DateTime? lastUpdateDateTime;
  bool? matchIsFinished;
  List<MatchResult>? matchResults;
  List<dynamic>? goals;
  dynamic location;
  dynamic numberOfViewers;

  Journal({
    this.matchId,
    this.matchDateTime,
    this.timeZoneId,
    this.leagueId,
    this.leagueName,
    this.leagueSeason,
    this.leagueShortcut,
    this.matchDateTimeUtc,
    this.group,
    this.team1,
    this.team2,
    this.lastUpdateDateTime,
    this.matchIsFinished,
    this.matchResults,
    this.goals,
    this.location,
    this.numberOfViewers,
  });

  factory Journal.fromMap(Map<String, dynamic> data) => Journal(
        matchId: data['matchID'] as int?,
        matchDateTime: data['matchDateTime'] as String?,
        timeZoneId: data['timeZoneID'] as String?,
        leagueId: data['leagueId'] as int?,
        leagueName: data['leagueName'] as String?,
        leagueSeason: data['leagueSeason'] as int?,
        leagueShortcut: data['leagueShortcut'] as String?,
        matchDateTimeUtc: data['matchDateTimeUTC'] as String?,
        group: data['group'] == null
            ? null
            : Group.fromMap(data['group'] as Map<String, dynamic>),
        team1: data['team1'] == null
            ? null
            : Team1.fromMap(data['team1'] as Map<String, dynamic>),
        team2: data['team2'] == null
            ? null
            : Team2.fromMap(data['team2'] as Map<String, dynamic>),
        lastUpdateDateTime: data['lastUpdateDateTime'] == null
            ? null
            : DateTime.parse(data['lastUpdateDateTime'] as String),
        matchIsFinished: data['matchIsFinished'] as bool?,
        matchResults: (data['matchResults'] as List<dynamic>?)
            ?.map((e) => MatchResult.fromMap(e as Map<String, dynamic>))
            .toList(),
        goals: data['goals'] as List<dynamic>?,
        location: data['location'] as dynamic,
        numberOfViewers: data['numberOfViewers'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'matchID': matchId,
        'matchDateTime': matchDateTime,
        'timeZoneID': timeZoneId,
        'leagueId': leagueId,
        'leagueName': leagueName,
        'leagueSeason': leagueSeason,
        'leagueShortcut': leagueShortcut,
        'matchDateTimeUTC': matchDateTimeUtc,
        'group': group?.toMap(),
        'team1': team1?.toMap(),
        'team2': team2?.toMap(),
        'lastUpdateDateTime': lastUpdateDateTime?.toIso8601String(),
        'matchIsFinished': matchIsFinished,
        'matchResults': matchResults?.map((e) => e.toMap()).toList(),
        'goals': goals,
        'location': location,
        'numberOfViewers': numberOfViewers,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Journal].
  factory Journal.fromJson(String data) {
    return Journal.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Journal] to a JSON string.
  String toJson() => json.encode(toMap());
}
