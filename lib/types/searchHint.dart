class SearchHint {
  int id;
  String title;
  String type;
  String image;

  SearchHint(this.id, this.title, this.type, this.image);

  SearchHint.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = json['type'],
        image = json['image']['original'];
}
