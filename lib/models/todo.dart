import 'dart:convert';

class Todo {
  int id;
  String content;
  bool isDone;

  Todo({
    required this.id,
    required this.content,
    required this.isDone,
  });

  Todo copyWith({
    int? id,
    String? content,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      content: content ?? this.content,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      content: map['content'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Todo(id: $id, content: $content, isDone: $isDone)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => id.hashCode ^ content.hashCode ^ isDone.hashCode;
}