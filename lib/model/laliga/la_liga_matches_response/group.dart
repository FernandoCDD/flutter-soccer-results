import 'dart:convert';

class LaLigaGroup {
  String? groupName;
  int? groupOrderId;
  int? groupId;

  LaLigaGroup({this.groupName, this.groupOrderId, this.groupId});

  factory LaLigaGroup.fromMap(Map<String, dynamic> data) => LaLigaGroup(
        groupName: data['groupName'] as String?,
        groupOrderId: data['groupOrderID'] as int?,
        groupId: data['groupID'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'groupName': groupName,
        'groupOrderID': groupOrderId,
        'groupID': groupId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LaLigaGroup].
  factory LaLigaGroup.fromJson(String data) {
    return LaLigaGroup.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LaLigaGroup] to a JSON string.
  String toJson() => json.encode(toMap());
}
