import 'dart:convert';

class LaLigaMatchesResults {
  int? resultId;
  String? resultName;
  int? pointsTeam1;
  int? pointsTeam2;
  int? resultOrderId;
  int? resultTypeId;
  String? resultDescription;

  LaLigaMatchesResults({
    this.resultId,
    this.resultName,
    this.pointsTeam1,
    this.pointsTeam2,
    this.resultOrderId,
    this.resultTypeId,
    this.resultDescription,
  });

  factory LaLigaMatchesResults.fromMap(Map<String, dynamic> data) =>
      LaLigaMatchesResults(
        resultId: data['resultID'] as int?,
        resultName: data['resultName'] as String?,
        pointsTeam1: data['pointsTeam1'] as int?,
        pointsTeam2: data['pointsTeam2'] as int?,
        resultOrderId: data['resultOrderID'] as int?,
        resultTypeId: data['resultTypeID'] as int?,
        resultDescription: data['resultDescription'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'resultID': resultId,
        'resultName': resultName,
        'pointsTeam1': pointsTeam1,
        'pointsTeam2': pointsTeam2,
        'resultOrderID': resultOrderId,
        'resultTypeID': resultTypeId,
        'resultDescription': resultDescription,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LaLigaMatchesResults].
  factory LaLigaMatchesResults.fromJson(String data) {
    return LaLigaMatchesResults.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LaLigaMatchesResults] to a JSON string.
  String toJson() => json.encode(toMap());
}
