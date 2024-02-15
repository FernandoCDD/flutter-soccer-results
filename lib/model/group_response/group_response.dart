import 'dart:convert';

class GroupResponse {
  String? groupName;
  int? groupOrderId;
  int? groupId;

  GroupResponse({this.groupName, this.groupOrderId, this.groupId});

  factory GroupResponse.fromMap(Map<String, dynamic> data) => GroupResponse(
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
  /// Parses the string and returns the resulting Json object as [GroupResponse].
  factory GroupResponse.fromJson(String data) {
    return GroupResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GroupResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
