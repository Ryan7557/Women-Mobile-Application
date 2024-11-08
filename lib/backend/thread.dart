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

class News {
  final String title;
  final String content;
  final String url;
  final String image;

  News({
    required this.title,
    required this.content,
    required this.url,
    required this.image,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No Title',
      content: json['description'] ?? 'No Content',
      url: json['url'] ?? '',
      image: json['urlToImage'] ?? 'https://placehold.co/200',
    );
  }
}

class EmpowermentStory {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  EmpowermentStory({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmpowermentStory.fromJson(Map<String, dynamic> json) {
    return EmpowermentStory(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      authorId: json['author_id'],
      authorName: json['author_name'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author_id': authorId,
      'author_name': authorName,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class EducationResource {
  final String id;
  final String title;
  final String description;
  final String category;
  final String url;
  final DateTime addedAt;

  EducationResource({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.category,
    required this.addedAt,
  });

  factory EducationResource.fromJson(Map<String, dynamic> json) {
    return EducationResource(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description available',
      url: json['url'] ?? '',
      category: json['category'] ?? 'General',
      addedAt: json['added_at'] != null ? DateTime.parse(json['added_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'category': category,
      'added_at': addedAt.toIso8601String(),
    };
  }
}
