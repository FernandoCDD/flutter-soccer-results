import 'dart:convert';

import 'group.dart';
import 'match_result.dart';
import 'team1.dart';
import 'team2.dart';

class LaLigaJournals {
  int? matchId;
  String? matchDateTime;
  String? timeZoneId;
  int? leagueId;
  String? leagueName;
  int? leagueSeason;
  String? leagueShortcut;
  String? matchDateTimeUtc;
  LaLigaGroup? group;
  LaLigaTeam1? team1;
  LaLigaTeam2? team2;
  DateTime? lastUpdateDateTime;
  bool? matchIsFinished;
  List<LaLigaMatchesResults>? matchResults;
  List<dynamic>? goals;
  dynamic location;
  dynamic numberOfViewers;

  LaLigaJournals({
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

  factory LaLigaJournals.fromMap(Map<String, dynamic> data) {
    return LaLigaJournals(
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
          : LaLigaGroup.fromMap(data['group'] as Map<String, dynamic>),
      team1: data['team1'] == null
          ? null
          : LaLigaTeam1.fromMap(data['team1'] as Map<String, dynamic>),
      team2: data['team2'] == null
          ? null
          : LaLigaTeam2.fromMap(data['team2'] as Map<String, dynamic>),
      lastUpdateDateTime: data['lastUpdateDateTime'] == null
          ? null
          : DateTime.parse(data['lastUpdateDateTime'] as String),
      matchIsFinished: data['matchIsFinished'] as bool?,
      matchResults: (data['matchResults'] as List<dynamic>?)
          ?.map((e) => LaLigaMatchesResults.fromMap(e as Map<String, dynamic>))
          .toList(),
      goals: data['goals'] as List<dynamic>?,
      location: data['location'] as dynamic,
      numberOfViewers: data['numberOfViewers'] as dynamic,
    );
  }

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
  /// Parses the string and returns the resulting Json object as [LaLigaJournals].
  factory LaLigaJournals.fromJson(String data) {
    return LaLigaJournals.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LaLigaJournals] to a JSON string.
  String toJson() => json.encode(toMap());
}
