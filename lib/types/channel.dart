import 'package:intl/intl.dart';
import 'package:musicbox/types/category.dart';

class Channel {
  int id;
  String title;
  String description;
  String formattedDescription;
  DateTime createdAt;
  DateTime updatedAt;
  String webUrl;
  String logo;
  String banner;
  Category category;

  Channel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        formattedDescription = json['formatted_description'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        webUrl = json['urls']['web_url'],
        logo = json['urls']['logo_image']['original'],
        banner = json['urls']['banner_image']['original'],
        category = Category.fromJson(json['category']);

  String getCreatedString() {
    return DateFormat('dd-MM-yyyy').format(createdAt);
  }

  String getUpdatedString() {
    // return DateFormat("dd-MM-yy - kk:mm").format(updatedAt);
    return DateFormat("dd-MM-yyyy").format(updatedAt);
  }
}
