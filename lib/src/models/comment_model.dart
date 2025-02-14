class CommentModel {
  String target;
  String id;
  String content;
  String userId;
  dynamic createdAt;
  
  CommentModel.fromJson(Map<String, dynamic> parsedJson) {
    target = parsedJson['target'];
    content = parsedJson['content'];
  }

  CommentModel.fromSnapshot(dynamic snapshot) {
    target = snapshot.target;
    id = snapshot.documentID;
    content = snapshot['content'];
    userId = snapshot['userId'];
  }

  Map<String, dynamic> toJson() {
    return {
      "target": target,
      "content": content,
      "userId": userId,
      "createdAt": createdAt,
    };
  }
}