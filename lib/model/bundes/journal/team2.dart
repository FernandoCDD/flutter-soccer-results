import 'dart:convert';

class Team2 {
  int? teamId;
  String? teamName;
  String? shortName;
  String? teamIconUrl;
  dynamic teamGroupName;

  Team2({
    this.teamId,
    this.teamName,
    this.shortName,
    this.teamIconUrl,
    this.teamGroupName,
  });

  factory Team2.fromMap(Map<String, dynamic> data) => Team2(
        teamId: data['teamId'] as int?,
        teamName: data['teamName'] as String?,
        shortName: data['shortName'] as String?,
        teamIconUrl: data['teamIconUrl'] as String?,
        teamGroupName: data['teamGroupName'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'teamId': teamId,
        'teamName': teamName,
        'shortName': shortName,
        'teamIconUrl': teamIconUrl,
        'teamGroupName': teamGroupName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Team2].
  factory Team2.fromJson(String data) {
    return Team2.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Team2] to a JSON string.
  String toJson() => json.encode(toMap());
}
