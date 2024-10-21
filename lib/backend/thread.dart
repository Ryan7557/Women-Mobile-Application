class Thread {
  final String id;
  final String title;
  final DateTime createdAt;
  final User user; // Use supabase_flutter.User

  Thread({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.user,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']), // Use supabase_flutter.User.fromJson
    );
  }
  @override
  String toString() {
    return 'Thread(id: $id, title: $title, createdAt: $createdAt, user: $user)';
  }
}

class User {
  final String id;
  final String email;
  final String username;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username, createdAt: $createdAt)';
  }
}

class Comment {
  final String id;
  final String threadId;
  final String userId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.threadId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      threadId: json['thread_id'],
      userId: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thread_id': threadId,
      'user_id': userId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Category {
  final String id;
  final String name;
  final String? description;

  Category({required this.id, required this.name, this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'], name: json['name'], description: json['description']);
  }
}
