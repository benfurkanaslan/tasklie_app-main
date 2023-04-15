class UserModel {
  String name;
  String email;
  String photoUrl;
  String lastSeen;
  String createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.lastSeen,
    required this.createdAt,
  });

  @override
  String toString() {
    return '{name: $name, email: $email, photoUrl: $photoUrl, lastSeen: $lastSeen, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.name == name && other.email == email && other.photoUrl == photoUrl && other.lastSeen == lastSeen && other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ photoUrl.hashCode ^ lastSeen.hashCode ^ createdAt.hashCode;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      lastSeen: map['lastSeen'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
    };
  }
}
