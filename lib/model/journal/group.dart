import 'dart:convert';

class Group {
  String? groupName;
  int? groupOrderId;
  int? groupId;

  Group({this.groupName, this.groupOrderId, this.groupId});

  factory Group.fromMap(Map<String, dynamic> data) => Group(
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
  /// Parses the string and returns the resulting Json object as [Group].
  factory Group.fromJson(String data) {
    return Group.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Group] to a JSON string.
  String toJson() => json.encode(toMap());
}
