class Griv {
  String title;
  String desc;
  int id;

  Griv({this.id, this.title, this.desc});

  Map<String, dynamic> toDatabaseJson() => {
        'id': id,
        'title': title,
        'desc': desc,
      };

  static Griv fromDatabaseJson(Map<String, dynamic> data) {
    return Griv(id: data['id'], title: data["title"], desc: data["desc"]);
  }
}
