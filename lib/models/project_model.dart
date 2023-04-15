class ProjectModel {
  String groupName;
  String groupPhotoUrl;
  String groupCreatedBy;
  String groupCategory;
  List<String> groupMembers;
  String groupAdmin;

  ProjectModel({
    required this.groupName,
    required this.groupPhotoUrl,
    required this.groupCreatedBy,
    required this.groupCategory,
    required this.groupMembers,
    required this.groupAdmin,
  });
}
