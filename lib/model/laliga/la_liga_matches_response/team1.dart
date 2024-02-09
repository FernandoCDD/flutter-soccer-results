import 'dart:convert';

class LaLigaTeam1 {
  int? teamId;
  String? teamName;
  String? shortName;
  String? teamIconUrl;
  dynamic teamGroupName;

  LaLigaTeam1({
    this.teamId,
    this.teamName,
    this.shortName,
    this.teamIconUrl,
    this.teamGroupName,
  });

  factory LaLigaTeam1.fromMap(Map<String, dynamic> data) => LaLigaTeam1(
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
  /// Parses the string and returns the resulting Json object as [LaLigaTeam1].
  factory LaLigaTeam1.fromJson(String data) {
    return LaLigaTeam1.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LaLigaTeam1] to a JSON string.
  String toJson() => json.encode(toMap());
}
