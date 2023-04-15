import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TaskModel {
  String teamName;
  String taskDescription;
  String taskStatus;
  String projectDocName;
  String teamId;
  Timestamp taskStartDate;
  Timestamp taskEndDate;
  List<dynamic> taskMembers;
  List<dynamic> taskMembersName;
  List<dynamic> taskMembersPhotoUrl;
  int taskMembersCount;

  TaskModel({
    required this.teamName,
    required this.taskDescription,
    required this.taskStatus,
    required this.projectDocName,
    required this.teamId,
    required this.taskStartDate,
    required this.taskEndDate,
    required this.taskMembers,
    required this.taskMembersName,
    required this.taskMembersPhotoUrl,
    required this.taskMembersCount,
  });

  @override
  String toString() {
    return '{teamName: $teamName, taskDescription: $taskDescription, taskStartDate: $taskStartDate, taskEndDate: $taskEndDate, taskStatus: $taskStatus, projectDocName: $projectDocName, teamId: $teamId, taskMembers: $taskMembers, taskMembersName: $taskMembersName, taskMembersPhotoUrl: $taskMembersPhotoUrl, taskMembersCount: $taskMembersCount}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.teamName == teamName &&
        other.taskDescription == taskDescription &&
        other.taskStartDate == taskStartDate &&
        other.taskEndDate == taskEndDate &&
        other.projectDocName == projectDocName &&
        other.teamId == teamId &&
        other.taskStatus == taskStatus &&
        listEquals(other.taskMembers, taskMembers) &&
        listEquals(other.taskMembersName, taskMembersName) &&
        listEquals(other.taskMembersPhotoUrl, taskMembersPhotoUrl) &&
        other.taskMembersCount == taskMembersCount;
  }

  @override
  int get hashCode {
    return teamName.hashCode ^
        taskDescription.hashCode ^
        taskStartDate.hashCode ^
        taskEndDate.hashCode ^
        projectDocName.hashCode ^
        teamId.hashCode ^
        taskStatus.hashCode ^
        taskMembers.hashCode ^
        taskMembersName.hashCode ^
        taskMembersPhotoUrl.hashCode ^
        taskMembersCount.hashCode;
  }
}
