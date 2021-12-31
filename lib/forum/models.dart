const String domain = "https://tk-pbp-a01.herokuapp.com";

class Forum {
  final int id;
  final String author;
  final String title;
  final String desc;
  final String created;

  Forum(
      {required this.id,
      required this.author,
      required this.title,
      required this.created,
      required this.desc});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
        id: json['pk'],
        author: json['fields']['author'],
        title: json['fields']['title'],
        created: json['fields']['created'],
        desc: json['fields']['desc']);
  }
}

class Reply {
  final int id;
  final int parent;
  final String user;
  final String desc;

  Reply(
      {required this.id,
      required this.parent,
      required this.user,
      required this.desc});

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
        id: json['pk'],
        parent: json['fields']['parent'] ?? 0,
        user: json['fields']['user'],
        desc: json['fields']['desc']);
  }
}
