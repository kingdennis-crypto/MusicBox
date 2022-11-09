class Category {
  int id;
  String title;
  String? description;
  String updatedAt;

  Category(this.id, this.title, this.description, this.updatedAt);

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? json['id'],
        title = json['title'],
        description = json['description'],
        updatedAt = json['updated_at'];

  @override
  String toString() {
    return "$title with id: $id";
  }
  // Map<String, dynamic> toJson() => {
  //       "id" = this.id,
  //       "title" = this.title
  //     };

  // User.fromJson(Map<String, dynamic> json)
  // : name = json['name'],
  //   email = json['email'];

  // Category({required this.title, required this.artist});
}
